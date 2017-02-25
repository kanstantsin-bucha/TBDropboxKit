//
//  TBDropboxDocuments.h
//  Pods
//
//  Created by Bucha Kanstantsin on 12/29/16.
//
//

#import <Foundation/Foundation.h>
#import "TBDropbox.h"
#import "TBDropboxQueue.h"
#import "TBDropboxConnection.h"


@interface TBDropboxClient : NSObject

@property (strong, nonatomic, readonly, nullable) TBDropboxConnection * connection;
@property (strong, nonatomic, nonnull) TBDropboxQueue * tasksQueue;

/**
 @brief: Use this option to enable verbose logging
 **/

@property (assign, nonatomic) BOOL verbose;

+ (instancetype)sharedInstance;

+ (instancetype)alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
- (instancetype)init __attribute__((unavailable("init not available, call sharedInstance instead")));
+ (instancetype)new __attribute__((unavailable("new not available, call sharedInstance instead")));
- (instancetype)copy __attribute__((unavailable("copy not available, call sharedInstance instead")));

- (void)initiateWithConnectionDesired:(BOOL)desired
                          usingAppKey:(NSString * _Nullable)key;

- (void)addDelegate:(id<TBDropboxClientDelegate> _Nonnull)delegate;
- (void)removeDelegate:(id<TBDropboxClientDelegate> _Nonnull)delegate;

@end
