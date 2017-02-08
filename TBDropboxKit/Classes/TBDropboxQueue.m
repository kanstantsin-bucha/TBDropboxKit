//
//  TBDropboxQueue.m
//  Pods
//
//  Created by Bucha Kanstantsin on 2/6/17.
//
//

#import "TBDropboxQueue.h"
#import "TBDropboxEntry.h"
#import "TBDropboxTask+Private.h"
#import "TBDropboxClient.h"


@interface TBDropboxQueue ()

@property (weak, nonatomic, readwrite, nullable) id<TBDropboxFileRoutesSource> routesSource;

@property (strong, nonatomic) NSMutableArray<TBDropboxTask *> * scheduledTasksHolder;
@property (assign, nonatomic, readonly) TBDropboxTaskID * nextTaskID;
@property (assign, nonatomic) NSUInteger taskID;

@property (assign, nonatomic, readwrite) BOOL runningTasksQueue;
@property (assign, nonatomic, readwrite) BOOL runningTaskShouldBeRestored;
@property (strong, nonatomic, readwrite) TBDropboxTask * runningTask;

@end


@implementation TBDropboxQueue

/// MARK: property

- (NSArray<TBDropboxTask *> *)scheduledTasks {
    NSArray * result = [self.scheduledTasksHolder copy];
    return result;
}

- (TBDropboxTaskID *)nextTaskID {
    self.taskID += 1;
    TBDropboxTaskID * result = @(self.taskID);
    return result;
}

/// MARK: life cycle

+ (instancetype)queueUsingFilesRoutesSource:(id<TBDropboxFileRoutesSource>)source {
    if (source == nil) {
        return nil;
    }
    
    TBDropboxQueue * result = [TBDropboxQueue new];
    result.routesSource = source;
    
    return result;
}

/// MARK: public

- (void)run {
    if (self.runningTasksQueue) {
        return;
    }
    
    self.runningTasksQueue = YES;
    self.runningTaskShouldBeRestored = self.runningTask.state != TBDropboxTaskStateCompleted;
    
    weakCDB(wself);
    dispatch_time_t time =
        dispatch_time(DISPATCH_TIME_NOW,
                      (int64_t)(TBDropboxQueueRestoringTimeSec * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [wself resumeQueue];
    });
    
}

- (void)stop {
    self.runningTasksQueue = NO;
}

- (NSNumber *)addTask:(TBDropboxTask *)task {
    if (task.state != TBDropboxTaskStateReady) {
        return nil;
    }
    
    BOOL emptyQueue = self.scheduledTasksHolder.count == 0
                      && self.runningTask == nil;
    
    task.state = TBDropboxTaskStateScheduled;
    task.ID = self.nextTaskID;
    task.scheduledInQueue = self;
    
    [self.scheduledTasksHolder addObject:task];
    
    
    if (self.runningTasksQueue
        && emptyQueue) {
        [self resumeQueue];
    }
    
    return task.ID;
}

- (BOOL)removeTask:(TBDropboxTask *)task {
    if ([self.scheduledTasksHolder containsObject:task] == NO) {
        return NO;
    }
    
    [self.scheduledTasksHolder removeObject:task];
    task.state = TBDropboxTaskStateReady;
    task.ID = nil;
    task.scheduledInQueue = nil;
}

- (TBDropboxTask *)taskByID:(TBDropboxTaskID *)ID {
    NSPredicate * predicate = [self tasksPredicateByID: ID];
    NSArray * filtered =
        [self.scheduledTasksHolder filteredArrayUsingPredicate: predicate];
    TBDropboxTask * result = filtered.firstObject;
    return result;
}

- (NSArray<TBDropboxTask *> *)taskByEntry:(TBDropboxEntry *)entry {
    NSPredicate * predicate = [self tasksPredicateByPath: entry.dropboxPath];
    NSArray * result =
        [self.scheduledTasksHolder filteredArrayUsingPredicate: predicate];
    return result;
}

/// MARK: queue

- (void)resumeQueue {
    if (self.runningTaskShouldBeRestored) {
        [self runTask: self.runningTask];
    } else {
        [self runNextTask];
    }
}

- (void)runNextTask {
    if (self.runningTasksQueue == NO) {
        return;
    }
    
    self.runningTaskShouldBeRestored = NO;
    
    self.runningTask = self.scheduledTasksHolder.firstObject;
    
    [self runTask: self.runningTask];
}

- (void)runTask:(TBDropboxTask *)runningTask {
    if (runningTask == nil) {
        return;
    }
    
    if (self.runningTasksQueue == NO) {
        return;
    }
    
    if (self.routesSource == nil) {
        return;
    }
    
    [self.scheduledTasksHolder removeObject: runningTask];
    runningTask.state = TBDropboxTaskStateRunning;
    
    weakCDB(wself);
    [runningTask runUsingRoutesSource: self.routesSource
                       withCompletion: ^(NSError * _Nullable error) {
        if (error != nil) {
            runningTask.state = TBDropboxTaskStateFailed;
        } else {
            runningTask.state = TBDropboxTaskStateCompleted;
        }
        
        [wself runNextTask];
    }];
}

/// MARK: predicates

- (NSPredicate * )tasksPredicateByID:(TBDropboxTaskID *)ID {
    NSPredicate * result = [NSPredicate predicateWithFormat:@"ID == %@", ID];
    return result;
}

- (NSPredicate * )tasksPredicateByPath:(NSString *)path {
    NSPredicate * result = [NSPredicate predicateWithFormat:@"item.dropboxPath like %@", path];
    return result;
}

@end
