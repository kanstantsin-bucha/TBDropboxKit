///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMListTeamAppsArg;

#pragma mark - API Object

///
/// The `ListTeamAppsArg` struct.
///
/// Arguments for `linkedAppsListTeamLinkedApps`.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMListTeamAppsArg : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// At the first call to the `linkedAppsListTeamLinkedApps` the cursor shouldn't
/// be passed. Then, if the result of the call includes a cursor, the following
/// requests should include the received cursors in order to receive the next
/// sub list of the team applications
@property (nonatomic, readonly, copy) NSString * _Nullable cursor;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param cursor At the first call to the `linkedAppsListTeamLinkedApps` the
/// cursor shouldn't be passed. Then, if the result of the call includes a
/// cursor, the following requests should include the received cursors in order
/// to receive the next sub list of the team applications
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithCursor:(NSString * _Nullable)cursor;

///
/// Convenience constructor (exposes only non-nullable instance variables with
/// no default value).
///
///
/// @return An initialized instance.
///
- (nonnull instancetype)initDefault;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `ListTeamAppsArg` struct.
///
@interface DBTEAMListTeamAppsArgSerializer : NSObject

///
/// Serializes `DBTEAMListTeamAppsArg` instances.
///
/// @param instance An instance of the `DBTEAMListTeamAppsArg` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMListTeamAppsArg` API object.
///
+ (NSDictionary * _Nonnull)serialize:(DBTEAMListTeamAppsArg * _Nonnull)instance;

///
/// Deserializes `DBTEAMListTeamAppsArg` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMListTeamAppsArg` API object.
///
/// @return An instantiation of the `DBTEAMListTeamAppsArg` object.
///
+ (DBTEAMListTeamAppsArg * _Nonnull)deserialize:(NSDictionary * _Nonnull)dict;

@end
