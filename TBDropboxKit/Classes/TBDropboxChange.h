//
//  TBDropboxChange.h
//  Pods
//
//  Created by Bucha Kanstantsin on 3/13/17.
//
//

#import <Foundation/Foundation.h>
#import "TBDropbox.h"
#import "TBDropboxTask.h"


@interface TBDropboxChange : NSObject

@property (strong, nonatomic) DBFILESMetadata * metadata;

+ (NSArray *)processChanges:(NSArray *)changes
        byExcludingOutgoing:(NSDictionary *)outgoingChanges;

+ (NSDictionary *)outgoingChangesUsingTasks:(NSArray<TBDropboxTask *> *)tasks;

@end
