//
//  TBDropboxListTask.m
//  Pods
//
//  Created by Bucha Kanstantsin on 2/6/17.
//
//

#import "TBDropboxListTask.h"
#import "TBDropboxTask+Private.h"
#import "TBDropboxFolderEntry+Private.h"


@interface TBDropboxListTask ()

@property (strong, nonatomic) TBDropboxEntriesBlock completion;
@property (strong, nonatomic, readwrite, nonnull) TBDropboxFolderEntry * entry;

@end


@implementation TBDropboxListTask

/// MARK: life cycle

+ (instancetype)taskUsingEntry:(TBDropboxFolderEntry *)entry
                    completion:(TBDropboxEntriesBlock)completion {
    if (entry == nil
        || completion == nil) {
        return nil;
    }
    
    TBDropboxListTask * result = [[[self class] alloc] initInstance];
    result.completion = completion;
    result.entry = entry;
    return result;
}

/// MARK: override

- (void)performMainUsingRoutes:(DBFILESRoutes *)routes
                withCompletion:(CDBErrorCompletion)completion {
    self.dropboxTask = [routes listFolder: self.entry.dropboxPath];
    weakCDB(wself);
    [self.dropboxTask setResponseBlock: ^(DBFILESListFolderResult * _Nullable result,
                                          DBFILESListFolderError * _Nullable folderError,
                                          DBRequestError * _Nullable requestError) {
        wself.dropboxTask = nil;
        
        if (requestError != nil) {
            NSError * error = [self errorUsingRequestError: requestError];
            completion(error);
            wself.completion(nil, error);
            return;
        }

        if (folderError != nil) {
            NSError * error = [self errorUsingFolderError: folderError];
            completion(error);
            wself.completion(nil, error);
            return;
        }

        
        [wself.entry updateUsingMetadataEntries: result.entries];
        
        completion(nil);
        wself.completion(self.entry.folderEntries, nil);
    }];
    
    [self.dropboxTask start];
}

@end
