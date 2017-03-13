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

+ (instancetype)taskUsingEntry:(id<TBDropboxEntry> _Nonnull)entry
                    completion:(TBDropboxTaskCompletion _Nonnull)completion;

+ (instancetype)new __unavailable;
- (id) init __unavailable;

@end
