//
//  TBDropboxQueue.h
//  Pods
//
//  Created by Bucha Kanstantsin on 2/6/17.
//
//

#import <Foundation/Foundation.h>
#import "TBDropbox.h"
#import "TBDropboxTask.h"


@interface TBDropboxQueue : NSObject

@property (strong, nonatomic, readonly, nonnull) NSArray<TBDropboxTask *> * scheduledTasks;
@property (assign, nonatomic, readonly) BOOL runningTasksQueue;
@property (strong, nonatomic, readonly, nullable) TBDropboxTask * runningTask;

+ (instancetype)queueUsingFilesRoutesSource:(id<TBDropboxFileRoutesSource> _Nonnull)source;

- (TBDropboxTask *)taskByID:(TBDropboxTaskID *)ID;
- (TBDropboxTask *)taskByEntry:(TBDropboxEntry *)entry;

- (void)run;
- (void)stop;

@end
