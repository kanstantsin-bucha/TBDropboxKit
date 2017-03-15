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
@property (strong, nonatomic, readonly, nonnull) TBDropboxCursor * cursor;
@property (assign, nonatomic) BOOL recursive;
@property (assign, nonatomic) BOOL includeDeleted;
@property (assign, nonatomic) BOOL includeMediaInfo;
@property (assign, nonatomic) BOOL includeHasExplicitSharedMembers;

+ (instancetype)taskUsingEntry:(TBDropboxFolderEntry * _Nonnull)entry
                    completion:(TBDropboxTaskCompletion _Nonnull)completion;

+ (instancetype)taskUsingEntry:(TBDropboxFolderEntry * _Nonnull)entry
                        cursor:(NSString * _Nonnull)cursor
                    completion:(TBDropboxTaskCompletion _Nonnull)completion;

+ (instancetype)new __unavailable;
- (id) init __unavailable;

@end
