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
@property (strong, nonatomic, readonly, nullable) TBDropboxTask * runningTask;
@property (assign, nonatomic) BOOL verboseLogging;

+ (instancetype)queueUsingFilesRoutesSource:(id<TBDropboxFileRoutesSource> _Nonnull)source;

+ (instancetype)new __unavailable;
- (id) init __unavailable;

- (TBDropboxTask *)taskByID:(TBDropboxTaskID *)ID;
- (NSArray<TBDropboxTask *> *)tasksByEntry:(id<TBDropboxEntry>)entry;

- (NSNumber *)addTask:(TBDropboxTask *)task;
- (BOOL)removeTask:(TBDropboxTask *)task;

- (void)run;
- (void)stop;

@end
