//
//  TBDropboxTask+Private.h
//  Pods
//
//  Created by Bucha Kanstantsin on 2/6/17.
//
//

#ifndef TBDropboxTask_Private_h
#define TBDropboxTask_Private_h

#import "TBDropboxTask.h"


@interface TBDropboxTask ()

@property (assign, nonatomic, readwrite) TBDropboxTaskState state;
@property (strong, nonatomic, readwrite, nonnull) id<TBDropboxEntry> entry;

@property (copy, nonatomic, readwrite, nullable) TBDropboxTaskID * ID;
@property (weak, nonatomic, readwrite, nullable) TBDropboxQueue * scheduledInQueue;

@property (strong, nonatomic) DBRpcTask * dropboxTask;

@property (strong, nonatomic, readwrite, nullable) NSError * runningError;

- (instancetype)initInstance;

- (void)runUsingRoutesSource:(id<TBDropboxFileRoutesSource> _Nonnull)routesSource
              withCompletion:(CDBErrorCompletion _Nonnull)completion;
- (void)performMainUsingRoutes:(DBFILESRoutes * _Nonnull)routes
                withCompletion:(CDBErrorCompletion _Nonnull)completion;

- (void)suspend;
- (BOOL)resume;

- (NSError * _Nonnull)errorUsingFolderError:(DBFILESListFolderError * _Nonnull)error;
- (NSError * _Nonnull)errorUsingRequestError:(DBRequestError * _Nonnull)error;

@end

#endif /* TBDropboxTask_Private_h */
