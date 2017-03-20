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

@property (copy, nonatomic, readonly, nullable) NSString * accessTokenUID;

@property (assign, nonatomic, readonly) BOOL connected;

+ (instancetype _Nullable)new __unavailable;
- (id _Nullable) init __unavailable;

- (BOOL)handleAuthorisationRedirectURL:(NSURL * _Nonnull)url;

- (NSArray * _Nullable)provideDropboxURLSchemes;

@end
