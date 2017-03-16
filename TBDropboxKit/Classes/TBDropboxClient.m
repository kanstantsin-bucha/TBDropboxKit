//
//  TBDropboxDocuments.m
//  Pods
//
//  Created by Bucha Kanstantsin on 12/29/16.
//
//

#import "TBDropboxClient.h"
#import "TBDropboxConnection+Private.h"
#import <CDBDelegateCollection/CDBDelegateCollection.h>
#import "TBDropboxChange.h"
#import "TBDropboxChangesProcessor.h"

@interface TBDropboxClient ()
<
    TBDropboxConnectionDelegate,
    TBDropboxClientSource,
    TBDropboxWatchdogDelegate,
    TBDropboxQueueDelegate
>

@property (weak, nonatomic, readwrite) TBDropboxConnection * connection;
@property (strong, nonatomic, readonly) DBUserClient * client;
@property (strong, nonatomic, readwrite, nonnull) TBDropboxQueue * tasksQueue;
@property (strong, nonatomic, readwrite, nonnull) TBDropboxWatchdog * watchdog;
@property (strong, nonatomic) CDBDelegateCollection * delegates;
@property (strong, nonatomic, readwrite) NSString * sessionID;

@property (strong, nonatomic) NSDictionary * outgoingChanges;

@end


@implementation TBDropboxClient

/// MARK: property

- (void)setConnectionDesired:(BOOL)connectionDesired {
    if (_connectionDesired == connectionDesired) {
        return;
    }
    
    _connectionDesired = connectionDesired;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_connectionDesired) {
            [self.connection openConnection];
        } else {
            [self.connection pauseConnection];
            self.watchdog = nil;
            self.tasksQueue = nil;
        }
    });
}

- (DBUserClient *)client {
    DBUserClient * result = [DBClientsManager authorizedClient];
    NSAssert(result != nil, @"[ERROR] Dropbox Client should never be nil!");
    return result;
}

- (TBDropboxQueue *)tasksQueue {
    if (_tasksQueue != nil) {
        return _tasksQueue;
    }
    
    _tasksQueue = [TBDropboxQueue queueUsingSource: self];
    _tasksQueue.delegate = self;
    return _tasksQueue;
}

- (TBDropboxWatchdog *)watchdog {
    if (_watchdog != nil) {
        return _watchdog;
    }
    
    _watchdog = [TBDropboxWatchdog watchdogUsingSource: self];
    _watchdog.delegate = self;
    return _watchdog;
}

- (CDBDelegateCollection *)delegates {
    if (_delegates != nil) {
        return _delegates;
    }
    
    _delegates =
        [[CDBDelegateCollection alloc] initWithProtocol:@protocol(TBDropboxClientDelegate)];
    return _delegates;
}

- (void)setWatchdogEnabled:(BOOL)watchdogEnabled {
    if (_watchdogEnabled == watchdogEnabled) {
        return;
    }
    _watchdogEnabled = watchdogEnabled;
    if (_watchdogEnabled) {
        if (self.connection.state == TBDropboxConnectionStateConnected
            && self.tasksQueue.state == TBDropboxQueueStateResumedNoLoad) {
            [self.watchdog resume];
        }
    } else {
        [self.watchdog pause];
    }
}

/// MARK: life cycle

+ (instancetype)sharedInstance {
    static TBDropboxClient * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[super allocWithZone:NULL] initInstance];
    });
    
    return _sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return self;
}

- (instancetype)initInstance {
    if (self = [super init]) {
    }
    return self;
}


- (void)initiateWithConnectionDesired:(BOOL)desired
                          usingAppKey:(NSString *)key {
    TBDropboxConnection * connection = [TBDropboxConnection connectionUsingAppKey: key
                                                                         delegate: self];
    self.connection = connection;
    self.connectionDesired = desired;
    self.sessionID = self.connection.accessTokenUID;
}

/// MARK: protocols

/// MARK: TBDropboxConnectionDelegate

- (void)dropboxConnection:(TBDropboxConnection * _Nonnull)connection
         didChangeStateTo:(TBDropboxConnectionState)state {
    if (state == TBDropboxConnectionStateConnected) {
        [self.tasksQueue resume];
    } else {
        [self.tasksQueue pause];
    }
    
    SEL selector = @selector(dropboxConnection:
                              didChangeStateTo:);
    [self.delegates enumerateDelegatesRespondToSelector: selector
                                             usingBlock: ^(id<TBDropboxConnectionDelegate> delegate, BOOL *stop) {
        [delegate dropboxConnection: connection
                   didChangeStateTo: state];
    }];
}

- (void)dropboxConnection:(TBDropboxConnection * _Nonnull)connection
     didChangeAuthStateTo:(TBDropboxAuthState)state
                withError:(NSError * _Nullable)error {
    
    SEL selector = @selector(dropboxConnection:
                          didChangeAuthStateTo:
                                     withError:);
    [self.delegates enumerateDelegatesRespondToSelector: selector
                                             usingBlock: ^(id<TBDropboxConnectionDelegate> delegate, BOOL *stop) {
        [delegate dropboxConnection: connection
               didChangeAuthStateTo: state
                          withError: error];
    }];
}

- (void)dropboxConnection:(TBDropboxConnection *)connection
       didChangeSessionID:(NSString *)sessionID {
    if (sessionID == nil) {
        return;
    }
    
    [self switchToDifferentSession: sessionID];
}

/// MARK: TBDropboxWatchdogDelegate

- (void)watchdog:(TBDropboxWatchdog *)watchdog
didChangeStateTo:(TBDropboxWatchdogState)state {
    SEL selector = @selector(watchdog:
                             didChangeStateTo:);
    [self.delegates enumerateDelegatesRespondToSelector: selector
                                             usingBlock: ^(id<TBDropboxWatchdogDelegate> delegate, BOOL *stop) {
        [delegate watchdog: watchdog
          didChangeStateTo: state];
    }];
}

- (void)watchdog:(TBDropboxWatchdog *)watchdog
    didCollectPendingChanges:(NSArray *)changes {
    if (self.connection.state == TBDropboxConnectionStateConnected) {
        [self.tasksQueue resume];
    }
    
    NSArray * incomingChanges = nil;
    if (self.outgoingChanges.count == 0) {
        incomingChanges = changes;
    } else {
        incomingChanges =
            [TBDropboxChangesProcessor processMetadataChanges: changes
                                          byExcludingOutgoing: self.outgoingChanges];
    }
    
    [self provideIncomingMetadataChanges: incomingChanges];
}

- (BOOL)watchdogCouldBeWideAwake:(TBDropboxWatchdog *)watchdog {
    BOOL result = self.tasksQueue.hasPendingTasks == NO;
    return result;
}


/// MARK: TBDropboxQueueDelegate

- (void)queue:(TBDropboxQueue *)queue
    didChangeStateTo:(TBDropboxQueueState)state {
    if (state == TBDropboxQueueStateResumedProcessing) {
        [self.watchdog pause];
    }
    if (state == TBDropboxQueueStateResumedNoLoad) {
        [self.watchdog resume];
    }
}

- (void)queue:(TBDropboxQueue *)queue
    didFinishBatchOfTasks:(NSArray *)tasks {
    if (self.watchdogEnabled) {
        [self.tasksQueue pause];
        
        self.outgoingChanges =
            [TBDropboxChangesProcessor outgoingMetadataChangesUsingTasks: tasks];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.watchdog resume];
        });
        
    }
}

- (void)queue:(TBDropboxQueue *)queue
    didReceiveAuthError:(NSError *)error {
    [self.tasksQueue pause];
    [self.watchdog pause];
    [self.connection reauthorizeClient];
}

/// MARK: TBDropboxClientSource

- (DBFILESRoutes *)filesRoutes {
    DBFILESRoutes * result = self.client.filesRoutes;
    return result;
}

/// MARK: public

- (void)addDelegate:(id<TBDropboxClientDelegate>)delegate {
    [self.delegates addDelegate: delegate];
}

- (void)removeDelegate:(id<TBDropboxClientDelegate>)delegate {
    [self.delegates removeDelegate: delegate];
}

/// MARK: private

- (void)provideIncomingMetadataChanges:(NSArray *)metadataChanges {
    NSArray * changes =
        [TBDropboxChangesProcessor changesUsingMetadataCahnges:metadataChanges];
    SEL selector = @selector(client:didReceiveIncomingChanges:);
    [self.delegates enumerateDelegatesRespondToSelector: selector
                                             usingBlock:^(id<TBDropboxClientDelegate> delegate, BOOL *stop) {
        [delegate client: self
didReceiveIncomingChanges: changes];
    }];
}

- (void)switchToDifferentSession:(NSString *)sessionID {
    if ([self.sessionID isEqualToString: sessionID]) {
        return;
    }
    
    self.watchdog = nil;
    self.tasksQueue = nil;
}

@end
