//
//  TBDropboxMoveEntryTask.h
//  Pods
//
//  Created by Bucha Kanstantsin on 3/11/17.
//
//

#import <TBDropboxKit/TBDropboxKit.h>
#import "TBDropboxEntry.h"

@interface TBDropboxMoveEntryTask : TBDropboxTask

@property (strong, nonatomic, readonly, nonnull) id<TBDropboxEntry> entry;
@property (strong, nonatomic, readonly, nonnull) id<TBDropboxEntry> destinationEntry;

+ (instancetype)taskUsingEntry:(id<TBDropboxEntry> _Nonnull)entry
              destinationEntry:(id<TBDropboxEntry> _Nonnull)destinationEntry
                    completion:(TBDropboxTaskCompletion _Nonnull)completion;

+ (instancetype)new __unavailable;
- (id) init __unavailable;

@end
