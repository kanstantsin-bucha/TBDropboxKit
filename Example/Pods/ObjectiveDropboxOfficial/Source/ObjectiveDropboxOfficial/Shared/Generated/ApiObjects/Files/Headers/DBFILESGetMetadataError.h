///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILESGetMetadataError;
@class DBFILESLookupError;

#pragma mark - API Object

///
/// The `GetMetadataError` union.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILESGetMetadataError : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBFILESGetMetadataErrorTag` enum type represents the possible tag
/// states with which the `DBFILESGetMetadataError` union can exist.
typedef NS_ENUM(NSInteger, DBFILESGetMetadataErrorTag) {
  /// (no description).
  DBFILESGetMetadataErrorPath,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBFILESGetMetadataErrorTag tag;

/// (no description). @note Ensure the `isPath` method returns true before
/// accessing, otherwise a runtime exception will be raised.
@property (nonatomic, readonly) DBFILESLookupError * _Nonnull path;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "path".
///
/// @param path (no description).
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithPath:(DBFILESLookupError * _Nonnull)path;

- (nonnull instancetype)init NS_UNAVAILABLE;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value "path".
///
/// @note Call this method and ensure it returns true before accessing the
/// `path` property, otherwise a runtime exception will be thrown.
///
/// @return Whether the union's current tag state has value "path".
///
- (BOOL)isPath;

///
/// Retrieves string value of union's current tag state.
///
/// @return A human-readable string representing the union's current tag state.
///
- (NSString * _Nonnull)tagName;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `DBFILESGetMetadataError` union.
///
@interface DBFILESGetMetadataErrorSerializer : NSObject

///
/// Serializes `DBFILESGetMetadataError` instances.
///
/// @param instance An instance of the `DBFILESGetMetadataError` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILESGetMetadataError` API object.
///
+ (NSDictionary * _Nonnull)serialize:(DBFILESGetMetadataError * _Nonnull)instance;

///
/// Deserializes `DBFILESGetMetadataError` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILESGetMetadataError` API object.
///
/// @return An instantiation of the `DBFILESGetMetadataError` object.
///
+ (DBFILESGetMetadataError * _Nonnull)deserialize:(NSDictionary * _Nonnull)dict;

@end
