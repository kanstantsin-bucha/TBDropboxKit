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

+ (id<TBDropboxEntry>)entryUsingMetadata:(DBFILESMetadata *)fileMetadata;
+ (id<TBDropboxEntry>)entryUsingDropboxPath:(NSString *)path;
+ (id<TBDropboxEntry>)entryUsingDropboxPath:(NSString *)path
                                   isFolder:(BOOL)folder;

@end
