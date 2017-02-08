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
                withCompletion:(CDBErrorCompletion)completion {
    
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

/// MARK: dropbox errors

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
                                           code: 200
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
                                           code: 201
                                       userInfo: userInfo];
    return result;
}

@end
