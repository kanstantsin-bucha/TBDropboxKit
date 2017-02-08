//
//  TBDropboxEntry.h
//  Pods
//
//  Created by Bucha Kanstantsin on 12/31/16.
//
//

#import <Foundation/Foundation.h>
#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>


typedef NS_ENUM(NSInteger, TBDropboxEntrySource) {
    TBDropboxEntrySourcePath = 0,
    TBDropboxEntrySourceMetadata = 1
};


@interface TBDropboxEntry : NSObject

@property (assign, nonatomic, readonly) TBDropboxEntrySource source;

@property (copy, nonatomic, readonly) NSString * dropboxPath;

@property (strong, nonatomic, readonly) DBFILESMetadata * metadata;

+ (instancetype)entryUsingMetadata:(DBFILESMetadata *)fileMetadata;
+ (instancetype)entryUsingDropboxPath:(NSString *)path;

@end
