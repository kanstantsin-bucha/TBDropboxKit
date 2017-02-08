//
//  TBDropboxEntry.m
//  Pods
//
//  Created by Bucha Kanstantsin on 12/31/16.
//
//

#import "TBDropboxEntry.h"


@interface TBDropboxEntry ()

@property (assign, nonatomic, readwrite) TBDropboxEntrySource source;
@property (copy, nonatomic, readwrite) NSString * dropboxPath;
@property (strong, nonatomic, readwrite) DBFILESMetadata * metadata;

@end


@implementation TBDropboxEntry

+ (instancetype)itemUsing:(DBFILESMetadata *)fileMetadata {
    TBDropboxEntry * result = [TBDropboxEntry new];
    
    return result;
}

@end
