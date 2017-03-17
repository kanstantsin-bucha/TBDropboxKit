//
//  TBDropboxSnapshot.m
//  Pods
//
//  Created by Bucha Kanstantsin on 2/3/17.
//
//

#import "TBDropboxWatchdog.h"
#import "TBDropboxFolderEntry.h"

#define TBDropboxWatchdog_Cursor_Key @"TBDropboxWatchdog_Cursor_Key=TBDropboxCursor.NSString"

typedef void (^TBPendingChangesCompletion) (NSArray * _Nullable changes,
                                            TBDropboxCursor * _Nullable cursor,
                                            NSError * _Nullable error);

@interface TBDropboxWatchdog ()

@property (weak, nonatomic, readwrite, nullable) id<TBDropboxClientSource> routesSource;
@property (strong, nonatomic, nullable) DBRpcTask * pendingChangesTask;
@property (strong, nonatomic, nullable) DBRpcTask * wideAwakeTask;
@property (strong, nonatomic, readonly, nullable) DBFILESRoutes * fileRoutes;
@property (strong, nonatomic, readwrite) TBDropboxCursor * cursor;
@property (assign, nonatomic, readwrite) TBDropboxWatchdogState state;
@property (strong, nonatomic) NSString * sessionID;

@end


@implementation TBDropboxWatchdog

@synthesize cursor = _cursor;

/// MARK: - property -

- (DBFILESRoutes *)fileRoutes {
    DBFILESRoutes * result = [self.routesSource filesRoutes];
    return result;
}

- (TBDropboxCursor *)cursor {
    if (_cursor != nil) {
        return _cursor;
    }
    _cursor = [self loadCursorUsingSessionID: self.sessionID];
    return _cursor;
}

- (void)setCursor:(TBDropboxCursor *)cursor {
    if ([_cursor isEqualToString:cursor]) {
        return;
    }
    
    _cursor = cursor;
    [self saveCursor:cursor
      usingSessionID:self.sessionID];
}

- (void)setState:(TBDropboxWatchdogState)state {
    if (_state == state) {
        return;
    }
    
    _state = state;
    [self notifyThatDidChangeStateTo: state];
}

/// MARK: - life cycle -

- (instancetype)initInstance {
    if (self = [super init]) {
    }
    return self;
}

+ (instancetype)watchdogUsingSource:(id<TBDropboxClientSource>)source {
    if (source == nil) {
        return nil;
    }
    
    TBDropboxWatchdog * result = [[[self class] alloc] initInstance];
    result.routesSource = source;
    result.sessionID = source.sessionID;
    
    return result;
}

/// MARK: - public -

- (void)resume {
    BOOL couldResume = self.state == TBDropboxWatchdogStateUndefined
                       || self.state == TBDropboxWatchdogStatePaused;
    if (couldResume == NO) {
        return;
    }
    
    self.state = TBDropboxWatchdogStateUndefined;
    
    if (self.cursor != nil) {
        [self startWideAwake];
        return;
    }
    
    [self processPendingChanges];
}

- (void)pause {
    if (self.state == TBDropboxQueueStatePaused) {
        return;
    }
    
    [self.pendingChangesTask suspend];
    self.pendingChangesTask = nil;
    
    [self.wideAwakeTask suspend];
    self.wideAwakeTask = nil;
    
    self.state = TBDropboxWatchdogStatePaused;
}

- (void)resetCursor {
    BOOL shouldResume = self.state == TBDropboxWatchdogStateResumedProcessingChanges
                        || self.state == TBDropboxWatchdogStateResumedWideAwake;
    [self pause];
    
    self.cursor = nil;
    
    if (shouldResume) {
        [self resume];
    }
}

/// MARK: - private -

- (void)processPendingChanges {
    if (self.state == TBDropboxWatchdogStatePaused) {
        return;
    }
    
    self.state = TBDropboxWatchdogStateResumedProcessingChanges;
    
    weakCDB(wself);
    [self processPendingChangesPreviosChanges: nil
                                       cursor: self.cursor
                                   completion:^(NSArray * _Nullable changes,
                                                TBDropboxCursor * _Nullable cursor,
                                                NSError * _Nullable error) {
        if (error != nil) {
            [wself scheduleProcessPendingChanges];
            return;
        }
        
        [wself notePendingChanges: changes];
        wself.cursor = cursor;
    
        if (wself.state == TBDropboxWatchdogStateResumedProcessingChanges) {
            [self tryBeWideAwake];
        }

    }];
}

- (void)scheduleProcessPendingChanges {
    weakCDB(wself);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        [wself processPendingChanges];
    });
}

- (void)processPendingChangesPreviosChanges:(NSArray *)changes
                                     cursor:(TBDropboxCursor *)cursor
                                 completion:(TBPendingChangesCompletion _Nonnull)completion {
    if (cursor != nil) {
        self.pendingChangesTask = [self.fileRoutes listFolderContinue: cursor];
    } else {
        self.pendingChangesTask =
            [self.fileRoutes listFolder: TBDropboxFolderEntry_Root_Folder_Path
                              recursive: @(YES)
                       includeMediaInfo: @(YES)
                         includeDeleted: @(YES)
        includeHasExplicitSharedMembers: @(NO)];
    }
    
    weakCDB(wself);
    [self.pendingChangesTask setResponseBlock:^(DBFILESListFolderResult * response,
                                                id  _Nullable routeError,
                                                DBRequestError * _Nullable error) {
        wself.pendingChangesTask = nil;
        
        if (error != nil) {
            completion(nil, nil, error);
        }
        
        NSMutableArray * gatheredChanges = [NSMutableArray array];
        if (changes != nil) {
            [gatheredChanges addObjectsFromArray: changes];
        }
        if (response.entries != nil) {
            [gatheredChanges addObjectsFromArray: response.entries];
        }
        
        if (response.hasMore.boolValue == NO) {
            wself.cursor = response.cursor;
            completion(gatheredChanges, response.cursor, error);
            return;
        }
        
        [wself processPendingChangesPreviosChanges: gatheredChanges
                                            cursor: response.cursor
                                        completion: completion];
    }];
    
    [self.pendingChangesTask start];
}

- (void)tryBeWideAwake {
    BOOL canDo = YES;
    
    SEL selector = @selector(watchdogCouldBeWideAwake:);
    if ([self.delegate respondsToSelector: selector]) {
        canDo = [self.delegate watchdogCouldBeWideAwake: self];
    }
    
    if (canDo == NO) {
        self.state = TBDropboxWatchdogStatePaused;
        return;
    }
    
    [self startWideAwake];
}

- (void)startWideAwake {
    if (self.state == TBDropboxWatchdogStatePaused) {
        return;
    }
    
    self.state = TBDropboxWatchdogStateResumedWideAwake;
    self.wideAwakeTask = [self.fileRoutes listFolderLongpoll: self.cursor];
    weakCDB(wself);
    [self.wideAwakeTask setResponseBlock:^(id  _Nullable response,
                                           id  _Nullable routeError,
                                           DBRequestError * _Nullable error) {
        wself.wideAwakeTask = nil;
        [wself processPendingChanges];
    }];
    
    [self.wideAwakeTask start];
}

/// MAKR: notify delegate

- (void)notifyThatDidChangeStateTo:(TBDropboxQueueState)state {
    SEL selector = @selector(watchdog:didChangeStateTo:);
    if ([self.delegate respondsToSelector: selector]) {
        [self.delegate watchdog: self
               didChangeStateTo: state];
    }
}

- (void)notePendingChanges:(NSArray *)changes {
    SEL selector = @selector(watchdog:didCollectPendingChanges:);
    if ([self.delegate respondsToSelector: selector]) {
        [self.delegate watchdog: self
       didCollectPendingChanges: changes];
    }
}

- (TBDropboxCursor *)loadCursorUsingSessionID:(NSString *)tokenUID {
    NSString * cursorKey =
        [self cursorStoringKeyUsingSessionID: tokenUID];
    TBDropboxCursor * result =
        [[NSUserDefaults standardUserDefaults] objectForKey: cursorKey];
    return result;
}

- (void)saveCursor:(TBDropboxCursor *)cursor
    usingSessionID:(NSString *)sessionID {
    NSString * cursorKey =
        [self cursorStoringKeyUsingSessionID: sessionID];
    [[NSUserDefaults standardUserDefaults] setObject: cursor
                                              forKey: cursorKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)cursorStoringKeyUsingSessionID:(NSString *)sessionID {
    NSString * result = [NSString stringWithFormat:@"%@+%@",
                         TBDropboxWatchdog_Cursor_Key,
                         sessionID];
    return result;
}
@end
