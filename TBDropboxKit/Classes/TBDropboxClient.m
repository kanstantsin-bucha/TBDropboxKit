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

@property (strong, nonatomic, readwrite) TBLogger * logger;

@end


@implementation TBDropboxClient

/// MARK: property

- (TBLogger *)logger {
    if (_logger != nil) {
        return _logger;
    }
    _logger = [TBLogger loggerWithName: NSStringFromClass([self class])];
    _logger.logLevel = TBLogLevelWarning;
    return _logger;
}

- (void)setConnectionDesired:(BOOL)connectionDesired {
    [self.logger verbose: @"Received call setConnectionDesired %@",
                            connectionDesired ? @"YES" : @"NO"];
    if (_connectionDesired == connectionDesired) {
        [self.logger verbose: @"Skipping: same value"];
        return;
    }
    
    _connectionDesired = connectionDesired;
    [self.logger info: @"Connection desired changed to ",
                          connectionDesired ? @"YES" : @"NO"];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_connectionDesired) {
            [self.connection openConnection];
            
            [self.logger warning: @"opened connection"];
        } else {
            [self.connection pauseConnection];
            self.watchdog = nil;
            self.tasksQueue = nil;
            
            [self.logger warning: @"paused connection"];
        }
    });
}

- (DBUserClient *)client {
    DBUserClient * result = [DBClientsManager authorizedClient];
    if (result == nil) {
        [self.logger error: @"Dropbox Client is nil. Should never happend"];
    }
    NSAssert(result != nil, @"[ERROR] Dropbox Client should never be nil!");
    return result;
}

- (TBDropboxQueue *)tasksQueue {
    if (_tasksQueue != nil) {
        return _tasksQueue;
    }
    
    _tasksQueue = [TBDropboxQueue queueUsingSource: self];
    _tasksQueue.delegate = self;
    
    [self.logger info: @"create task queue"];
    return _tasksQueue;
}

- (TBDropboxWatchdog *)watchdog {
    if (_watchdog != nil) {
        return _watchdog;
    }
    
    _watchdog = [TBDropboxWatchdog watchdogUsingSource: self];
    _watchdog.delegate = self;
    
    [self.logger info: @"create watchdog"];
    return _watchdog;
}

- (CDBDelegateCollection *)delegates {
    if (_delegates != nil) {
        return _delegates;
    }
    
    _delegates =
        [[CDBDelegateCollection alloc] initWithProtocol:@protocol(TBDropboxClientDelegate)];
    
    [self.logger info: @"create delegates collection"];
    return _delegates;
}

- (void)setWatchdogEnabled:(BOOL)watchdogEnabled {

    [self.logger verbose: @"received call setWatchdogEnabled %@",
                            watchdogEnabled ? @"YES" : @"NO"];
    
    if (_watchdogEnabled == watchdogEnabled) {
        [self.logger verbose: @"Skipping: same value"];
        return;
    }
    _watchdogEnabled = watchdogEnabled;
    
    [self.logger info: @"set watchdog enabled %@",
                         watchdogEnabled ? @"YES" : @"NO "];
    
    if (_watchdogEnabled) {
        if (self.connection.state == TBDropboxConnectionStateConnected) {
            int delay = 0;
            [self resumeWatchdogAfterDelay: delay];
            
            [self.logger info: @"will resume watchdog after delay %@",
                               @(delay)];
        }
    } else {
        [self.watchdog pause];
        
        [self.logger log: @"Pause watchdog"];
    }
}

/// MARK: life cycle

+ (instancetype)sharedInstance {
    static TBDropboxClient * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[super allocWithZone:NULL] initInstance];
        [_sharedInstance.logger log: @"create sharedInstance"];
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
    [self.logger info: @"create connection %@",
                                  connection];
    
    self.connectionDesired = desired;
    self.sessionID = self.connection.accessTokenUID;
    [self.logger log: @"finish initiation withConnectionDesired: %@\r appkey %@",
                      desired, key == nil ? @"not nil" : @"nil"];
}

/// MARK: protocols

/// MARK: TBDropboxConnectionDelegate

- (void)dropboxConnection:(TBDropboxConnection * _Nonnull)connection
         didChangeStateTo:(TBDropboxConnectionState)state {
    
    [self.logger warning: @"connection changed state to: %@",
                          StringFromDropboxConnectionState(state)];
    
    if (state == TBDropboxConnectionStateConnected) {
        [self.tasksQueue resume];
        
        [self.logger log: @"resumed tasks queue"];
    } else {
        [self.tasksQueue pause];
        
        [self.logger log: @"paused tasks queue"];
    }
    
    SEL selector = @selector(dropboxConnection:
                              didChangeStateTo:);
    [self.delegates enumerateDelegatesRespondToSelector: selector
                                             usingBlock: ^(id<TBDropboxConnectionDelegate> delegate, BOOL *stop) {
        [delegate dropboxConnection: connection
                   didChangeStateTo: state];
                   
        [self.logger verbose: @"connection state %@ provided to delegate %@",
                              StringFromDropboxConnectionState(state),
                              delegate];
    }];
}

- (void)dropboxConnection:(TBDropboxConnection * _Nonnull)connection
     didChangeAuthStateTo:(TBDropboxAuthState)state
                withError:(NSError * _Nullable)error {
    
    [self.logger info: @"connection changed Auth state to: %@",
                       @(state)];
    
    SEL selector = @selector(dropboxConnection:
                          didChangeAuthStateTo:
                                     withError:);
    [self.delegates enumerateDelegatesRespondToSelector: selector
                                             usingBlock: ^(id<TBDropboxConnectionDelegate> delegate, BOOL *stop) {
        [delegate dropboxConnection: connection
               didChangeAuthStateTo: state
                          withError: error];
                          
        [self.logger verbose: @"connection Auth state %@ provided to delegate %@",
                                @(state), delegate];
    }];
}

- (void)dropboxConnection:(TBDropboxConnection *)connection
       didChangeSessionID:(NSString *)sessionID {
    [self.logger log: @"connection changed session ID to %@",
                      sessionID];
    if (sessionID == nil) {
        [self.logger info: @"skipping switching to different session"];
        return;
    }
    
    [self switchToDifferentSession: sessionID];
    
}

/// MARK: TBDropboxWatchdogDelegate

- (void)watchdog:(TBDropboxWatchdog *)watchdog
didChangeStateTo:(TBDropboxWatchdogState)state {
    [self.logger log: @"watchdog <%@> changed state to: %@",
                      @(watchdog.hash), @(state)];
    
    SEL selector = @selector(watchdog:
                             didChangeStateTo:);
    [self.delegates enumerateDelegatesRespondToSelector: selector
                                             usingBlock: ^(id<TBDropboxWatchdogDelegate> delegate, BOOL *stop) {
        [delegate watchdog: watchdog
          didChangeStateTo: state];
        [self.logger verbose: @"watchdog <%@> state %@ provided to delegate %@",
                              @(watchdog.hash), @(state), delegate];
    }];
}

- (void)watchdog:(TBDropboxWatchdog *)watchdog
    didCollectPendingChanges:(NSArray *)changes {
    [self.logger log: @"watchdog <%@> did collect pending changes count %@",
                        @(watchdog.hash), @(changes.count)];
    [self.logger verbose: @"pending changes:\r %@",
                          changes];
    
    if (self.connection.state == TBDropboxConnectionStateConnected) {
        [self.tasksQueue resume];
        [self.logger log: @"resumed tasks queue"];
    }
    
    NSArray * incomingChanges = nil;
    if (self.outgoingChanges.count == 0) {
        incomingChanges = changes;
    } else {
        incomingChanges =
            [TBDropboxChangesProcessor processMetadataChanges: changes
                                          byExcludingOutgoing: self.outgoingChanges];
        
        [self.logger info: @"filtered metadata to exclude local outgoing"];
    }
    
    [self.logger info: @"incoming changes count %@",
                       @(incomingChanges.count)];
    [self.logger verbose: @"incoming changes:\r %@",
                          incomingChanges];
    
    [self provideIncomingMetadataChanges: incomingChanges];
}

- (BOOL)watchdogCouldBeWideAwake:(TBDropboxWatchdog *)watchdog {
    BOOL result = self.tasksQueue.hasPendingTasks == NO;
    [self.logger log: @"watchdog <%@> will proceed wide awake %@",
                      @(watchdog.hash), result ? @"YES" : @"NO" ];
    return result;
}

/// MARK: TBDropboxQueueDelegate

- (void)queue:(TBDropboxQueue *)queue
    didChangeStateTo:(TBDropboxQueueState)state {
    
    [self.logger log: @"tasks queue changed state to: %@",
                      @(state)];
    
    if (state == TBDropboxQueueStateResumedProcessing) {
        [self.watchdog pause];
        [self.logger log: @"pause watchdog"];
    }
    if (state == TBDropboxQueueStateResumedNoLoad) {
        int delay = 0;
        [self resumeWatchdogAfterDelay: delay];
        
        [self.logger info: @"will resume watchdog after delay %@",
                          @(delay)];
    }
}

- (void)queue:(TBDropboxQueue *)queue
    didFinishBatchOfTasks:(NSArray *)tasks {
    [self.logger log: @"tasks queue finished batch (%@/max %@) of tasks",
                      @(tasks.count), @(self.tasksQueue.batchSize)];
    [self.logger info: @"batch tasks:\r %@",
                       tasks];
    
    if (self.watchdogEnabled == NO) {
        return;
    }
    
    [self.tasksQueue pause];
    [self.logger log: @"paused tasks queue"];
    
    self.outgoingChanges =
        [TBDropboxChangesProcessor outgoingMetadataChangesUsingTasks: tasks];
    
    [self.logger log: @"created outgoing changes using tasks"];
    [self.logger verbose: @"outgoing changes:\r %@",
                          self.outgoingChanges];
    
    int delay = 0;
    [self resumeWatchdogAfterDelay: delay];
    
    [self.logger info: @"will resume watchdog after delay %@",
                       @(delay)];
}

- (void)queue:(TBDropboxQueue *)queue
    didReceiveAuthError:(NSError *)error {
    [self.logger error: @"tasks queue acquired Auth error %@",
                        error.localizedDescription];
    [self.logger log: @"auth error %@",
                      error];
    
    [self.tasksQueue pause];
    [self.logger log: @"paused tasks queue"];
    
    [self.watchdog pause];
    [self.logger log: @"paused tasks queue"];
    
    [self.connection reauthorizeClient];
    [self.logger log: @"processing reauthorization"];
}

/// MARK: TBDropboxClientSource

- (DBFILESRoutes *)filesRoutes {
    DBFILESRoutes * result = self.client.filesRoutes;
    [self.logger info: @"provided file routes"];
    [self.logger verbose: @" %@",
                          result];
    return result;
}

/// MARK: public

- (void)addDelegate:(id<TBDropboxClientDelegate>)delegate {
    [self.delegates addDelegate: delegate];
    
    [self.logger warning:@"added delegate"];
    [self.logger log: @" %@",
                      delegate];
}

- (void)removeDelegate:(id<TBDropboxClientDelegate>)delegate {
    [self.delegates removeDelegate: delegate];
    
    [self.logger warning:@"removed delegate"];
    [self.logger log: @" %@",
                      delegate];
}

/// MARK: private

- (void)resumeWatchdogAfterDelay:(NSUInteger)sec {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.watchdogEnabled == NO) {
        
            [self.logger info: @"skipping watchdog resume because it is disabled"];
            return;
        }
        
        BOOL queueNotProcessing = self.tasksQueue.state == TBDropboxQueueStateResumedNoLoad
                                  || self.tasksQueue.state == TBDropboxQueueStatePaused;
        
        if (queueNotProcessing == NO) {
            
            [self.logger info: @"skipping watchdog resume because tasks queue processing tasks"];
            return;
        }
        
        [self.watchdog resume];
        
        [self.logger log: @"resumed watchdog"];
    });
}

- (void)provideIncomingMetadataChanges:(NSArray *)metadataChanges {
    NSArray * changes =
        [TBDropboxChangesProcessor changesUsingMetadataCahnges:metadataChanges];
    
    [self.logger info: @"prepared incoming changes count %@",
                       @(changes.count)];
    [self.logger verbose: @"incoming changes:\r %@",
                          changes];
    
    SEL selector = @selector(client:didReceiveIncomingChanges:);
    [self.delegates enumerateDelegatesRespondToSelector: selector
                                             usingBlock:^(id<TBDropboxClientDelegate> delegate, BOOL *stop) {
        [delegate client: self
didReceiveIncomingChanges: changes];
                                                 
        [self.logger warning:@"provided %@ changes to delegate %@",
                             @(changes.count), delegate];
    }];
}

- (void)switchToDifferentSession:(NSString *)sessionID {
    if ([self.sessionID isEqualToString: sessionID]) {
    
        [self.logger log: @"skipping switch to same session"];
        return;
    }
    
    self.sessionID = sessionID;
    [self.logger warning:@"switched to session %@", sessionID];
    
    self.watchdog = nil;
    [self.logger log: @"nullify watchdog"];
    self.tasksQueue = nil;
    [self.logger log: @"nullify tasks queue"];
}

@end
