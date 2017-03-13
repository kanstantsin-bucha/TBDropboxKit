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
#import "TBDropboxEntry.h"


@interface TBDropboxTask : NSObject

@property (assign, nonatomic, readonly) TBDropboxTaskState state;
@property (strong, nonatomic, readonly, nonnull) id<TBDropboxEntry> entry;

@property (copy, nonatomic, readonly, nullable) TBDropboxTaskID * ID;
@property (weak, nonatomic, readonly, nullable) TBDropboxQueue * scheduledInQueue;

@property (strong, nonatomic, readonly, nullable) NSError * runningError;

+ (instancetype)new __unavailable;
- (id) init __unavailable;

@end


typedef void (^TBDropboxTaskCompletion) (TBDropboxTask * _Nonnull task, NSError * _Nullable error);

