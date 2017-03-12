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
#import "TBDropboxEntry.h"


@interface TBDropboxQueue : NSObject

@property (strong, nonatomic, readonly, nonnull) NSArray<TBDropboxTask *> * scheduledTasks;
@property (assign, nonatomic, readonly) BOOL runningTasksQueue;
@property (assign, nonatomic, readonly) BOOL processingTasks;
@property (strong, nonatomic, readonly, nullable) TBDropboxTask * currentTask;
@property (assign, nonatomic) BOOL verboseLogging;

+ (instancetype)queueUsingSource:(id<TBDropboxFileRoutesSource> _Nonnull)source;

+ (instancetype)new __unavailable;
- (id) init __unavailable;

- (TBDropboxTask *)taskByID:(TBDropboxTaskID *)ID;
- (NSArray<TBDropboxTask *> *)tasksByEntry:(id<TBDropboxEntry>)entry;

- (NSNumber *)addTask:(TBDropboxTask *)task;
- (BOOL)removeTask:(TBDropboxTask *)task;

- (void)resume;
- (void)pause;

@end
