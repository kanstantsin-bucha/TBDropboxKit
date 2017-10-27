///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBSHARINGLinkAction;
@class DBSHARINGLinkPermission;
@class DBSHARINGPermissionDeniedReason;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `LinkPermission` struct.
///
/// Permissions for actions that can be performed on a link.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBSHARINGLinkPermission : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// (no description).
@property (nonatomic, readonly) DBSHARINGLinkAction *action;

/// (no description).
@property (nonatomic, readonly) NSNumber *allow;

/// (no description).
@property (nonatomic, readonly, nullable) DBSHARINGPermissionDeniedReason *reason;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param action (no description).
/// @param allow (no description).
/// @param reason (no description).
///
/// @return An initialized instance.
///
- (instancetype)initWithAction:(DBSHARINGLinkAction *)action
                         allow:(NSNumber *)allow
                        reason:(nullable DBSHARINGPermissionDeniedReason *)reason;

///
/// Convenience constructor (exposes only non-nullable instance variables with
/// no default value).
///
/// @param action (no description).
/// @param allow (no description).
///
/// @return An initialized instance.
///
- (instancetype)initWithAction:(DBSHARINGLinkAction *)action allow:(NSNumber *)allow;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `LinkPermission` struct.
///
@interface DBSHARINGLinkPermissionSerializer : NSObject

///
/// Serializes `DBSHARINGLinkPermission` instances.
///
/// @param instance An instance of the `DBSHARINGLinkPermission` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBSHARINGLinkPermission` API object.
///
+ (nullable NSDictionary *)serialize:(DBSHARINGLinkPermission *)instance;

///
/// Deserializes `DBSHARINGLinkPermission` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBSHARINGLinkPermission` API object.
///
/// @return An instantiation of the `DBSHARINGLinkPermission` object.
///
+ (DBSHARINGLinkPermission *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
