//
//  TBDropboxFolderEntry.h
//  Pods
//
//  Created by Bucha Kanstantsin on 2/6/17.
//
//

#import "TBDropbox.h"
#import "TBDropboxEntry.h"

#define TBDropboxFolderEntry_Root_Folder_Path @""

@interface TBDropboxFolderEntry : NSObject<TBDropboxEntry>

@property (copy, nonatomic, readonly, nullable) TBDropboxCursor * cursor;
@property (strong, nonatomic, readonly, nullable) NSArray<id<TBDropboxEntry>> * childEntries;

+ (instancetype)new __unavailable;
- (id) init __unavailable;


@end
