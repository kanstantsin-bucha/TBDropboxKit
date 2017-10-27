///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMActiveWebSession;
@class DBTEAMDesktopClientSession;
@class DBTEAMMemberDevices;
@class DBTEAMMobileClientSession;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `MemberDevices` struct.
///
/// Information on devices of a team's member.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMMemberDevices : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The member unique Id.
@property (nonatomic, readonly, copy) NSString *teamMemberId;

/// List of web sessions made by this team member.
@property (nonatomic, readonly, nullable) NSArray<DBTEAMActiveWebSession *> *webSessions;

/// List of desktop clients by this team member.
@property (nonatomic, readonly, nullable) NSArray<DBTEAMDesktopClientSession *> *desktopClients;

/// List of mobile clients by this team member.
@property (nonatomic, readonly, nullable) NSArray<DBTEAMMobileClientSession *> *mobileClients;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param teamMemberId The member unique Id.
/// @param webSessions List of web sessions made by this team member.
/// @param desktopClients List of desktop clients by this team member.
/// @param mobileClients List of mobile clients by this team member.
///
/// @return An initialized instance.
///
- (instancetype)initWithTeamMemberId:(NSString *)teamMemberId
                         webSessions:(nullable NSArray<DBTEAMActiveWebSession *> *)webSessions
                      desktopClients:(nullable NSArray<DBTEAMDesktopClientSession *> *)desktopClients
                       mobileClients:(nullable NSArray<DBTEAMMobileClientSession *> *)mobileClients;

///
/// Convenience constructor (exposes only non-nullable instance variables with
/// no default value).
///
/// @param teamMemberId The member unique Id.
///
/// @return An initialized instance.
///
- (instancetype)initWithTeamMemberId:(NSString *)teamMemberId;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `MemberDevices` struct.
///
@interface DBTEAMMemberDevicesSerializer : NSObject

///
/// Serializes `DBTEAMMemberDevices` instances.
///
/// @param instance An instance of the `DBTEAMMemberDevices` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMMemberDevices` API object.
///
+ (nullable NSDictionary *)serialize:(DBTEAMMemberDevices *)instance;

///
/// Deserializes `DBTEAMMemberDevices` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMMemberDevices` API object.
///
/// @return An instantiation of the `DBTEAMMemberDevices` object.
///
+ (DBTEAMMemberDevices *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
