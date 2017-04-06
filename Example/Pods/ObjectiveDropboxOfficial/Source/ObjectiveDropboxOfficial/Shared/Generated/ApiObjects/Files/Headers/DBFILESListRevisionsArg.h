///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILESListRevisionsArg;

#pragma mark - API Object

///
/// The `ListRevisionsArg` struct.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILESListRevisionsArg : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The path to the file you want to see the revisions of.
@property (nonatomic, readonly, copy) NSString * _Nonnull path;

/// The maximum number of revision entries returned.
@property (nonatomic, readonly) NSNumber * _Nonnull limit;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param path The path to the file you want to see the revisions of.
/// @param limit The maximum number of revision entries returned.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithPath:(NSString * _Nonnull)path limit:(NSNumber * _Nullable)limit;

///
/// Convenience constructor (exposes only non-nullable instance variables with
/// no default value).
///
/// @param path The path to the file you want to see the revisions of.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithPath:(NSString * _Nonnull)path;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `ListRevisionsArg` struct.
///
@interface DBFILESListRevisionsArgSerializer : NSObject

///
/// Serializes `DBFILESListRevisionsArg` instances.
///
/// @param instance An instance of the `DBFILESListRevisionsArg` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILESListRevisionsArg` API object.
///
+ (NSDictionary * _Nonnull)serialize:(DBFILESListRevisionsArg * _Nonnull)instance;

///
/// Deserializes `DBFILESListRevisionsArg` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILESListRevisionsArg` API object.
///
/// @return An instantiation of the `DBFILESListRevisionsArg` object.
///
+ (DBFILESListRevisionsArg * _Nonnull)deserialize:(NSDictionary * _Nonnull)dict;

@end
