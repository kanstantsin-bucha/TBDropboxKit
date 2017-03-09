//
//  TBDropboxFolderEntry.m
//  Pods
//
//  Created by Bucha Kanstantsin on 2/6/17.
//
//

#import "TBDropboxFolderEntry.h"
#import "TBDropboxFolderEntry+Private.h"
#import "TBDropboxEntryFactory.h"



@interface TBDropboxFolderEntry ()

@property (copy, nonatomic, readwrite, nullable) TBDropboxEntryCursor * cursor;
@property (strong, nonatomic, readwrite, nullable) NSArray<id<TBDropboxEntry>> * folderEntries;

@end


@implementation TBDropboxFolderEntry

/// MARK: property

- (NSString *)fileName {
    NSString * result = self.dropboxPath.lastPathComponent;
    return result;
}

/// MARK: life cycle

- (instancetype)initInstance {
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)description {
    NSString * result = [NSString stringWithFormat:@"%@ %@\r path: %@,\r%@",
                         NSStringFromClass([self class]),
                         StringFromDropboxEntrySource(self.source),
                         self.dropboxPath,
                         self.metadata.description];
    return result;
}



- (void)updateUsingMetadataEntries:(NSArray<DBFILESMetadata *> * _Nonnull)metadataEntries {
    NSMutableArray * folderEntries = [NSMutableArray new];
    
    for (DBFILESMetadata * metadata in metadataEntries) {
        id<TBDropboxEntry> entry = [TBDropboxEntryFactory entryUsingMetadata: metadata];
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
