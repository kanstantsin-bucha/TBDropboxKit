///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGEnableDisableChangePolicy;
@class DBTEAMLOGTwoAccountChangePolicyDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `TwoAccountChangePolicyDetails` struct.
///
/// Enabled or disabled the option for team members to link a personal Dropbox
/// account in addition to their work account to the same computer.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGTwoAccountChangePolicyDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// New two account policy.
@property (nonatomic, readonly) DBTEAMLOGEnableDisableChangePolicy *dNewValue;

/// Previous two account policy. Might be missing due to historical data gap.
@property (nonatomic, readonly, nullable) DBTEAMLOGEnableDisableChangePolicy *previousValue;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param dNewValue New two account policy.
/// @param previousValue Previous two account policy. Might be missing due to
/// historical data gap.
///
/// @return An initialized instance.
///
- (instancetype)initWithDNewValue:(DBTEAMLOGEnableDisableChangePolicy *)dNewValue
                    previousValue:(nullable DBTEAMLOGEnableDisableChangePolicy *)previousValue;

///
/// Convenience constructor (exposes only non-nullable instance variables with
/// no default value).
///
/// @param dNewValue New two account policy.
///
/// @return An initialized instance.
///
- (instancetype)initWithDNewValue:(DBTEAMLOGEnableDisableChangePolicy *)dNewValue;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `TwoAccountChangePolicyDetails` struct.
///
@interface DBTEAMLOGTwoAccountChangePolicyDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGTwoAccountChangePolicyDetails` instances.
///
/// @param instance An instance of the `DBTEAMLOGTwoAccountChangePolicyDetails`
/// API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGTwoAccountChangePolicyDetails` API object.
///
+ (NSDictionary *)serialize:(DBTEAMLOGTwoAccountChangePolicyDetails *)instance;

///
/// Deserializes `DBTEAMLOGTwoAccountChangePolicyDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGTwoAccountChangePolicyDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGTwoAccountChangePolicyDetails`
/// object.
///
+ (DBTEAMLOGTwoAccountChangePolicyDetails *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
