//
//  TBDropboxListTask.m
//  Pods
//
//  Created by Bucha Kanstantsin on 2/6/17.
//
//

#import "TBDropboxListFolderTask.h"
#import "TBDropboxTask+Private.h"
#import "TBDropboxFolderEntry+Private.h"


@interface TBDropboxListFolderTask ()

@property (strong, nonatomic, readwrite, nonnull) TBDropboxFolderEntry * entry;
@property (strong, nonatomic, readwrite, nonnull) TBDropboxCursor * cursor;

@end


@implementation TBDropboxListFolderTask

/// MARK: life cycle

+ (instancetype)taskUsingEntry:(TBDropboxFolderEntry *)entry
                    completion:(TBDropboxTaskCompletion)completion {
    TBDropboxListFolderTask * result =
        [[self class] taskUsingEntry: entry
                              cursor: nil
                          completion: completion];
    return result;
}

+ (instancetype)taskUsingEntry:(TBDropboxFolderEntry *)entry
                        cursor:(NSString *)cursor
                    completion:(TBDropboxTaskCompletion)completion {
    if (entry == nil
        || completion == nil) {
        return nil;
    }
    
    TBDropboxListFolderTask * result = [[[self class] alloc] initInstance];
    result.completion = completion;
    result.entry = entry;
    result.state = TBDropboxTaskStateReady;
    result.type = TBDropboxTaskTypeRequestInfo;
    result.cursor = cursor;
    return result;
}

/// MARK: override

- (void)performMainUsingRoutes:(DBFILESRoutes *)routes
                withCompletion:(CDBErrorCompletion)completion {
    if (self.cursor == nil) {
        self.dropboxTask = [routes listFolder: self.entry.dropboxPath
                                    recursive: @(self.recursive)
                             includeMediaInfo: @(self.includeMediaInfo)
                               includeDeleted: @(self.includeDeleted)
              includeHasExplicitSharedMembers: @(self.includeHasExplicitSharedMembers)];
    } else {
        self.dropboxTask = [routes listFolderContinue: self.cursor];
    }

    weakCDB(wself);
    [self.dropboxTask setResponseBlock: ^(DBFILESListFolderResult * _Nullable response,
                                          DBFILESListFolderError * _Nullable folderError,
                                          DBRequestError * _Nullable requestError) {
        
        [wself handleResponseUsingRequestError: requestError
                              taskRelatedError: folderError
                                    completion: ^(NSError * _Nullable error) {
            if (error != nil) {
                completion(error);
                return;
            }
                
            wself.cursor = response.cursor;
            [wself.entry addIncomingMetadataEntries: response.entries];
                
            if (response.hasMore.boolValue) {
                [wself performMainUsingRoutes: routes
                               withCompletion: completion];
            }
            completion(error);
        }];
    }];
    
    [self.dropboxTask start];
}

@end
