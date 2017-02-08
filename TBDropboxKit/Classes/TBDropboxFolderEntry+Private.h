//
//  TBDropboxFolderEntry+Private.h
//  Pods
//
//  Created by Bucha Kanstantsin on 2/8/17.
//
//

#ifndef TBDropboxFolderEntry_Private_h
#define TBDropboxFolderEntry_Private_h

#import "TBDropboxFolderEntry.h"

@interface TBDropboxFolderEntry ()

- (void)updateUsingMetadataEntries:(NSArray<DBFILESMetadata *> * _Nonnull)metadataEntries;
- (void)updateCursor:(TBDropboxEntryCursor * _Nonnull)cursor;

@end

#endif /* TBDropboxFolderEntry_Private_h */
