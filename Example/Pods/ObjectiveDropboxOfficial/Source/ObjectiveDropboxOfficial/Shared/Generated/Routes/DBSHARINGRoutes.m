///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import "DBASYNCLaunchEmptyResult.h"
#import "DBASYNCLaunchResultBase.h"
#import "DBASYNCPollArg.h"
#import "DBASYNCPollError.h"
#import "DBASYNCPollResultBase.h"
#import "DBFILESLookupError.h"
#import "DBRequestErrors.h"
#import "DBSHARINGAccessLevel.h"
#import "DBSHARINGAclUpdatePolicy.h"
#import "DBSHARINGAddFileMemberArgs.h"
#import "DBSHARINGAddFileMemberError.h"
#import "DBSHARINGAddFolderMemberArg.h"
#import "DBSHARINGAddFolderMemberError.h"
#import "DBSHARINGAddMember.h"
#import "DBSHARINGAddMemberSelectorError.h"
#import "DBSHARINGChangeFileMemberAccessArgs.h"
#import "DBSHARINGCreateSharedLinkArg.h"
#import "DBSHARINGCreateSharedLinkError.h"
#import "DBSHARINGCreateSharedLinkWithSettingsArg.h"
#import "DBSHARINGCreateSharedLinkWithSettingsError.h"
#import "DBSHARINGFileAction.h"
#import "DBSHARINGFileLinkMetadata.h"
#import "DBSHARINGFileMemberActionError.h"
#import "DBSHARINGFileMemberActionIndividualResult.h"
#import "DBSHARINGFileMemberActionResult.h"
#import "DBSHARINGFileMemberRemoveActionResult.h"
#import "DBSHARINGFilePermission.h"
#import "DBSHARINGFolderAction.h"
#import "DBSHARINGFolderLinkMetadata.h"
#import "DBSHARINGFolderPermission.h"
#import "DBSHARINGFolderPolicy.h"
#import "DBSHARINGGetFileMetadataArg.h"
#import "DBSHARINGGetFileMetadataBatchArg.h"
#import "DBSHARINGGetFileMetadataBatchResult.h"
#import "DBSHARINGGetFileMetadataError.h"
#import "DBSHARINGGetFileMetadataIndividualResult.h"
#import "DBSHARINGGetMetadataArgs.h"
#import "DBSHARINGGetSharedLinkFileError.h"
#import "DBSHARINGGetSharedLinkMetadataArg.h"
#import "DBSHARINGGetSharedLinksArg.h"
#import "DBSHARINGGetSharedLinksError.h"
#import "DBSHARINGGetSharedLinksResult.h"
#import "DBSHARINGGroupMembershipInfo.h"
#import "DBSHARINGInsufficientQuotaAmounts.h"
#import "DBSHARINGInviteeMembershipInfo.h"
#import "DBSHARINGJobError.h"
#import "DBSHARINGJobStatus.h"
#import "DBSHARINGLinkMetadata.h"
#import "DBSHARINGLinkPermissions.h"
#import "DBSHARINGLinkSettings.h"
#import "DBSHARINGListFileMembersArg.h"
#import "DBSHARINGListFileMembersBatchArg.h"
#import "DBSHARINGListFileMembersBatchResult.h"
#import "DBSHARINGListFileMembersContinueArg.h"
#import "DBSHARINGListFileMembersContinueError.h"
#import "DBSHARINGListFileMembersError.h"
#import "DBSHARINGListFileMembersIndividualResult.h"
#import "DBSHARINGListFilesArg.h"
#import "DBSHARINGListFilesContinueArg.h"
#import "DBSHARINGListFilesContinueError.h"
#import "DBSHARINGListFilesResult.h"
#import "DBSHARINGListFolderMembersArgs.h"
#import "DBSHARINGListFolderMembersContinueArg.h"
#import "DBSHARINGListFolderMembersContinueError.h"
#import "DBSHARINGListFolderMembersCursorArg.h"
#import "DBSHARINGListFoldersArgs.h"
#import "DBSHARINGListFoldersContinueArg.h"
#import "DBSHARINGListFoldersContinueError.h"
#import "DBSHARINGListFoldersResult.h"
#import "DBSHARINGListSharedLinksArg.h"
#import "DBSHARINGListSharedLinksError.h"
#import "DBSHARINGListSharedLinksResult.h"
#import "DBSHARINGMemberAccessLevelResult.h"
#import "DBSHARINGMemberAction.h"
#import "DBSHARINGMemberPolicy.h"
#import "DBSHARINGMemberSelector.h"
#import "DBSHARINGModifySharedLinkSettingsArgs.h"
#import "DBSHARINGModifySharedLinkSettingsError.h"
#import "DBSHARINGMountFolderArg.h"
#import "DBSHARINGMountFolderError.h"
#import "DBSHARINGParentFolderAccessInfo.h"
#import "DBSHARINGPathLinkMetadata.h"
#import "DBSHARINGPendingUploadMode.h"
#import "DBSHARINGRelinquishFileMembershipArg.h"
#import "DBSHARINGRelinquishFileMembershipError.h"
#import "DBSHARINGRelinquishFolderMembershipArg.h"
#import "DBSHARINGRelinquishFolderMembershipError.h"
#import "DBSHARINGRemoveFileMemberArg.h"
#import "DBSHARINGRemoveFileMemberError.h"
#import "DBSHARINGRemoveFolderMemberArg.h"
#import "DBSHARINGRemoveFolderMemberError.h"
#import "DBSHARINGRemoveMemberJobStatus.h"
#import "DBSHARINGRevokeSharedLinkArg.h"
#import "DBSHARINGRevokeSharedLinkError.h"
#import "DBSHARINGRouteObjects.h"
#import "DBSHARINGRoutes.h"
#import "DBSHARINGShareFolderArg.h"
#import "DBSHARINGShareFolderError.h"
#import "DBSHARINGShareFolderErrorBase.h"
#import "DBSHARINGShareFolderJobStatus.h"
#import "DBSHARINGShareFolderLaunch.h"
#import "DBSHARINGSharePathError.h"
#import "DBSHARINGSharedContentLinkMetadata.h"
#import "DBSHARINGSharedFileMembers.h"
#import "DBSHARINGSharedFileMetadata.h"
#import "DBSHARINGSharedFolderAccessError.h"
#import "DBSHARINGSharedFolderMemberError.h"
#import "DBSHARINGSharedFolderMembers.h"
#import "DBSHARINGSharedFolderMetadata.h"
#import "DBSHARINGSharedFolderMetadataBase.h"
#import "DBSHARINGSharedLinkError.h"
#import "DBSHARINGSharedLinkMetadata.h"
#import "DBSHARINGSharedLinkPolicy.h"
#import "DBSHARINGSharedLinkSettings.h"
#import "DBSHARINGSharedLinkSettingsError.h"
#import "DBSHARINGSharingFileAccessError.h"
#import "DBSHARINGSharingUserError.h"
#import "DBSHARINGTeamMemberInfo.h"
#import "DBSHARINGTransferFolderArg.h"
#import "DBSHARINGTransferFolderError.h"
#import "DBSHARINGUnmountFolderArg.h"
#import "DBSHARINGUnmountFolderError.h"
#import "DBSHARINGUnshareFileArg.h"
#import "DBSHARINGUnshareFileError.h"
#import "DBSHARINGUnshareFolderArg.h"
#import "DBSHARINGUnshareFolderError.h"
#import "DBSHARINGUpdateFileMemberArgs.h"
#import "DBSHARINGUpdateFolderMemberArg.h"
#import "DBSHARINGUpdateFolderMemberError.h"
#import "DBSHARINGUpdateFolderPolicyArg.h"
#import "DBSHARINGUpdateFolderPolicyError.h"
#import "DBSHARINGUserMembershipInfo.h"
#import "DBSHARINGViewerInfoPolicy.h"
#import "DBSHARINGVisibility.h"
#import "DBStoneBase.h"
#import "DBTransportClientProtocol.h"
#import "DBUSERSTeam.h"

@implementation DBSHARINGRoutes

- (instancetype)init:(id<DBTransportClient>)client {
  self = [super init];
  if (self) {
    _client = client;
  }
  return self;
}

- (DBRpcTask *)addFileMember:(NSString *)file members:(NSArray<DBSHARINGMemberSelector *> *)members {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGAddFileMember;
  DBSHARINGAddFileMemberArgs *arg = [[DBSHARINGAddFileMemberArgs alloc] initWithFile:file members:members];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)addFileMember:(NSString *)file
                     members:(NSArray<DBSHARINGMemberSelector *> *)members
               customMessage:(NSString *)customMessage
                       quiet:(NSNumber *)quiet
                 accessLevel:(DBSHARINGAccessLevel *)accessLevel
         addMessageAsComment:(NSNumber *)addMessageAsComment {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGAddFileMember;
  DBSHARINGAddFileMemberArgs *arg = [[DBSHARINGAddFileMemberArgs alloc] initWithFile:file
                                                                             members:members
                                                                       customMessage:customMessage
                                                                               quiet:quiet
                                                                         accessLevel:accessLevel
                                                                 addMessageAsComment:addMessageAsComment];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)addFolderMember:(NSString *)sharedFolderId members:(NSArray<DBSHARINGAddMember *> *)members {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGAddFolderMember;
  DBSHARINGAddFolderMemberArg *arg =
      [[DBSHARINGAddFolderMemberArg alloc] initWithSharedFolderId:sharedFolderId members:members];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)addFolderMember:(NSString *)sharedFolderId
                       members:(NSArray<DBSHARINGAddMember *> *)members
                         quiet:(NSNumber *)quiet
                 customMessage:(NSString *)customMessage {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGAddFolderMember;
  DBSHARINGAddFolderMemberArg *arg = [[DBSHARINGAddFolderMemberArg alloc] initWithSharedFolderId:sharedFolderId
                                                                                         members:members
                                                                                           quiet:quiet
                                                                                   customMessage:customMessage];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)changeFileMemberAccess:(NSString *)file
                               member:(DBSHARINGMemberSelector *)member
                          accessLevel:(DBSHARINGAccessLevel *)accessLevel {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGChangeFileMemberAccess;
  DBSHARINGChangeFileMemberAccessArgs *arg =
      [[DBSHARINGChangeFileMemberAccessArgs alloc] initWithFile:file member:member accessLevel:accessLevel];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)checkJobStatus:(NSString *)asyncJobId {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGCheckJobStatus;
  DBASYNCPollArg *arg = [[DBASYNCPollArg alloc] initWithAsyncJobId:asyncJobId];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)checkRemoveMemberJobStatus:(NSString *)asyncJobId {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGCheckRemoveMemberJobStatus;
  DBASYNCPollArg *arg = [[DBASYNCPollArg alloc] initWithAsyncJobId:asyncJobId];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)checkShareJobStatus:(NSString *)asyncJobId {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGCheckShareJobStatus;
  DBASYNCPollArg *arg = [[DBASYNCPollArg alloc] initWithAsyncJobId:asyncJobId];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)createSharedLink:(NSString *)path {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGCreateSharedLink;
  DBSHARINGCreateSharedLinkArg *arg = [[DBSHARINGCreateSharedLinkArg alloc] initWithPath:path];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)createSharedLink:(NSString *)path
                       shortUrl:(NSNumber *)shortUrl
                  pendingUpload:(DBSHARINGPendingUploadMode *)pendingUpload {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGCreateSharedLink;
  DBSHARINGCreateSharedLinkArg *arg =
      [[DBSHARINGCreateSharedLinkArg alloc] initWithPath:path shortUrl:shortUrl pendingUpload:pendingUpload];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)createSharedLinkWithSettings:(NSString *)path {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGCreateSharedLinkWithSettings;
  DBSHARINGCreateSharedLinkWithSettingsArg *arg = [[DBSHARINGCreateSharedLinkWithSettingsArg alloc] initWithPath:path];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)createSharedLinkWithSettings:(NSString *)path settings:(DBSHARINGSharedLinkSettings *)settings {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGCreateSharedLinkWithSettings;
  DBSHARINGCreateSharedLinkWithSettingsArg *arg =
      [[DBSHARINGCreateSharedLinkWithSettingsArg alloc] initWithPath:path settings:settings];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)getFileMetadata:(NSString *)file {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGGetFileMetadata;
  DBSHARINGGetFileMetadataArg *arg = [[DBSHARINGGetFileMetadataArg alloc] initWithFile:file];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)getFileMetadata:(NSString *)file actions:(NSArray<DBSHARINGFileAction *> *)actions {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGGetFileMetadata;
  DBSHARINGGetFileMetadataArg *arg = [[DBSHARINGGetFileMetadataArg alloc] initWithFile:file actions:actions];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)getFileMetadataBatch:(NSArray<NSString *> *)files {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGGetFileMetadataBatch;
  DBSHARINGGetFileMetadataBatchArg *arg = [[DBSHARINGGetFileMetadataBatchArg alloc] initWithFiles:files];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)getFileMetadataBatch:(NSArray<NSString *> *)files actions:(NSArray<DBSHARINGFileAction *> *)actions {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGGetFileMetadataBatch;
  DBSHARINGGetFileMetadataBatchArg *arg =
      [[DBSHARINGGetFileMetadataBatchArg alloc] initWithFiles:files actions:actions];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)getFolderMetadata:(NSString *)sharedFolderId {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGGetFolderMetadata;
  DBSHARINGGetMetadataArgs *arg = [[DBSHARINGGetMetadataArgs alloc] initWithSharedFolderId:sharedFolderId];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)getFolderMetadata:(NSString *)sharedFolderId actions:(NSArray<DBSHARINGFolderAction *> *)actions {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGGetFolderMetadata;
  DBSHARINGGetMetadataArgs *arg =
      [[DBSHARINGGetMetadataArgs alloc] initWithSharedFolderId:sharedFolderId actions:actions];
  return [self.client requestRpc:route arg:arg];
}

- (DBDownloadUrlTask *)getSharedLinkFileUrl:(NSString *)url overwrite:(BOOL)overwrite destination:(NSURL *)destination {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGGetSharedLinkFile;
  DBSHARINGGetSharedLinkMetadataArg *arg = [[DBSHARINGGetSharedLinkMetadataArg alloc] initWithUrl:url];
  return [self.client requestDownload:route arg:arg overwrite:overwrite destination:destination];
}

- (DBDownloadUrlTask *)getSharedLinkFileUrl:(NSString *)url
                                       path:(NSString *)path
                               linkPassword:(NSString *)linkPassword
                                  overwrite:(BOOL)overwrite
                                destination:(NSURL *)destination {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGGetSharedLinkFile;
  DBSHARINGGetSharedLinkMetadataArg *arg =
      [[DBSHARINGGetSharedLinkMetadataArg alloc] initWithUrl:url path:path linkPassword:linkPassword];
  return [self.client requestDownload:route arg:arg overwrite:overwrite destination:destination];
}

- (DBDownloadDataTask *)getSharedLinkFileData:(NSString *)url {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGGetSharedLinkFile;
  DBSHARINGGetSharedLinkMetadataArg *arg = [[DBSHARINGGetSharedLinkMetadataArg alloc] initWithUrl:url];
  return [self.client requestDownload:route arg:arg];
}

- (DBDownloadDataTask *)getSharedLinkFileData:(NSString *)url
                                         path:(NSString *)path
                                 linkPassword:(NSString *)linkPassword {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGGetSharedLinkFile;
  DBSHARINGGetSharedLinkMetadataArg *arg =
      [[DBSHARINGGetSharedLinkMetadataArg alloc] initWithUrl:url path:path linkPassword:linkPassword];
  return [self.client requestDownload:route arg:arg];
}

- (DBRpcTask *)getSharedLinkMetadata:(NSString *)url {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGGetSharedLinkMetadata;
  DBSHARINGGetSharedLinkMetadataArg *arg = [[DBSHARINGGetSharedLinkMetadataArg alloc] initWithUrl:url];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)getSharedLinkMetadata:(NSString *)url path:(NSString *)path linkPassword:(NSString *)linkPassword {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGGetSharedLinkMetadata;
  DBSHARINGGetSharedLinkMetadataArg *arg =
      [[DBSHARINGGetSharedLinkMetadataArg alloc] initWithUrl:url path:path linkPassword:linkPassword];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)getSharedLinks {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGGetSharedLinks;
  DBSHARINGGetSharedLinksArg *arg = [[DBSHARINGGetSharedLinksArg alloc] init];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)getSharedLinks:(NSString *)path {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGGetSharedLinks;
  DBSHARINGGetSharedLinksArg *arg = [[DBSHARINGGetSharedLinksArg alloc] initWithPath:path];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listFileMembers:(NSString *)file {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListFileMembers;
  DBSHARINGListFileMembersArg *arg = [[DBSHARINGListFileMembersArg alloc] initWithFile:file];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listFileMembers:(NSString *)file
                       actions:(NSArray<DBSHARINGMemberAction *> *)actions
              includeInherited:(NSNumber *)includeInherited
                         limit:(NSNumber *)limit {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListFileMembers;
  DBSHARINGListFileMembersArg *arg = [[DBSHARINGListFileMembersArg alloc] initWithFile:file
                                                                               actions:actions
                                                                      includeInherited:includeInherited
                                                                                 limit:limit];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listFileMembersBatch:(NSArray<NSString *> *)files {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListFileMembersBatch;
  DBSHARINGListFileMembersBatchArg *arg = [[DBSHARINGListFileMembersBatchArg alloc] initWithFiles:files];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listFileMembersBatch:(NSArray<NSString *> *)files limit:(NSNumber *)limit {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListFileMembersBatch;
  DBSHARINGListFileMembersBatchArg *arg = [[DBSHARINGListFileMembersBatchArg alloc] initWithFiles:files limit:limit];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listFileMembersContinue:(NSString *)cursor {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListFileMembersContinue;
  DBSHARINGListFileMembersContinueArg *arg = [[DBSHARINGListFileMembersContinueArg alloc] initWithCursor:cursor];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listFolderMembers:(NSString *)sharedFolderId {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListFolderMembers;
  DBSHARINGListFolderMembersArgs *arg = [[DBSHARINGListFolderMembersArgs alloc] initWithSharedFolderId:sharedFolderId];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listFolderMembers:(NSString *)sharedFolderId
                         actions:(NSArray<DBSHARINGMemberAction *> *)actions
                           limit:(NSNumber *)limit {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListFolderMembers;
  DBSHARINGListFolderMembersArgs *arg =
      [[DBSHARINGListFolderMembersArgs alloc] initWithSharedFolderId:sharedFolderId actions:actions limit:limit];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listFolderMembersContinue:(NSString *)cursor {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListFolderMembersContinue;
  DBSHARINGListFolderMembersContinueArg *arg = [[DBSHARINGListFolderMembersContinueArg alloc] initWithCursor:cursor];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listFolders {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListFolders;
  DBSHARINGListFoldersArgs *arg = [[DBSHARINGListFoldersArgs alloc] init];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listFolders:(NSNumber *)limit actions:(NSArray<DBSHARINGFolderAction *> *)actions {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListFolders;
  DBSHARINGListFoldersArgs *arg = [[DBSHARINGListFoldersArgs alloc] initWithLimit:limit actions:actions];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listFoldersContinue:(NSString *)cursor {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListFoldersContinue;
  DBSHARINGListFoldersContinueArg *arg = [[DBSHARINGListFoldersContinueArg alloc] initWithCursor:cursor];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listMountableFolders {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListMountableFolders;
  DBSHARINGListFoldersArgs *arg = [[DBSHARINGListFoldersArgs alloc] init];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listMountableFolders:(NSNumber *)limit actions:(NSArray<DBSHARINGFolderAction *> *)actions {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListMountableFolders;
  DBSHARINGListFoldersArgs *arg = [[DBSHARINGListFoldersArgs alloc] initWithLimit:limit actions:actions];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listMountableFoldersContinue:(NSString *)cursor {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListMountableFoldersContinue;
  DBSHARINGListFoldersContinueArg *arg = [[DBSHARINGListFoldersContinueArg alloc] initWithCursor:cursor];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listReceivedFiles {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListReceivedFiles;
  DBSHARINGListFilesArg *arg = [[DBSHARINGListFilesArg alloc] init];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listReceivedFiles:(NSNumber *)limit actions:(NSArray<DBSHARINGFileAction *> *)actions {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListReceivedFiles;
  DBSHARINGListFilesArg *arg = [[DBSHARINGListFilesArg alloc] initWithLimit:limit actions:actions];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listReceivedFilesContinue:(NSString *)cursor {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListReceivedFilesContinue;
  DBSHARINGListFilesContinueArg *arg = [[DBSHARINGListFilesContinueArg alloc] initWithCursor:cursor];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listSharedLinks {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListSharedLinks;
  DBSHARINGListSharedLinksArg *arg = [[DBSHARINGListSharedLinksArg alloc] init];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)listSharedLinks:(NSString *)path cursor:(NSString *)cursor directOnly:(NSNumber *)directOnly {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGListSharedLinks;
  DBSHARINGListSharedLinksArg *arg =
      [[DBSHARINGListSharedLinksArg alloc] initWithPath:path cursor:cursor directOnly:directOnly];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)modifySharedLinkSettings:(NSString *)url settings:(DBSHARINGSharedLinkSettings *)settings {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGModifySharedLinkSettings;
  DBSHARINGModifySharedLinkSettingsArgs *arg =
      [[DBSHARINGModifySharedLinkSettingsArgs alloc] initWithUrl:url settings:settings];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)modifySharedLinkSettings:(NSString *)url
                               settings:(DBSHARINGSharedLinkSettings *)settings
                       removeExpiration:(NSNumber *)removeExpiration {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGModifySharedLinkSettings;
  DBSHARINGModifySharedLinkSettingsArgs *arg =
      [[DBSHARINGModifySharedLinkSettingsArgs alloc] initWithUrl:url
                                                        settings:settings
                                                removeExpiration:removeExpiration];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)mountFolder:(NSString *)sharedFolderId {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGMountFolder;
  DBSHARINGMountFolderArg *arg = [[DBSHARINGMountFolderArg alloc] initWithSharedFolderId:sharedFolderId];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)relinquishFileMembership:(NSString *)file {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGRelinquishFileMembership;
  DBSHARINGRelinquishFileMembershipArg *arg = [[DBSHARINGRelinquishFileMembershipArg alloc] initWithFile:file];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)relinquishFolderMembership:(NSString *)sharedFolderId {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGRelinquishFolderMembership;
  DBSHARINGRelinquishFolderMembershipArg *arg =
      [[DBSHARINGRelinquishFolderMembershipArg alloc] initWithSharedFolderId:sharedFolderId];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)relinquishFolderMembership:(NSString *)sharedFolderId leaveACopy:(NSNumber *)leaveACopy {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGRelinquishFolderMembership;
  DBSHARINGRelinquishFolderMembershipArg *arg =
      [[DBSHARINGRelinquishFolderMembershipArg alloc] initWithSharedFolderId:sharedFolderId leaveACopy:leaveACopy];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)removeFileMember:(NSString *)file member:(DBSHARINGMemberSelector *)member {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGRemoveFileMember;
  DBSHARINGRemoveFileMemberArg *arg = [[DBSHARINGRemoveFileMemberArg alloc] initWithFile:file member:member];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)removeFileMember2:(NSString *)file member:(DBSHARINGMemberSelector *)member {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGRemoveFileMember2;
  DBSHARINGRemoveFileMemberArg *arg = [[DBSHARINGRemoveFileMemberArg alloc] initWithFile:file member:member];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)removeFolderMember:(NSString *)sharedFolderId
                           member:(DBSHARINGMemberSelector *)member
                       leaveACopy:(NSNumber *)leaveACopy {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGRemoveFolderMember;
  DBSHARINGRemoveFolderMemberArg *arg = [[DBSHARINGRemoveFolderMemberArg alloc] initWithSharedFolderId:sharedFolderId
                                                                                                member:member
                                                                                            leaveACopy:leaveACopy];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)revokeSharedLink:(NSString *)url {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGRevokeSharedLink;
  DBSHARINGRevokeSharedLinkArg *arg = [[DBSHARINGRevokeSharedLinkArg alloc] initWithUrl:url];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)shareFolder:(NSString *)path {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGShareFolder;
  DBSHARINGShareFolderArg *arg = [[DBSHARINGShareFolderArg alloc] initWithPath:path];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)shareFolder:(NSString *)path
              memberPolicy:(DBSHARINGMemberPolicy *)memberPolicy
           aclUpdatePolicy:(DBSHARINGAclUpdatePolicy *)aclUpdatePolicy
          sharedLinkPolicy:(DBSHARINGSharedLinkPolicy *)sharedLinkPolicy
                forceAsync:(NSNumber *)forceAsync
                   actions:(NSArray<DBSHARINGFolderAction *> *)actions
              linkSettings:(DBSHARINGLinkSettings *)linkSettings
          viewerInfoPolicy:(DBSHARINGViewerInfoPolicy *)viewerInfoPolicy {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGShareFolder;
  DBSHARINGShareFolderArg *arg = [[DBSHARINGShareFolderArg alloc] initWithPath:path
                                                                  memberPolicy:memberPolicy
                                                               aclUpdatePolicy:aclUpdatePolicy
                                                              sharedLinkPolicy:sharedLinkPolicy
                                                                    forceAsync:forceAsync
                                                                       actions:actions
                                                                  linkSettings:linkSettings
                                                              viewerInfoPolicy:viewerInfoPolicy];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)transferFolder:(NSString *)sharedFolderId toDropboxId:(NSString *)toDropboxId {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGTransferFolder;
  DBSHARINGTransferFolderArg *arg =
      [[DBSHARINGTransferFolderArg alloc] initWithSharedFolderId:sharedFolderId toDropboxId:toDropboxId];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)unmountFolder:(NSString *)sharedFolderId {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGUnmountFolder;
  DBSHARINGUnmountFolderArg *arg = [[DBSHARINGUnmountFolderArg alloc] initWithSharedFolderId:sharedFolderId];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)unshareFile:(NSString *)file {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGUnshareFile;
  DBSHARINGUnshareFileArg *arg = [[DBSHARINGUnshareFileArg alloc] initWithFile:file];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)unshareFolder:(NSString *)sharedFolderId {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGUnshareFolder;
  DBSHARINGUnshareFolderArg *arg = [[DBSHARINGUnshareFolderArg alloc] initWithSharedFolderId:sharedFolderId];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)unshareFolder:(NSString *)sharedFolderId leaveACopy:(NSNumber *)leaveACopy {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGUnshareFolder;
  DBSHARINGUnshareFolderArg *arg =
      [[DBSHARINGUnshareFolderArg alloc] initWithSharedFolderId:sharedFolderId leaveACopy:leaveACopy];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)updateFileMember:(NSString *)file
                         member:(DBSHARINGMemberSelector *)member
                    accessLevel:(DBSHARINGAccessLevel *)accessLevel {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGUpdateFileMember;
  DBSHARINGUpdateFileMemberArgs *arg =
      [[DBSHARINGUpdateFileMemberArgs alloc] initWithFile:file member:member accessLevel:accessLevel];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)updateFolderMember:(NSString *)sharedFolderId
                           member:(DBSHARINGMemberSelector *)member
                      accessLevel:(DBSHARINGAccessLevel *)accessLevel {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGUpdateFolderMember;
  DBSHARINGUpdateFolderMemberArg *arg = [[DBSHARINGUpdateFolderMemberArg alloc] initWithSharedFolderId:sharedFolderId
                                                                                                member:member
                                                                                           accessLevel:accessLevel];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)updateFolderPolicy:(NSString *)sharedFolderId {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGUpdateFolderPolicy;
  DBSHARINGUpdateFolderPolicyArg *arg = [[DBSHARINGUpdateFolderPolicyArg alloc] initWithSharedFolderId:sharedFolderId];
  return [self.client requestRpc:route arg:arg];
}

- (DBRpcTask *)updateFolderPolicy:(NSString *)sharedFolderId
                     memberPolicy:(DBSHARINGMemberPolicy *)memberPolicy
                  aclUpdatePolicy:(DBSHARINGAclUpdatePolicy *)aclUpdatePolicy
                 viewerInfoPolicy:(DBSHARINGViewerInfoPolicy *)viewerInfoPolicy
                 sharedLinkPolicy:(DBSHARINGSharedLinkPolicy *)sharedLinkPolicy
                     linkSettings:(DBSHARINGLinkSettings *)linkSettings {
  DBRoute *route = DBSHARINGRouteObjects.DBSHARINGUpdateFolderPolicy;
  DBSHARINGUpdateFolderPolicyArg *arg = [[DBSHARINGUpdateFolderPolicyArg alloc] initWithSharedFolderId:sharedFolderId
                                                                                          memberPolicy:memberPolicy
                                                                                       aclUpdatePolicy:aclUpdatePolicy
                                                                                      viewerInfoPolicy:viewerInfoPolicy
                                                                                      sharedLinkPolicy:sharedLinkPolicy
                                                                                          linkSettings:linkSettings];
  return [self.client requestRpc:route arg:arg];
}

@end
