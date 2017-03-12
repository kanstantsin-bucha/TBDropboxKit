//
//  TBDropboxCreateFolderTask.m
//  Pods
//
//  Created by Bucha Kanstantsin on 3/6/17.
//
//

#import "TBDropboxCreateFolderTask.h"
#import "TBDropboxTask+Private.h"
#import "TBDropboxFolderEntry+Private.h"

@interface TBDropboxCreateFolderTask ()

@property (strong, nonatomic, readwrite, nonnull) TBDropboxFolderEntry * entry;

@end


@implementation TBDropboxCreateFolderTask

/// MARK: life cycle

+ (instancetype)taskUsingEntry:(TBDropboxFolderEntry *)entry
                    completion:(TBDropboxTaskCompletion)completion {
    if (entry == nil
        || completion == nil) {
        return nil;
    }
    
    TBDropboxCreateFolderTask * result = [[[self class] alloc] initInstance];
    result.completion = completion;
    result.entry = entry;
    result.state = TBDropboxTaskStateReady;
    return result;
}

/// MARK: override

- (void)performMainUsingRoutes:(DBFILESRoutes *)routes
                withCompletion:(CDBErrorCompletion)completion {
    self.dropboxTask = [routes createFolder:self.entry.dropboxPath];
    
    weakCDB(wself);
    [self.dropboxTask setResponseBlock:^(id  _Nullable response,
                                         id  _Nullable routeError,
                                         DBRequestError * _Nullable requestError) {
        [wself handleResponseUsingRequestError: requestError
                              taskRelatedError: routeError
                                    completion: completion];
    }];
    
    [self.dropboxTask start];
}


@end
