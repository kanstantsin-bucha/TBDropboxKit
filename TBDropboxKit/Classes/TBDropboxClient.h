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
#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>


@interface TBDropboxClient : NSObject

@property (strong, nonatomic, readonly, nullable) TBDropboxConnection * connection;
@property (strong, nonatomic, nonnull) TBDropboxQueue * tasksQueue;

/**
 @brief: Use this option to enable verbose logging
 **/

@property (assign, nonatomic) BOOL verbose;

+ (instancetype)sharedInstance;

- (void)initiateWithConnectionDesired:(BOOL)desired
                          usingAppKey:(NSString * _Nullable)key;

/**
 Add delegate to notify changes
 **/

- (void)addDelegate:(id<TBDropboxClientDelegate> _Nonnull)delegate;

/**
 Remove delegate
 **/

- (void)removeDelegate:(id<TBDropboxClientDelegate> _Nonnull)delegate;

@end
