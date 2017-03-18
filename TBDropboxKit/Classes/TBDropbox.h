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
@class TBDropboxChange;


typedef NS_ENUM(NSInteger, TBDropboxConnectionState) {
    TBDropboxConnectionStateUndefined = 0,
    TBDropboxConnectionStateDisconnected = 1,
    TBDropboxConnectionStateAuthorization = 2,
    TBDropboxConnectionStateConnected = 3,
    TBDropboxConnectionStatePaused = 4 // Disconnected but keeping authorization token
};

#define StringFromDropboxConnectionState(enum) (([@[\
@"State: Undefined",\
@"State: Disconnected",\
@"State: Authorization",\
@"State: Connected",\
@"State: Paused",\
] objectAtIndex:(enum)]))

typedef NS_ENUM(NSInteger, TBDropboxAuthState) {
    TBDropboxAuthStateUndefined = 0,
    TBDropboxAuthStateInitiated = 1,
    TBDropboxAuthStateAuthorization = 2, // User using browser to authorize client
    TBDropboxAuthStateCancelled = 3,
    TBDropboxAuthStateGotError = 4,
    TBDropboxAuthStateSucceed = 5
};

#define StringFromDropboxAuthState(enum) (([@[\
@"State: Undefined",\
@"State: Initiated",\
@"State: Authorization",\
@"State: Cancelled",\
@"State: GotError",\
@"State: Succeed",\
] objectAtIndex:(enum)]))

typedef NS_ENUM(NSInteger, TBDropboxWatchdogState) {
    TBDropboxWatchdogStateUndefined = 0,
    TBDropboxWatchdogStatePaused = 1,
    TBDropboxWatchdogStateResumedProcessingChanges = 2,
    TBDropboxWatchdogStateResumedWideAwake = 3
};

#define StringFromDropboxWatchdogState(enum) (([@[\
@"State: Undefined",\
@"State: Paused",\
@"State: Resumed-processingChanges",\
@"State: Resumed-wideAwake",\
] objectAtIndex:(enum)]))

typedef NS_ENUM(NSInteger, TBDropboxQueueState) {
    TBDropboxQueueStateUndefined = 0,
    TBDropboxQueueStatePaused = 1,
    TBDropboxQueueStateResumedNoLoad = 2,
    TBDropboxQueueStateResumedProcessing = 3
};

#define StringFromDropboxQueueState(enum) (([@[\
@"State: Undefined",\
@"State: Paused",\
@"State: Resumed-noLoad",\
@"State: Resumed-processing",\
] objectAtIndex:(enum)]))

typedef NS_ENUM(NSInteger, TBDropboxEntrySource) {
    TBDropboxEntrySourcePath = 0,
    TBDropboxEntrySourceMetadata = 1
};

#define StringFromDropboxEntrySource(enum) (([@[\
    @"Source: Path",\
    @"Source: Metadata",\
] objectAtIndex:(enum)]))

typedef NS_ENUM(NSInteger, TBDropboxTaskState) {
    TBDropboxTaskStateUndefined = 0,
    TBDropboxTaskStateReady = 1,
    TBDropboxTaskStateScheduled = 2,
    TBDropboxTaskStateRunning = 3,
    TBDropboxTaskStateSuspended = 4,
    TBDropboxTaskStateSucceed = 5,
    TBDropboxTaskStateFailed = 6
};

#define StringFromDropboxTaskState(enum) (([@[\
@"State: Undefined",\
@"State: Ready",\
@"State: Scheduled",\
@"State: Running",\
@"State: Suspended",\
@"State: Succeed",\
@"State: Failed",\
] objectAtIndex:(enum)]))

typedef NS_ENUM(NSInteger, TBDropboxTaskType) {
    TBDropboxTaskTypeUploadChanges = 0,
    TBDropboxTaskTypeRequestInfo = 1
};

typedef NS_ENUM(NSInteger, TBDropboxChangeAction) {
    TBDropboxChangeActionUndefined = 0,
    TBDropboxChangeActionDelete = 1,
    TBDropboxChangeActionUpdateFile = 2,
    TBDropboxChangeActionUpdateFolder = 3
};

#define StringFromDropboxChangeAction(enum) (([@[\
@"Forbidden: Ufndefined",\
@"Action: Delete",\
@"Action: Update File",\
@"Action: Update Folder",\
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

- (void)dropboxConnection:(TBDropboxConnection * _Nonnull)connection
       didChangeSessionID:(NSString *)sessionID;
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

- (void)queue:(TBDropboxQueue * _Nonnull)queue
didReceiveAuthError:(NSError *)error;

@end


@protocol TBDropboxClientDelegate
<TBDropboxConnectionDelegate,
TBDropboxWatchdogDelegate,
TBDropboxQueueDelegate>

- (void)client:(TBDropboxClient *)client
didReceiveIncomingChanges:(NSArray <TBDropboxChange *> *)changes;

@end

@protocol TBDropboxClientSource <NSObject>

@property (strong, nonatomic, readonly, nonnull) DBFILESRoutes * filesRoutes;
@property (strong, nonatomic, readonly, nonnull) NSString * sessionID;

@end


#endif /* TBDropbox_h */
