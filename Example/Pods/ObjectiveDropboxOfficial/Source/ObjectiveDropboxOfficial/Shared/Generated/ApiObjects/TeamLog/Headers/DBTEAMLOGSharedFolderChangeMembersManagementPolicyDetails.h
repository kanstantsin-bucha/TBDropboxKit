///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBSHARINGAclUpdatePolicy;
@class DBTEAMLOGSharedFolderChangeMembersManagementPolicyDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `SharedFolderChangeMembersManagementPolicyDetails` struct.
///
/// Changed who can add or remove members of a shared folder.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGSharedFolderChangeMembersManagementPolicyDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// New members management policy.
@property (nonatomic, readonly) DBSHARINGAclUpdatePolicy *dNewValue;

/// Previous members management policy. Might be missing due to historical data
/// gap.
@property (nonatomic, readonly, nullable) DBSHARINGAclUpdatePolicy *previousValue;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param dNewValue New members management policy.
/// @param previousValue Previous members management policy. Might be missing
/// due to historical data gap.
///
/// @return An initialized instance.
///
- (instancetype)initWithDNewValue:(DBSHARINGAclUpdatePolicy *)dNewValue
                    previousValue:(nullable DBSHARINGAclUpdatePolicy *)previousValue;

///
/// Convenience constructor (exposes only non-nullable instance variables with
/// no default value).
///
/// @param dNewValue New members management policy.
///
/// @return An initialized instance.
///
- (instancetype)initWithDNewValue:(DBSHARINGAclUpdatePolicy *)dNewValue;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the
/// `SharedFolderChangeMembersManagementPolicyDetails` struct.
///
@interface DBTEAMLOGSharedFolderChangeMembersManagementPolicyDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGSharedFolderChangeMembersManagementPolicyDetails`
/// instances.
///
/// @param instance An instance of the
/// `DBTEAMLOGSharedFolderChangeMembersManagementPolicyDetails` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGSharedFolderChangeMembersManagementPolicyDetails` API object.
///
+ (nullable NSDictionary *)serialize:(DBTEAMLOGSharedFolderChangeMembersManagementPolicyDetails *)instance;

///
/// Deserializes `DBTEAMLOGSharedFolderChangeMembersManagementPolicyDetails`
/// instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGSharedFolderChangeMembersManagementPolicyDetails` API object.
///
/// @return An instantiation of the
/// `DBTEAMLOGSharedFolderChangeMembersManagementPolicyDetails` object.
///
+ (DBTEAMLOGSharedFolderChangeMembersManagementPolicyDetails *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END