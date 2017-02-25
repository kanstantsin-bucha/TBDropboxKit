//
//  TBDropboxConnection.h
//  Pods
//
//  Created by Bucha Kanstantsin on 12/12/2016.
//
//

#import <Foundation/Foundation.h>
#import "TBDropboxClient.h"
#import "TBDropbox.h"


@interface TBDropboxConnection : NSObject

@property (assign, nonatomic, readonly) TBDropboxConnectionState state;

@property (strong, nonatomic, readonly, nullable) id appIdentityToken;

@property (assign, nonatomic, readonly) BOOL connected;
@property (assign, nonatomic) BOOL desired;

+ (instancetype)new __unavailable;
- (id) init __unavailable;

- (BOOL)handleAuthorisationRedirectURL:(NSURL * _Nonnull)url;

- (NSArray * _Nullable)provideDropboxURLSchemes;

@end
