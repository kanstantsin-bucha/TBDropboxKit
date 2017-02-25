//
//  TBDropboxEntryFactory.m
//  Pods
//
//  Created by Bucha Kanstantsin on 2/23/17.
//
//

#import "TBDropboxEntryFactory.h"
#import "TBDropboxFileEntry+Private.h"
#import "TBDropboxFolderEntry+Private.h"


@implementation TBDropboxEntryFactory

+ (id<TBDropboxEntry>)entryUsingDropboxPath:(NSString *)path {
    id<TBDropboxEntry> result = [self entryUsingDropboxPath: path
                                                   isFolder: NO];
    return result;
}

+ (id<TBDropboxEntry>)entryUsingDropboxPath:(NSString *)path
                                   isFolder:(BOOL)folder {
    TBDropboxFileEntry * result = nil;
    if (folder) {
        result = [[TBDropboxFolderEntry alloc] initInstance];
    } else {
        result = [[TBDropboxFileEntry alloc] initInstance];
    }
    
    result.source = TBDropboxEntrySourcePath;
    
    result.dropboxPath = path != nil ? path
                                     : @"";
    return result;
}

+ (id<TBDropboxEntry>)entryUsingMetadata:(DBFILESMetadata *)fileMetadata {
    
    TBDropboxFileEntry * result = [[[self class] alloc] initInstance];
    
    result.source = TBDropboxEntrySourceMetadata;
    
    result.dropboxPath = fileMetadata.pathLower;
    result.metadata = fileMetadata;
    
    NSNumber * size = sizeUsingMetadata(fileMetadata);
    result.size = size;
    
    return result;
}

@end
