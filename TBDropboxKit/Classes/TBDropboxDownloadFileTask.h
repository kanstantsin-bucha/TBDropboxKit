//
//  TBDropboxDownloadFileTask.h
//  Pods
//
//  Created by Bucha Kanstantsin on 3/6/17.
//
//

#import <Foundation/Foundation.h>
#import "TBDropboxTask.h"
#import "TBDropboxFileEntry.h"


@interface TBDropboxDownloadFileTask : TBDropboxTask

@property (strong, nonatomic, readonly, nonnull) NSURL * fileURL;

+ (instancetype _Nullable)taskUsingEntry:(TBDropboxFileEntry * _Nonnull)entry
                                 fileURL:(NSURL * _Nonnull)fileURL
                              completion:(TBDropboxTaskCompletion _Nonnull)completion;

+ (instancetype _Nullable)new __unavailable;
- (id _Nullable) init __unavailable;

@end
