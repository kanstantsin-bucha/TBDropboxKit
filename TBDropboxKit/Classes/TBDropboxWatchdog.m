//
//  TBDropboxSnapshot.m
//  Pods
//
//  Created by Bucha Kanstantsin on 2/3/17.
//
//

#import "TBDropboxWatchdog.h"

@interface TBDropboxWatchdog ()

@property (weak, nonatomic, readwrite, nullable) id<TBDropboxFileRoutesSource> routesSource;

@end


@implementation TBDropboxWatchdog

/// MARK: - life cycle -

- (instancetype)initInstance {
    if (self = [super init]) {
    }
    return self;
}

+ (instancetype)watchdogUsingSource:(id<TBDropboxFileRoutesSource>)source {
    if (source == nil) {
        return nil;
    }
    
    TBDropboxWatchdog * result = [[[self class] alloc] initInstance];
    result.routesSource = source;
    
    return result;
}

- (void)resume {
    
}

- (void)pause {
    
}

/// MARK: - private -



@end
