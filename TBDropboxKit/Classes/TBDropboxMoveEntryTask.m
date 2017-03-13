//
//  TBDropboxMoveEntryTask.m
//  Pods
//
//  Created by Bucha Kanstantsin on 3/11/17.
//
//

#import "TBDropboxMoveEntryTask.h"
#import "TBDropboxTask+Private.h"


@interface TBDropboxMoveEntryTask ()

@property (strong, nonatomic, readwrite, nonnull) id<TBDropboxEntry> entry;
@property (strong, nonatomic, readwrite, nonnull) id<TBDropboxEntry> destinationEntry;

@end

@implementation TBDropboxMoveEntryTask

+ (instancetype)taskUsingEntry:(id<TBDropboxEntry>)entry
              destinationEntry:(id<TBDropboxEntry>)destinationEntry
                    completion:(TBDropboxTaskCompletion)completion {
    if (entry == nil
        || destinationEntry == nil
        || [entry class] != [destinationEntry class]
        || completion == nil) {
        return nil;
    }
    
    TBDropboxMoveEntryTask * result = [[[self class] alloc] initInstance];
    result.completion = completion;
    result.entry = entry;
    result.destinationEntry = destinationEntry;
    result.state = TBDropboxTaskStateReady;
    result.type = TBDropboxTaskTypeUploadChanges;
    return result;
}

/// MARK: override

- (void)performMainUsingRoutes:(DBFILESRoutes *)routes
                withCompletion:(CDBErrorCompletion)completion {
    
    self.dropboxTask = [routes move: self.entry.dropboxPath
                             toPath: self.destinationEntry.dropboxPath];
    weakCDB(wself);
    [self.dropboxTask setResponseBlock: ^(id  _Nullable response,
                                          id  _Nullable routeError,
                                          DBRequestError * _Nullable requestError) {
        [wself handleResponseUsingRequestError: requestError
                              taskRelatedError: routeError
                                    completion:^(NSError * _Nullable error) {
            id<TBDropboxEntry> metadataEntry =
                [TBDropboxEntryFactory entryUsingMetadata: response];
            if (metadataEntry != nil) {
                self.destinationEntry = metadataEntry;
            }
            
            completion(error);
        }];
    }];
    
    [self.dropboxTask start];
}

@end
