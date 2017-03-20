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

+ (instancetype _Nullable)taskUsingEntry:(id<TBDropboxEntry> _Nonnull)entry
                        destinationEntry:(id<TBDropboxEntry> _Nonnull)destinationEntry
                              completion:(TBDropboxTaskCompletion _Nonnull)completion;

+ (instancetype _Nullable)new __unavailable;
- (id _Nullable) init __unavailable;

@end
