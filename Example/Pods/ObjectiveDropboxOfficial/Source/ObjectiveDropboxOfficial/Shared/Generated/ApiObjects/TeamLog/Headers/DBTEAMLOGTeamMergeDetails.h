///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGTeamMergeDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `TeamMergeDetails` struct.
///
/// Merged the team into another team.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGTeamMergeDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Merged from team name. Might be missing due to historical data gap.
@property (nonatomic, readonly, copy, nullable) NSString *mergedFromTeamName;

/// Merged to team name. Might be missing due to historical data gap.
@property (nonatomic, readonly, copy, nullable) NSString *mergedToTeamName;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param mergedFromTeamName Merged from team name. Might be missing due to
/// historical data gap.
/// @param mergedToTeamName Merged to team name. Might be missing due to
/// historical data gap.
///
/// @return An initialized instance.
///
- (instancetype)initWithMergedFromTeamName:(nullable NSString *)mergedFromTeamName
                          mergedToTeamName:(nullable NSString *)mergedToTeamName;

///
/// Convenience constructor (exposes only non-nullable instance variables with
/// no default value).
///
///
/// @return An initialized instance.
///
- (instancetype)initDefault;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `TeamMergeDetails` struct.
///
@interface DBTEAMLOGTeamMergeDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGTeamMergeDetails` instances.
///
/// @param instance An instance of the `DBTEAMLOGTeamMergeDetails` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGTeamMergeDetails` API object.
///
+ (NSDictionary *)serialize:(DBTEAMLOGTeamMergeDetails *)instance;

///
/// Deserializes `DBTEAMLOGTeamMergeDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGTeamMergeDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGTeamMergeDetails` object.
///
+ (DBTEAMLOGTeamMergeDetails *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
