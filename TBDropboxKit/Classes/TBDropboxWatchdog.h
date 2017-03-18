//
//  TBDropboxSnapshot.h
//  Pods
//
//  Created by Bucha Kanstantsin on 2/3/17.
//
//

#import <Foundation/Foundation.h>
#import "TBDropbox.h"
#import "TBLogger.h"


@interface TBDropboxWatchdog : NSObject

@property (weak, nonatomic, nullable) id<TBDropboxWatchdogDelegate> delegate;
@property (assign, nonatomic, readonly) TBDropboxWatchdogState state;

/**
 @brief: Change logger.logLevel option to enable verdbose logging
 Default setup is TBLogLevelWarning
 **/

@property (strong, nonatomic, readonly) TBLogger * logger;

+ (instancetype _Nullable)watchdogUsingSource:(id<TBDropboxClientSource> _Nonnull)source;

+ (instancetype)new __unavailable;
- (id) init __unavailable;

- (void)resume;
- (void)pause;

@end


