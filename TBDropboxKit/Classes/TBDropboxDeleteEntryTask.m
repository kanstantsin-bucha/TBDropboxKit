//
//  TBDropboxDeleteEntryTask.m
//  Pods
//
//  Created by Bucha Kanstantsin on 3/9/17.
//
//

#import "TBDropboxDeleteEntryTask.h"
#import "TBDropboxTask+Private.h"


@interface TBDropboxDeleteEntryTask ()

@property (strong, nonatomic, readwrite, nonnull) id<TBDropboxEntry> entry;

@end


@implementation TBDropboxDeleteEntryTask

+ (instancetype)taskUsingEntry:(id<TBDropboxEntry>)entry
                    completion:(TBDropboxTaskCompletion)completion {
    if (entry == nil
        || completion == nil) {
        return nil;
    }
    
    TBDropboxDeleteEntryTask * result = [[[self class] alloc] initInstance];
    result.completion = completion;
    result.entry = entry;
    return result;
}

/// MARK: override

- (void)performMainUsingRoutes:(DBFILESRoutes *)routes
                withCompletion:(CDBErrorCompletion)completion {
    
    self.dropboxTask = [routes delete_: self.entry.dropboxPath];
    weakCDB(wself);
    [self.dropboxTask setResponseBlock: ^(id  _Nullable response,
                                          id  _Nullable routeError,
                                          DBRequestError * _Nullable requestError) {
        [wself handleResponseUsingRequestError: requestError
                              taskRelatedError: routeError
                                    completion: completion];
    }];
    
    [self.dropboxTask start];
}

@end
