//
//  TBDropboxFolderEntry.m
//  Pods
//
//  Created by Bucha Kanstantsin on 2/6/17.
//
//

#import "TBDropboxFolderEntry.h"
#import "TBDropboxFolderEntry+Private.h"


@interface TBDropboxFolderEntry ()

@property (copy, nonatomic, readwrite, nullable) TBDropboxEntryCursor * cursor;
@property (strong, nonatomic, readwrite, nullable) NSArray<TBDropboxEntry *> * folderEntries;

@end


@implementation TBDropboxFolderEntry

- (void)updateUsingMetadataEntries:(NSArray<DBFILESMetadata *> * _Nonnull)metadataEntries {
    NSMutableArray * folderEntries = [NSMutableArray new];
    
    for (DBFILESMetadata * metadata in metadataEntries) {
        TBDropboxEntry * entry = [TBDropboxEntry entryUsingMetadata: metadata];
        if (entry == nil) {
            NSLog(@"Could not create entry using metadata: %@", metadata);
            continue;
        }
        
        [folderEntries addObject: entry];
    }
    
    self.folderEntries = folderEntries;
}

- (void)updateCursor:(TBDropboxEntryCursor *)cursor {
    self.cursor = cursor;
}



@end
