//
//  TBDropboxSnapshot.h
//  Pods
//
//  Created by Bucha Kanstantsin on 2/3/17.
//
//

#import <Foundation/Foundation.h>
#import "TBDropbox.h"


@interface TBDropboxWatchdog : NSObject

@property (weak, nonatomic, nullable) id<TBDropboxWatchdogDelegate> delegate;

+ (instancetype _Nullable)watchdogUsingSource:(id<TBDropboxFileRoutesSource> _Nonnull)source;

+ (instancetype)new __unavailable;
- (id) init __unavailable;

- (void)resume;
- (void)pause;

@end


