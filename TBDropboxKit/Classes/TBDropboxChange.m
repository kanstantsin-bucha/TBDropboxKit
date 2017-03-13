//
//  TBDropboxChange.m
//  Pods
//
//  Created by Bucha Kanstantsin on 3/13/17.
//
//

#import "TBDropboxChange.h"



@implementation TBDropboxChange

/// MARK: - property - 

static NSPredicate * _outgoingChangesPredicate;

+ (NSPredicate *)outgoingChangesPredicate {
    if (_outgoingChangesPredicate != nil) {
        return _outgoingChangesPredicate;
    }
    _outgoingChangesPredicate =
    [NSPredicate predicateWithBlock:^BOOL(TBDropboxTask *  _Nullable task,
                                          NSDictionary<NSString *,id> * _Nullable bindings) {
        BOOL result = task.type == TBDropboxTaskTypeUploadChanges
        && task.state == TBDropboxTaskStateSucceed;
        return result;
    }];
    return _outgoingChangesPredicate;
}

/// MARK: - public-

+ (NSArray *)processChanges:(NSArray *)changes
        byExcludingOutgoing:(NSDictionary *)outgoingChanges {
    NSMutableArray * result = [NSMutableArray array];
    for (DBFILESMetadata * change in changes) {
        DBFILESMetadata * conterpart = outgoingChanges[change.pathDisplay];
        if (conterpart == nil) {
            [result addObject: change];
            continue;
        }
        
        BOOL bothSame = [self isChange: change
                      sameToConterpart: conterpart];
        if (bothSame == NO) {
            [result addObject: change];
        }
    }
    return [result copy];
}

+ (BOOL)isChange:(DBFILESMetadata *)change
sameToConterpart:(DBFILESMetadata *)conterpart {
    if ([conterpart class] != [change class]) {
        return NO;
    }
    
    if ([change class] == [DBFILESFileMetadata class]) {
        BOOL result = [self isFileChange: change
                        sameToConterpart: conterpart];
        return result;
    }
    
    if ([change class] == [DBFILESFolderMetadata class]) {
        BOOL result =
        [change.pathDisplay isEqualToString: conterpart.pathDisplay];
        return result;
    }
    
    if ([change class] == [DBFILESDeletedMetadata class]) {
        BOOL result =
        [change.pathDisplay isEqualToString: conterpart.pathDisplay];
        return result;
    }
    
    return NO;
}

/// MARK: - private -

+ (BOOL)isFileChange:(DBFILESFileMetadata *)change
    sameToConterpart:(DBFILESFileMetadata *)conterpart {
    if ([change.id_ isEqualToString: conterpart.id_] == NO) {
        return NO;
    }
    
    if ([change.contentHash isEqualToString: conterpart.contentHash] == NO) {
        return NO;
    }
    
    if ([change.rev isEqualToString: conterpart.rev] == NO) {
        return NO;
    }
    
    return YES;
}

+ (NSDictionary *)outgoingChangesUsingTasks:(NSArray<TBDropboxTask *> *)tasks {
    NSMutableDictionary * result = [NSMutableDictionary dictionary];
    NSArray * outgoingTasks =
        [tasks filteredArrayUsingPredicate: self.outgoingChangesPredicate];
    
    for (TBDropboxTask * task in outgoingTasks) {
        NSString * changePath = task.entry.dropboxPath;
        result[changePath] = task.entry.metadata;
    }
    
    return [result copy];
}

@end
