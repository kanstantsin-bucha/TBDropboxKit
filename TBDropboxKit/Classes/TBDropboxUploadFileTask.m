//
//  TBDropboxFileUploadTask.m
//  Pods
//
//  Created by Bucha Kanstantsin on 3/6/17.
//
//

#import "TBDropboxUploadFileTask.h"
#import "TBDropboxTask+Private.h"


@interface TBDropboxUploadFileTask ()

@property (strong, nonatomic, readwrite, nonnull) TBDropboxFileEntry * entry;
@property (strong, nonatomic, readwrite, nonnull) NSURL * fileURL;

@end

@implementation TBDropboxUploadFileTask

+ (instancetype)taskUsingEntry:(TBDropboxFileEntry *)entry
                       fileURL:(NSURL *)fileURL
                    completion:(TBDropboxTaskCompletion)completion {
    if (entry == nil
        || fileURL == nil
        || completion == nil) {
        return nil;
    }
    
    TBDropboxUploadFileTask * result = [[[self class] alloc] initInstance];
    result.completion = completion;
    result.entry = entry;
    result.fileURL = fileURL;
    result.state = TBDropboxTaskStateReady;
    return result;
}

/// MARK: override

- (void)performMainUsingRoutes:(DBFILESRoutes *)routes
                withCompletion:(CDBErrorCompletion)completion {
                
    BOOL fileExists =
        [[NSFileManager defaultManager] fileExistsAtPath:self.fileURL.path];
    if (fileExists == NO) {
        NSError * error = [self errorFileNotExistsAtURL:self.fileURL
                                            description:@"can't poccesse upload task"];
        completion(error);
        return;
    }
    
    self.dropboxTask = [routes uploadUrl: self.entry.dropboxPath
                                inputUrl: self.fileURL];
    weakCDB(wself);
    [(DBUploadTask *)self.dropboxTask setResponseBlock:^(id  _Nullable response,
                                                         id  _Nullable routeError,
                                                         DBRequestError * _Nullable requestError) {
        [wself handleResponseUsingRequestError: requestError
                              taskRelatedError: routeError
                                    completion: completion];
    }];
    
    [self.dropboxTask start];
}

@end
