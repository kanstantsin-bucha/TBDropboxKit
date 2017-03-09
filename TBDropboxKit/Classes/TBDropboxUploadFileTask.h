//
//  TBDropboxFileUploadTask.h
//  Pods
//
//  Created by Bucha Kanstantsin on 3/6/17.
//
//

#import <Foundation/Foundation.h>
#import "TBDropboxTask.h"
#import "TBDropboxFileEntry.h"


@interface TBDropboxUploadFileTask : TBDropboxTask

@property (strong, nonatomic, readonly, nonnull) TBDropboxFileEntry * entry;
@property (strong, nonatomic, readonly, nonnull) NSURL * fileURL;

+ (instancetype)taskUsingEntry:(TBDropboxFileEntry * _Nonnull)entry
                       fileURL:(NSURL *)fileURL
                    completion:(TBDropboxTaskCompletion _Nonnull)completion;

+ (instancetype)new __unavailable;
- (id) init __unavailable;

@end
