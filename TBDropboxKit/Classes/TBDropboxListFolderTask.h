//
//  TBDropboxListTask.h
//  Pods
//
//  Created by Bucha Kanstantsin on 2/6/17.
//
//

#import <Foundation/Foundation.h>
#import "TBDropboxTask.h"
#import "TBDropboxFolderEntry.h"


@interface TBDropboxListFolderTask : TBDropboxTask

@property (strong, nonatomic, readonly, nonnull) TBDropboxFolderEntry * entry;
@property (assign, nonatomic) BOOL recursive;
@property (assign, nonatomic) BOOL includeDeleted;
@property (assign, nonatomic) BOOL includeMediaInfo;
@property (assign, nonatomic) BOOL includeHasExplicitSharedMembers;

@property (strong, nonatomic, readonly, nullable) TBDropboxCursor * cursor;
@property (strong, nonatomic, readonly, nullable) NSArray<id<TBDropboxEntry>> * folderEntries;
@property (strong, nonatomic, readonly, nullable) NSArray<DBFILESMetadata *> * folderMetadata;

+ (instancetype)taskUsingEntry:(TBDropboxFolderEntry * _Nonnull)entry
                    completion:(TBDropboxTaskCompletion _Nonnull)completion;

+ (instancetype)taskUsingCursor:(NSString * _Nonnull)cursor
                     completion:(TBDropboxTaskCompletion _Nonnull)completion;

+ (instancetype)new __unavailable;
- (id) init __unavailable;

@end
