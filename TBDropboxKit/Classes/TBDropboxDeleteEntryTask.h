//
//  TBDropboxDeleteEntryTask.h
//  Pods
//
//  Created by Bucha Kanstantsin on 3/9/17.
//
//

#import "TBDropboxEntry.h"
#import "TBDropboxTask.h"
#import "TBDropbox.h"

@interface TBDropboxDeleteEntryTask : TBDropboxTask

@property (strong, nonatomic, readonly, nonnull) id<TBDropboxEntry> entry;

+ (instancetype _Nullable)taskUsingEntry:(id<TBDropboxEntry> _Nonnull)entry
                              completion:(TBDropboxTaskCompletion _Nonnull)completion;

+ (instancetype _Nullable)new __unavailable;
- (id _Nullable) init __unavailable;

@end
