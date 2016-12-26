//
//  TBDropboxConnection.h
//  Pods
//
//  Created by Bucha Kanstantsin on 12/12/2016.
//
//

#import <Foundation/Foundation.h>

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


@class TBDropboxConnection;


@protocol TBDropboxConnectionDelegate <NSObject>

- (void)dropboxConnection:(TBDropboxConnection * _Nonnull)connection
         didChangeStateTo:(TBDropboxConnectionState)state;

- (void)dropboxConnection:(TBDropboxConnection * _Nonnull)connection
     didChangeAuthStateTo:(TBDropboxAuthState)state
                withError:(NSError * _Nullable)error;

@end


@interface TBDropboxConnection : NSObject

@property (assign, nonatomic, readonly) TBDropboxConnectionState state;
@property (weak, nonatomic, nullable) id<TBDropboxConnectionDelegate> delegate;

@property (strong, nonatomic, readonly, nullable) NSURL * ubiquityContainerURL;
@property (strong, nonatomic, readonly, nullable) id appIdentityToken;

//@property (strong, nonatomic, readonly, nullable) CDBCloudDocuments * documents;

@property (assign, nonatomic, readonly) BOOL connected;
@property (assign, nonatomic) BOOL connectionDesired;

+ (instancetype _Nullable)sharedInstance;

- (void)initiateWithConnectionDesired:(BOOL)desired
                          usingAppKey:(NSString * _Nullable)key
                             delegate:(id<TBDropboxConnectionDelegate> _Nullable)delegate;
                             
- (BOOL)handleAuthorisationRedirectURL:(NSURL * _Nonnull)url;

- (void)pauseConnection;
- (void)resumeConnection;

- (NSArray * _Nullable)provideDropboxURLSchemes;

@end
