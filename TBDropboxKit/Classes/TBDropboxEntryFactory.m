//
//  TBDropboxEntryFactory.m
//  Pods
//
//  Created by Bucha Kanstantsin on 2/23/17.
//
//

#import "TBDropboxEntryFactory.h"
#import "TBDropboxEntry.h"
#import "TBDropboxFileEntry+Private.h"
#import "TBDropboxFolderEntry+Private.h"


@implementation TBDropboxEntryFactory

+ (TBDropboxFileEntry *)fileEntryUsingDropboxPath:(NSString *)path {
    TBDropboxFileEntry * result = [self fileEntryUsingDropboxPath: path
                                                             size: nil
                                                         metadata: nil];
    return result;
}

+ (TBDropboxFileEntry *)fileEntryUsingDropboxPath:(NSString *)path
                                             size:(NSNumber *)size
                                         metadata:(DBFILESMetadata *)metadata {

    if (path.length == 0) {
        return nil;
    }

    TBDropboxFileEntry * result = [[TBDropboxFileEntry alloc] initInstance];
    
    result.source = metadata == nil ? TBDropboxEntrySourcePath
                                    : TBDropboxEntrySourceMetadata;
    result.dropboxPath = path;
    result.size = size;
    result.metadata = metadata;
    
    return result;
}

+ (TBDropboxFolderEntry *)folderEntryUsingDropboxPath:(NSString *)path {
    TBDropboxFolderEntry * result = [self folderEntryUsingDropboxPath: path
                                                             metadata: nil];
    return result;
}

+ (TBDropboxFolderEntry *)folderEntryUsingDropboxPath:(NSString *)path
                                             metadata:(DBFILESMetadata *)metadata {
    TBDropboxFolderEntry * result = [[TBDropboxFolderEntry alloc] initInstance];

    result.source = metadata == nil ? TBDropboxEntrySourcePath
                                    : TBDropboxEntrySourceMetadata;
    result.dropboxPath = path != nil ? path
                                     : @"";
    result.metadata = metadata;
    
    return result;
}

+ (id<TBDropboxEntry>)entryUsingMetadata:(DBFILESMetadata *)metadata {
    
    NSNumber * size = sizeUsingMetadata(metadata);
    
    BOOL isFolder = size == nil;
    
    id<TBDropboxEntry> result =  isFolder ? [self folderEntryUsingDropboxPath: metadata.pathLower
                                                                     metadata: metadata]
                                          : [self fileEntryUsingDropboxPath: metadata.pathLower
                                                                       size: size
                                                                   metadata: metadata];
    
    return result;
}

+ (TBDropboxFileEntry *)fileEntryByMirroringLocalURL:(NSURL *)fileURL
                                        usingBaseURL:(NSURL *)baseURL {
    NSString * dropboxPath = [self relativeURLStringFromURL: fileURL
                                               usingBaseURL: baseURL];
    if (dropboxPath == nil) {
        return nil;
    }
    
    TBDropboxFileEntry * result = [self fileEntryUsingDropboxPath:dropboxPath];
    return result;
}

+ (NSString *)relativeURLStringFromURL:(NSURL *)URL
                          usingBaseURL:(NSURL *)baseURL {
    NSRange baseRange = [URL.path rangeOfString: baseURL.path];
    NSInteger relativeURLstartIndex = NSMaxRange(baseRange) + 1;
    if (baseRange.location == NSNotFound
        ||  relativeURLstartIndex >= URL.path.length) {
        return nil;
    }
    
    NSString * result = [URL.path substringFromIndex:relativeURLstartIndex];
    return result;
}

@end
