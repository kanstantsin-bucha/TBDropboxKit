//
//  TBDropboxEntry.m
//  Pods
//
//  Created by Bucha Kanstantsin on 12/31/16.
//
//

#import "TBDropboxFileEntry+Private.h"


@interface TBDropboxFileEntry ()

@end


@implementation TBDropboxFileEntry

/// MARK: life cycle

- (instancetype)initInstance {
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)description {
    NSString * result = [NSString stringWithFormat:@"%@ path: %@,\r\n%@",
                                                   StringFromDropboxEntrySource(self.source),
                                                   self.dropboxPath,
                                                   self.metadata.description];
    return result;
}

@end
