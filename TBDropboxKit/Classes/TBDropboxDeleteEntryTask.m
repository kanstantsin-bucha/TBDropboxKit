//
//  TBDropboxDeleteEntryTask.m
//  Pods
//
//  Created by Bucha Kanstantsin on 3/9/17.
//
//

#import "TBDropboxDeleteEntryTask.h"
#import "TBDropboxTask+Private.h"
#import "TBDropboxEntryFactory.h"


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
    result.state = TBDropboxTaskStateReady;
    result.type = TBDropboxTaskTypeUploadChanges;
    return result;
}

/// MARK: override

- (void)performMainUsingRoutes:(DBFILESRoutes *)routes
                withCompletion:(CDBErrorCompletion)completion {
    
    self.dropboxTask = [routes delete_: self.entry.dropboxPath];
    weakCDB(wself);
    [self.dropboxTask setResponseBlock: ^(DBFILESMetadata * response,
                                          id  _Nullable routeError,
                                          DBRequestError * _Nullable requestError) {
        NSError * error = [wself composeErrorUsingRequestError: requestError
                                              taskRelatedError: routeError];
        if (error != nil) {
            completion(error);
            return;
        }
        
        DBFILESDeletedMetadata * metadata =
            [[DBFILESDeletedMetadata alloc] initWithName:response.name
                                               pathLower:response.pathLower
                                             pathDisplay:response.pathDisplay
                                    parentSharedFolderId:response.parentSharedFolderId];
        id<TBDropboxEntry> metadataEntry =
            [TBDropboxEntryFactory entryUsingMetadata: metadata];
        if (metadataEntry != nil) {
            self.entry = metadataEntry;
        }
            
        completion(error);
    }];
    
    [self.dropboxTask start];
}

@end
