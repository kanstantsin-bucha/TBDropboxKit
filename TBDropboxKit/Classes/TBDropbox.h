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

#define TBDropboxErrorDomain @"TBDropboxKit"

#define TBDropboxQueueRestoringTimeSec 3

typedef NSNumber TBDropboxTaskID;
typedef NSString TBDropboxEntryCursor;

@class TBDropboxQueue;
@class TBDropboxConnection;
@class TBDropboxEntry;
@class TBDropboxClient;

typedef void (^TBDropboxEntriesBlock) (NSArray<TBDropboxEntry *> * _Nullable entries,
                                       NSError * _Nullable error);


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


@protocol TBDropboxConnectionDelegate <NSObject>

- (void)dropboxConnection:(TBDropboxConnection * _Nonnull)connection
         didChangeStateTo:(TBDropboxConnectionState)state;

- (void)dropboxConnection:(TBDropboxConnection * _Nonnull)connection
     didChangeAuthStateTo:(TBDropboxAuthState)state
                withError:(NSError * _Nullable)error;

@end


@protocol TBDropboxClientDelegate <TBDropboxConnectionDelegate>

@end

@protocol TBDropboxFileRoutesSource <NSObject>

@property (strong, nonatomic, readonly, nonnull) DBFILESRoutes * filesRoutes;

@end


#endif /* TBDropbox_h */
