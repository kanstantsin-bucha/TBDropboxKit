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


@interface TBDropboxListTask : TBDropboxTask

@property (strong, nonatomic, readonly, nonnull) TBDropboxFolderEntry * entry;

+ (instancetype)taskUsingEntry:(TBDropboxFolderEntry * _Nonnull)entry
                    completion:(TBDropboxEntriesBlock _Nonnull)completion;

+ (instancetype)new __unavailable;
- (id) init __unavailable;

@end
