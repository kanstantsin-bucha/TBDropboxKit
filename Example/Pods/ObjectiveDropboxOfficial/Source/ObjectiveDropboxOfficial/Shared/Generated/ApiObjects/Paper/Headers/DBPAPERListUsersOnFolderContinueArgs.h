///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBPAPERRefPaperDoc.h"
#import "DBSerializableProtocol.h"

@class DBPAPERListUsersOnFolderContinueArgs;

#pragma mark - API Object

///
/// The `ListUsersOnFolderContinueArgs` struct.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBPAPERListUsersOnFolderContinueArgs : DBPAPERRefPaperDoc <DBSerializable>

#pragma mark - Instance fields

/// The cursor obtained from `docsFolderUsersList` or
/// `docsFolderUsersListContinue`. Allows for pagination.
@property (nonatomic, readonly, copy) NSString * _Nonnull cursor;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param docId (no description).
/// @param cursor The cursor obtained from `docsFolderUsersList` or
/// `docsFolderUsersListContinue`. Allows for pagination.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithDocId:(NSString * _Nonnull)docId cursor:(NSString * _Nonnull)cursor;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `ListUsersOnFolderContinueArgs` struct.
///
@interface DBPAPERListUsersOnFolderContinueArgsSerializer : NSObject

///
/// Serializes `DBPAPERListUsersOnFolderContinueArgs` instances.
///
/// @param instance An instance of the `DBPAPERListUsersOnFolderContinueArgs`
/// API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBPAPERListUsersOnFolderContinueArgs` API object.
///
+ (NSDictionary * _Nonnull)serialize:(DBPAPERListUsersOnFolderContinueArgs * _Nonnull)instance;

///
/// Deserializes `DBPAPERListUsersOnFolderContinueArgs` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBPAPERListUsersOnFolderContinueArgs` API object.
///
/// @return An instantiation of the `DBPAPERListUsersOnFolderContinueArgs`
/// object.
///
+ (DBPAPERListUsersOnFolderContinueArgs * _Nonnull)deserialize:(NSDictionary * _Nonnull)dict;

@end
