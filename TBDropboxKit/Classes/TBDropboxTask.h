//
//  TBDropboxTask.h
//  Pods
//
//  Created by Bucha Kanstantsin on 2/3/17.
//
//

#import <Foundation/Foundation.h>
#import <CDBKit/CDBKit.h>
#import "TBDropbox.h"

typedef NS_ENUM(NSInteger, TBDropboxTaskType) {
    TBDropboxTaskTypePoll = 0,
    TBDropboxTaskTypeLongPoll = 1,
};


typedef NS_ENUM(NSInteger, TBDropboxTaskState) {
    TBDropboxTaskStateReady = 0,
    TBDropboxTaskStateScheduled = 1,
    TBDropboxTaskStateRunning = 2,
    TBDropboxTaskStateCompleted = 3,
    TBDropboxTaskStateFailed = 4
    //TBDropboxTaskTypeUpdat
};




@interface TBDropboxTask : NSObject

@property (assign, nonatomic, readonly) TBDropboxTaskState state;
@property (strong, nonatomic, readonly, nonnull) TBDropboxEntry * entry;

@property (copy, nonatomic, readonly, nullable) TBDropboxTaskID * ID;
@property (weak, nonatomic, readonly, nullable) TBDropboxQueue * scheduledInQueue;

@property (strong, nonatomic, readonly, nullable) NSError * runningError;

@end

