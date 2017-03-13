//
//  TBDropbox.h
//  Pods
//
//  Created by Bucha Kanstantsin on 1/1/17.
//
//

#ifndef TBDropbox_h
#define TBDropbox_h

#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>
#import <CDBKit/CDBKit.h>

#define TBDropboxErrorDomain @"TBDropboxKit"

#define TBDropboxQueueRestoringTimeSec 3


typedef NSNumber TBDropboxTaskID;
typedef NSString TBDropboxCursor;


@class TBDropboxQueue;
@class TBDropboxConnection;
@class TBDropboxFileEntry;
@class TBDropboxClient;
@class TBDropboxWatchdog;


typedef NS_ENUM(NSInteger, TBDropboxConnectionState) {
    TBDropboxConnectionStateUndefined = 0,
    TBDropboxConnectionStateDisconnected = 1,
    TBDropboxConnectionStateAuthorization = 2,
    TBDropboxConnectionStateConnected = 3,
    TBDropboxConnectionStatePaused = 4 // Disconnected but has authorization token
};

typedef NS_ENUM(NSInteger, TBDropboxAuthState) {
    TBDropboxAuthStateUndefined = 0,
    TBDropboxAuthStateInitiated = 1,
    TBDropboxAuthStateAuthorization = 2, // User using browser to authorize client
    TBDropboxAuthStateCancelled = 3,
    TBDropboxAuthStateGotError = 4,
    TBDropboxAuthStateSucceed = 5
};

typedef NS_ENUM(NSInteger, TBDropboxWatchdogState) {
    TBDropboxWatchdogStateUndefined = 0,
    TBDropboxWatchdogStatePaused = 1,
    TBDropboxWatchdogStateResumedProcessingChanges = 2,
    TBDropboxWatchdogStateResumedWideAwake = 3
};

typedef NS_ENUM(NSInteger, TBDropboxQueueState) {
    TBDropboxQueueStateUndefined = 0,
    TBDropboxQueueStatePaused = 1,
    TBDropboxQueueStateResumedNoLoad = 2,
    TBDropboxQueueStateResumedProcessing = 3
};

typedef NS_ENUM(NSInteger, TBDropboxEntrySource) {
    TBDropboxEntrySourcePath = 0,
    TBDropboxEntrySourceMetadata = 1
};

typedef NS_ENUM(NSInteger, TBDropboxTaskState) {
    TBDropboxTaskStateUndefined = 0,
    TBDropboxTaskStateReady = 1,
    TBDropboxTaskStateScheduled = 2,
    TBDropboxTaskStateRunning = 3,
    TBDropboxTaskStateSuspended = 4,
    TBDropboxTaskStateCompleted = 5,
    TBDropboxTaskStateFailed = 6
};

#define StringFromDropboxEntrySource(enum) (([@[\
    @"TBDropboxEntrySourcePath",\
    @"TBDropboxEntrySourceMetadata",\
] objectAtIndex:(enum)]))

#define hasPropertyWithName(object, propertyName) [object respondsToSelector:NSSelectorFromString(propertyName)]
#define valueUsingMetadata(metadata, key) hasPropertyWithName(metadata, key) ? [metadata valueForKey: key] : nil;

#define sizeUsingMetadata(metadata) valueUsingMetadata(metadata, @"size")


@protocol TBDropboxConnectionDelegate <NSObject>

- (void)dropboxConnection:(TBDropboxConnection * _Nonnull)connection
         didChangeStateTo:(TBDropboxConnectionState)state;

- (void)dropboxConnection:(TBDropboxConnection * _Nonnull)connection
     didChangeAuthStateTo:(TBDropboxAuthState)state
                withError:(NSError * _Nullable)error;
@end


@protocol TBDropboxWatchdogDelegate <NSObject>

- (void)watchdog:(TBDropboxWatchdog * _Nonnull)watchdog
didChangeStateTo:(TBDropboxWatchdogState)state;


- (void)watchdog:(TBDropboxWatchdog * _Nonnull)watchdog
didCollectPendingChanges:(NSArray *)changes;

- (BOOL)watchdogCouldBeWideAwake:(TBDropboxWatchdog * _Nonnull)watchdog;

@end

@protocol TBDropboxQueueDelegate <NSObject>

- (void)queue:(TBDropboxQueue * _Nonnull)queue
didChangeStateTo:(TBDropboxQueueState)state;

- (void)queue:(TBDropboxQueue * _Nonnull)queue
didFinishBatchOfTasks:(NSArray *)tasks;

@end


@protocol TBDropboxClientDelegate
<TBDropboxConnectionDelegate,
TBDropboxWatchdogDelegate,
TBDropboxQueueDelegate>

@end

@protocol TBDropboxFileRoutesSource <NSObject>

@property (strong, nonatomic, readonly, nonnull) DBFILESRoutes * filesRoutes;

@end


#endif /* TBDropbox_h */
