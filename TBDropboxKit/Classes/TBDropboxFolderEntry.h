//
//  TBDropboxFolderEntry.h
//  Pods
//
//  Created by Bucha Kanstantsin on 2/6/17.
//
//

#import "TBDropbox.h"
#import "TBDropboxEntry.h"

typedef void (^TBDropboxEntriesBlock) (NSArray<id<TBDropboxEntry>> * _Nullable entries,
                                       NSError * _Nullable error);


@interface TBDropboxFolderEntry : NSObject<TBDropboxEntry>

@property (copy, nonatomic, readonly, nullable) TBDropboxEntryCursor * cursor;
@property (strong, nonatomic, readonly, nullable) NSArray<id<TBDropboxEntry>> * folderEntries;

+ (instancetype)new __unavailable;
- (id) init __unavailable;


@end
