//
//  TBDropboxEntryFactory.h
//  Pods
//
//  Created by Bucha Kanstantsin on 2/23/17.
//
//

#import <Foundation/Foundation.h>
#import "TBDropboxFileEntry.h"
#import "TBDropboxFolderEntry.h"



@interface TBDropboxEntryFactory : NSObject

+ (id<TBDropboxEntry>)entryUsingMetadata:(DBFILESMetadata * _Nonnull)metadata;
+ (TBDropboxFileEntry *)fileEntryUsingDropboxPath:(NSString * _Nonnull)path;
+ (TBDropboxFolderEntry *)folderEntryUsingDropboxPath:(NSString * _Nullable)path;
+ (TBDropboxFileEntry *)fileEntryByMirroringLocalURL:(NSURL *)fileURL
                                        usingBaseURL:(NSURL *)baseURL;

@end
