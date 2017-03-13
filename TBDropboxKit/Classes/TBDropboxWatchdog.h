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
@property (strong, nonatomic, readonly) TBDropboxCursor * cursor;
@property (assign, nonatomic, readonly) TBDropboxWatchdogState state;

+ (instancetype _Nullable)watchdogUsingSource:(id<TBDropboxFileRoutesSource> _Nonnull)source;

- (void)resetCursor;

+ (instancetype)new __unavailable;
- (id) init __unavailable;

- (void)resume;
- (void)pause;

@end


