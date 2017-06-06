///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGSharedFolderMembershipManagementPolicy;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `SharedFolderMembershipManagementPolicy` union.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGSharedFolderMembershipManagementPolicy : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBTEAMLOGSharedFolderMembershipManagementPolicyTag` enum type
/// represents the possible tag states with which the
/// `DBTEAMLOGSharedFolderMembershipManagementPolicy` union can exist.
typedef NS_ENUM(NSInteger, DBTEAMLOGSharedFolderMembershipManagementPolicyTag) {
  /// (no description).
  DBTEAMLOGSharedFolderMembershipManagementPolicyOwner,

  /// (no description).
  DBTEAMLOGSharedFolderMembershipManagementPolicyEditors,

  /// (no description).
  DBTEAMLOGSharedFolderMembershipManagementPolicyOther,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBTEAMLOGSharedFolderMembershipManagementPolicyTag tag;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "owner".
///
/// @return An initialized instance.
///
- (instancetype)initWithOwner;

///
/// Initializes union class with tag state of "editors".
///
/// @return An initialized instance.
///
- (instancetype)initWithEditors;

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (instancetype)initWithOther;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value "owner".
///
/// @return Whether the union's current tag state has value "owner".
///
- (BOOL)isOwner;

///
/// Retrieves whether the union's current tag state has value "editors".
///
/// @return Whether the union's current tag state has value "editors".
///
- (BOOL)isEditors;

///
/// Retrieves whether the union's current tag state has value "other".
///
/// @return Whether the union's current tag state has value "other".
///
- (BOOL)isOther;

///
/// Retrieves string value of union's current tag state.
///
/// @return A human-readable string representing the union's current tag state.
///
- (NSString *)tagName;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the
/// `DBTEAMLOGSharedFolderMembershipManagementPolicy` union.
///
@interface DBTEAMLOGSharedFolderMembershipManagementPolicySerializer : NSObject

///
/// Serializes `DBTEAMLOGSharedFolderMembershipManagementPolicy` instances.
///
/// @param instance An instance of the
/// `DBTEAMLOGSharedFolderMembershipManagementPolicy` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGSharedFolderMembershipManagementPolicy` API object.
///
+ (NSDictionary *)serialize:(DBTEAMLOGSharedFolderMembershipManagementPolicy *)instance;

///
/// Deserializes `DBTEAMLOGSharedFolderMembershipManagementPolicy` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGSharedFolderMembershipManagementPolicy` API object.
///
/// @return An instantiation of the
/// `DBTEAMLOGSharedFolderMembershipManagementPolicy` object.
///
+ (DBTEAMLOGSharedFolderMembershipManagementPolicy *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
