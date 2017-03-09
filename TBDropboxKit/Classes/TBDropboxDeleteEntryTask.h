//
//  TBDropboxDeleteEntryTask.h
//  Pods
//
//  Created by Bucha Kanstantsin on 3/9/17.
//
//

#import <TBDropboxKit/TBDropboxKit.h>
#import "TBDropboxEntry.h"


@interface TBDropboxDeleteEntryTask : TBDropboxTask

@property (strong, nonatomic, readonly, nonnull) id<TBDropboxEntry> entry;
@property (strong, nonatomic, readonly, nonnull) NSURL * fileURL;

+ (instancetype)taskUsingEntry:(id<TBDropboxEntry> _Nonnull)entry
                    completion:(TBDropboxTaskCompletion _Nonnull)completion;

+ (instancetype)new __unavailable;
- (id) init __unavailable;

@end
