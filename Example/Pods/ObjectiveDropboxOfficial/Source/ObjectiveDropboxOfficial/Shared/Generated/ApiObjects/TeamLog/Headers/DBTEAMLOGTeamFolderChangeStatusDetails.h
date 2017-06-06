///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGTeamFolderChangeStatusDetails;
@class DBTEAMLOGTeamFolderStatus;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `TeamFolderChangeStatusDetails` struct.
///
/// Changed the archival status of a team folder.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGTeamFolderChangeStatusDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// New team folder status.
@property (nonatomic, readonly) DBTEAMLOGTeamFolderStatus *dNewStatus;

/// Previous team folder status. Might be missing due to historical data gap.
@property (nonatomic, readonly, nullable) DBTEAMLOGTeamFolderStatus *previousStatus;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param dNewStatus New team folder status.
/// @param previousStatus Previous team folder status. Might be missing due to
/// historical data gap.
///
/// @return An initialized instance.
///
- (instancetype)initWithDNewStatus:(DBTEAMLOGTeamFolderStatus *)dNewStatus
                    previousStatus:(nullable DBTEAMLOGTeamFolderStatus *)previousStatus;

///
/// Convenience constructor (exposes only non-nullable instance variables with
/// no default value).
///
/// @param dNewStatus New team folder status.
///
/// @return An initialized instance.
///
- (instancetype)initWithDNewStatus:(DBTEAMLOGTeamFolderStatus *)dNewStatus;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `TeamFolderChangeStatusDetails` struct.
///
@interface DBTEAMLOGTeamFolderChangeStatusDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGTeamFolderChangeStatusDetails` instances.
///
/// @param instance An instance of the `DBTEAMLOGTeamFolderChangeStatusDetails`
/// API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGTeamFolderChangeStatusDetails` API object.
///
+ (NSDictionary *)serialize:(DBTEAMLOGTeamFolderChangeStatusDetails *)instance;

///
/// Deserializes `DBTEAMLOGTeamFolderChangeStatusDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGTeamFolderChangeStatusDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGTeamFolderChangeStatusDetails`
/// object.
///
+ (DBTEAMLOGTeamFolderChangeStatusDetails *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
