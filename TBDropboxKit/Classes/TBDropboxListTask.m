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

+ (instancetype)taskUsingEntry:(TBDropboxFolderEntry *)entry
                    completion:(TBDropboxEntriesBlock)completion {
    if (entry == nil
        || completion == nil) {
        return nil;
    }
    
    TBDropboxListTask * result = [TBDropboxListTask new];
    result.completion = completion;
    result.entry = entry;
    return result;
}

- (void)performMainUsingRoutes:(DBFILESRoutes *)routes
                withCompletion:(CDBErrorCompletion)completion {
    DBRpcTask * listTask = [routes listFolder: self.entry.dropboxPath];
    [listTask response: ^(DBFILESListFolderResult * _Nullable result,
                          DBFILESListFolderError * _Nullable folderError,
                          DBRequestError * _Nullable requestError) {
        if (requestError != nil) {
            NSError * error = [self errorUsingRequestError: requestError];
            completion(error);
            self.completion(nil, error);
        }

        if (folderError != nil) {
            NSError * error = [self errorUsingFolderError: folderError];
            completion(error);
            self.completion(nil, error);
        }

        [self.entry updateUsingMetadataEntries: result.entries];
        completion(nil);
        self.completion(self.entry.folderEntries, nil);
    }];
    
    [listTask start];
}

@end
