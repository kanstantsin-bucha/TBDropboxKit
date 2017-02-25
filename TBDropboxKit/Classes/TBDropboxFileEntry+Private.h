//
//  TBDropboxEntry+Private.h
//  Pods
//
//  Created by Bucha Kanstantsin on 2/22/17.
//
//

#import "TBDropboxFileEntry.h"

#ifndef TBDropboxFileEntry_Private_h
#define TBDropboxFileEntry_Private_h

@interface TBDropboxFileEntry ()

@property (assign, nonatomic, readwrite) TBDropboxEntrySource source;
@property (copy, nonatomic, readwrite) NSString * dropboxPath;
@property (strong, nonatomic, readwrite) DBFILESMetadata * metadata;
@property (copy, nonatomic, readwrite, nullable) NSNumber * size;

- (instancetype)initInstance;

@end

#endif /* TBDropboxFileEntry_Private_h */
