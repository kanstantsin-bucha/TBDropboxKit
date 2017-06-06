///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGShmodelTeamCopyDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `ShmodelTeamCopyDetails` struct.
///
/// Added a team member's file/folder to their Dropbox from a link.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGShmodelTeamCopyDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @return An initialized instance.
///
- (instancetype)initDefault;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `ShmodelTeamCopyDetails` struct.
///
@interface DBTEAMLOGShmodelTeamCopyDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGShmodelTeamCopyDetails` instances.
///
/// @param instance An instance of the `DBTEAMLOGShmodelTeamCopyDetails` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGShmodelTeamCopyDetails` API object.
///
+ (NSDictionary *)serialize:(DBTEAMLOGShmodelTeamCopyDetails *)instance;

///
/// Deserializes `DBTEAMLOGShmodelTeamCopyDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGShmodelTeamCopyDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGShmodelTeamCopyDetails` object.
///
+ (DBTEAMLOGShmodelTeamCopyDetails *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END