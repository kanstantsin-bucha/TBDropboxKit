///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBPAPERAddPaperDocUserMemberResult;
@class DBPAPERAddPaperDocUserResult;
@class DBSHARINGMemberSelector;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `AddPaperDocUserMemberResult` struct.
///
/// Per-member result for `docsUsersAdd`.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBPAPERAddPaperDocUserMemberResult : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// One of specified input members.
@property (nonatomic, readonly) DBSHARINGMemberSelector *member;

/// The outcome of the action on this member.
@property (nonatomic, readonly) DBPAPERAddPaperDocUserResult *result;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param member One of specified input members.
/// @param result The outcome of the action on this member.
///
/// @return An initialized instance.
///
- (instancetype)initWithMember:(DBSHARINGMemberSelector *)member result:(DBPAPERAddPaperDocUserResult *)result;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `AddPaperDocUserMemberResult` struct.
///
@interface DBPAPERAddPaperDocUserMemberResultSerializer : NSObject

///
/// Serializes `DBPAPERAddPaperDocUserMemberResult` instances.
///
/// @param instance An instance of the `DBPAPERAddPaperDocUserMemberResult` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBPAPERAddPaperDocUserMemberResult` API object.
///
+ (NSDictionary *)serialize:(DBPAPERAddPaperDocUserMemberResult *)instance;

///
/// Deserializes `DBPAPERAddPaperDocUserMemberResult` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBPAPERAddPaperDocUserMemberResult` API object.
///
/// @return An instantiation of the `DBPAPERAddPaperDocUserMemberResult` object.
///
+ (DBPAPERAddPaperDocUserMemberResult *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
