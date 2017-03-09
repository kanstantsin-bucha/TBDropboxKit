//
//  TBDropboxTask.m
//  Pods
//
//  Created by Bucha Kanstantsin on 2/3/17.
//
//

#import "TBDropboxTask.h"
#import "TBDropboxTask+Private.h"
#import "TBDropboxQueue.h"


@implementation TBDropboxTask

/// MARK: life cycle

- (instancetype)initInstance {
    if (self = [super init]) {
    }
    return self;
}

/// MARK: private

- (void)suspend {
    if (self.dropboxTask == nil) {
        return;
    }
    
    [self.dropboxTask suspend];
}

- (BOOL)resume {
    if (self.dropboxTask == nil) {
        return NO;
    }
    
    [self.dropboxTask resume];
    return YES;
}

- (void)runUsingRoutesSource:(id<TBDropboxFileRoutesSource>)routesSource
              withCompletion:(CDBErrorCompletion)completion {
    
    if (self.state != TBDropboxTaskStateRunning) {
        completion([self failedToRunUnscheduledError]);
    }
    
    DBFILESRoutes * routes = routesSource.filesRoutes;
    if (routes == nil) {
        completion([self failedToRunNoRoutesError]);
    }
    
    [self performMainUsingRoutes: routes
                  withCompletion: ^(NSError * _Nullable error) {
        completion(error);
    }];
}

- (void)performMainUsingRoutes:(DBFILESRoutes *)routes
                withCompletion:(CDBErrorCompletion _Nonnull)completion {
    
    NSAssert(NO, @"main logic method required redefinition in subclass");
    completion([self redefinitionRequiredError]);
}

/// MARK: error

- (NSError *)failedToRunUnscheduledError {
    NSString * description = @"Failed to run task that was not scheduled";
    NSError * result = [NSError errorWithDomain: TBDropboxErrorDomain
                                           code: 100
                                       userInfo: @{ NSLocalizedDescriptionKey : description}];
    return result;
}

- (NSError *)failedToRunNoRoutesError {
    NSString * description = @"Failed to run task that has no files routes";
    NSError * result = [NSError errorWithDomain: TBDropboxErrorDomain
                                           code: 101
                                       userInfo: @{ NSLocalizedDescriptionKey : description}];
    return result;
}

- (NSError *)redefinitionRequiredError {
    NSString * description = @"Main logic method required redefinition in subclass";
    NSError * result = [NSError errorWithDomain: TBDropboxErrorDomain
                                           code: 102
                                       userInfo: @{ NSLocalizedDescriptionKey : description}];
    return result;
}

- (void)handleResponseUsingRequestError:(DBRequestError * _Nullable)requestError
                       taskRelatedError:(id _Nullable)relatedError
                             completion:(CDBErrorCompletion _Nonnull)completion {
    self.dropboxTask = nil;
    
    if (requestError != nil) {
        NSError * error = [self errorUsingRequestError: requestError];
        completion(error);
        self.completion(self, error);
        
        return;
    }
    
    if (relatedError != nil) {
        NSError * error = [self errorUsingRelatedError: relatedError];
        completion(error);
        self.completion(self, error);
        
        return;
    }
    
    completion(nil);
    self.completion(self, nil);
}

/// MARK: dropbox errors

/// TODO: improve errors based on extended description
/// https://github.com/dropbox/dropbox-sdk-obj-c

- (NSError *)errorUsingRelatedError:(id _Nonnull)relatedError {
    NSError * result = nil;
    if ([relatedError isKindOfClass:[DBFILESListFolderError class]]) {
        result = [self errorUsingFolderError: relatedError];
    }
    
    if (result == nil) {
        NSString * message =
        [NSString stringWithFormat:@"Related error %@", relatedError];
        NSDictionary * info = @{NSLocalizedDescriptionKey: message};
        result = [NSError errorWithDomain: TBDropboxErrorDomain
                                     code: 200
                                 userInfo: info];
    }
    
    return result;
}

- (NSError *)errorUsingFolderError:(DBFILESListFolderError *)error {
    NSString * message =
        [NSString stringWithFormat: @"Route-specific error %@.",
                                    [error tagName]];
    
    if ([error isPath]) {
        message =
            [NSString stringWithFormat: @"%@. Invalid path: %@",
                                        message, error.path];
    }
    
    message = [NSString stringWithFormat: @"%@. %@",
                                          message, error.description];
    
    NSDictionary * userInfo = @{ NSLocalizedDescriptionKey: message };
    NSError * result = [NSError errorWithDomain: TBDropboxErrorDomain
                                           code: 201
                                       userInfo: userInfo];
    return result;
}

- (NSError *)errorUsingRequestError:(DBRequestError *)error {
    NSString * message =
        [NSString stringWithFormat: @"Generic request error %@. %@",
                                    [error tagName],
                                    error.description];
    
    NSDictionary * userInfo = @{ NSLocalizedDescriptionKey: message };
    NSError * result = [NSError errorWithDomain: TBDropboxErrorDomain
                                           code: 301
                                       userInfo: userInfo];
    return result;
}

- (NSError *)errorFileNotExistsAtURL:(NSURL *)URL
                         description:(NSString *)description {
    NSString * message =
        [NSString stringWithFormat: @"File not exists at URL %@ %@",
                                    URL.absoluteString,
                                    description];
    
    NSDictionary * userInfo = @{ NSLocalizedDescriptionKey: message };
    NSError * result = [NSError errorWithDomain: TBDropboxErrorDomain
                                           code: 401
                                       userInfo: userInfo];
    return result;
}


@end
