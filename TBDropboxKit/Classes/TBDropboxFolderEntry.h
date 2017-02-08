//
//  TBDropboxFolderEntry.h
//  Pods
//
//  Created by Bucha Kanstantsin on 2/6/17.
//
//

#import "TBDropboxEntry.h"
#import "TBDropbox.h"


@interface TBDropboxFolderEntry : TBDropboxEntry

@property (copy, nonatomic, readonly, nullable) TBDropboxEntryCursor * cursor;
@property (strong, nonatomic, readonly, nullable) NSArray<TBDropboxEntry *> * folderEntries;

@end
