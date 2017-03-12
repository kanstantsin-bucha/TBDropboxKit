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


@interface TBDropboxClient ()
<
    TBDropboxConnectionDelegate,
    TBDropboxFileRoutesSource,
    TBDropboxWatchdogDelegate
>

@property (weak, nonatomic, readwrite) TBDropboxConnection * connection;
@property (strong, nonatomic, readonly) DBUserClient * client;
@property (strong, nonatomic, readwrite, nonnull) TBDropboxQueue * tasksQueue;
@property (strong, nonatomic, readwrite, nonnull) TBDropboxWatchdog * watchdog;
@property (strong, nonatomic) CDBDelegateCollection * delegates;

@end


@implementation TBDropboxClient

/// MARK: property

- (DBUserClient *)client {
    DBUserClient * result = [DBClientsManager authorizedClient];
    return result;
}

- (TBDropboxQueue *)tasksQueue {
    if (_tasksQueue != nil) {
        return _tasksQueue;
    }
    
    _tasksQueue = [TBDropboxQueue queueUsingSource: self];
    return _tasksQueue;
}

- (TBDropboxWatchdog *)watchdog {
    if (_watchdog != nil) {
        return _watchdog;
    }
    
    _watchdog = [TBDropboxWatchdog watchdogUsingSource: self];
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
    TBDropboxConnection * connection = [TBDropboxConnection connectionDesired: desired
                                                                  usingAppKey: key
                                                                     delegate: self];
    self.connection = connection;
}

/// MARK: protocols

/// MARK: TBDropboxConnectionDelegate

- (void)dropboxConnection:(TBDropboxConnection * _Nonnull)connection
         didChangeStateTo:(TBDropboxConnectionState)state {
    if (state == TBDropboxConnectionStateConnected) {
        [self.tasksQueue resume];
        [self.watchdog resume];
    } else {
        [self.tasksQueue pause];
        [self.watchdog pause];
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

/// MARK: TBDropboxFileRoutesSource

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

@end
