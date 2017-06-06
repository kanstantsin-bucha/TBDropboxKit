//
//  TBAppDelegate.m
//  TBDropboxKit
//
//  Created by truebucha on 12/12/2016.
//  Copyright (c) 2016 truebucha. All rights reserved.
//

#import "TBAppDelegate.h"
#import <TBDropboxKit/TBDropboxKit.h>

#define dExampleFileName @"japan.jpg"

@interface TBAppDelegate ()
<TBDropboxClientDelegate>

@property (strong, nonatomic, readonly) TBDropboxClient * dropbox;
@property (strong, nonatomic) NSURL * localDocumentsURL;
@property (strong, nonatomic, readonly) NSString * examplePath;

@end

@implementation TBAppDelegate

// MARK: - errors -

- (NSError *)taskCreationFailedErrorUsingInfo:(NSDictionary *)info {
    NSError * result = [NSError errorWithDomain: NSStringFromClass([self class])
                                           code: 3
                                       userInfo: info];
    return result;
}

// MARK: - property -

- (TBDropboxClient *)dropbox {
    TBDropboxClient * result = [TBDropboxClient sharedInstance];
    return result;
}

- (NSString *)examplePath {
    NSString * result = [@"/" stringByAppendingPathComponent: dExampleFileName];
    return result;
}

// MARK: - protocols -

// MARK: UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray * urls = [[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory
                                                            inDomains: NSUserDomainMask];
    self.localDocumentsURL = urls.firstObject;
    NSLog(@"documents directory url = %@", self.localDocumentsURL);

    // if nil key provided will use one from info plist CFBundleURLName
    // that matched db-*********** 
    [self.dropbox initiateWithConnectionDesired: YES
                                    usingAppKey: nil];
    [self.dropbox addDelegate: self];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    BOOL result = [self.dropbox.connection handleAuthorisationRedirectURL: url];
    return result;
}

// MARK: TBDropboxClientDelegate

- (void)client:(TBDropboxClient * _Nonnull)client
didReceiveIncomingChanges:(NSArray <TBDropboxChange *> * _Nullable)changes {

}

- (void)dropboxConnection:(TBDropboxConnection * _Nonnull)connection
         didChangeStateTo:(TBDropboxConnectionState)state {
    if (state == TBDropboxConnectionStateConnected
        || state == TBDropboxConnectionStateReconnected) {
        
        // Upload example file to app folder in dropbox
        [self uploadExampleFileWithComplation:^(NSError * _Nullable error) {
        
            // download that file to local documents directory
            [self downloadLocalDocumentFromDropboxPath: self.examplePath
                                            completion: ^(NSError * _Nullable error) {
                // disconnecting
                self.dropbox.connectionDesired = NO;
            }];
        }];
    }
}

// MARK: - implementation -

- (void)uploadExampleFileWithComplation:(CDBErrorCompletion)completion {
    NSURL * exampleUrl =
        [[NSBundle mainBundle] URLForResource: [dExampleFileName stringByDeletingPathExtension]
                                withExtension: dExampleFileName.pathExtension];
    
    TBDropboxFileEntry * entry =
        [TBDropboxEntryFactory fileEntryUsingDropboxPath: self.examplePath];
    TBDropboxUploadFileTask * task =
        [TBDropboxUploadFileTask taskUsingEntry: entry
                                        fileURL: exampleUrl
                                     completion: ^(TBDropboxTask * _Nonnull task,
                                                   NSError * _Nullable error) {
        if (completion != nil) {
            completion(error);
        }
    }];
    
    [self.dropbox.tasksQueue addTask: task];
}

// Don't use it on user dropbox [IT DELETE EVERYTHING] it is only for app folder cleunup

- (void)cleanupDropboxAppContainerWithCompletion:(CDBErrorCompletion _Nonnull)completion {
    TBDropboxFolderEntry * rootEntry = [TBDropboxEntryFactory folderEntryUsingDropboxPath:nil];
    TBDropboxListFolderTask * listTask =
        [TBDropboxListFolderTask taskUsingEntry: rootEntry
                                     completion: ^(TBDropboxTask * _Nonnull task,
                                                   NSError * _Nullable error) {
         NSArray * entries = [(TBDropboxListFolderTask *)task folderEntries];
         
         if (entries.count == 0) {
             if (completion != nil) {
                 completion(nil);
             }
             return;
         }
         
         __block NSUInteger counter = 0;
         __block NSUInteger count = entries.count;
         __block NSError * deleteError = nil;
         
         for (id<TBDropboxEntry> deleteEntry in entries) {
             TBDropboxDeleteEntryTask * deleteTask =
                [TBDropboxDeleteEntryTask taskUsingEntry: deleteEntry
                                              completion: ^(TBDropboxTask * _Nonnull task, NSError * _Nullable error) {
                    counter++;
                    if (deleteError != nil) {
                        deleteError = error;
                    }

                    if (counter == count
                        && completion != nil) {
                        completion(error);
                    }
                }];
             
             [self.dropbox.tasksQueue addTask: deleteTask];
         }
    }];
    
    if (listTask == nil
        && completion != nil) {
        NSDictionary * info = @{NSLocalizedDescriptionKey : @"List root folder task failed"};
        NSError * error = [self taskCreationFailedErrorUsingInfo: info];
        completion(error);
    }
    
    [self.dropbox.tasksQueue addTask: listTask];
}

- (void)downloadLocalDocumentFromDropboxPath:(NSString *)path
                                  completion:(CDBErrorCompletion)completion  {
    NSURL * docURL = [self.localDocumentsURL URLByAppendingPathComponent: path.lastPathComponent];
    [self downloadDocumentToURL: docURL
                fromDropboxPath: path
                     completion: completion];
}

- (void)uploadLocalDocumentAtUrl:(NSURL *)url {
    
    TBDropboxTask * uploadTask =
        [self dropboxUploadTaskUsingDocumentURL: url
                                        baseURL: self.localDocumentsURL
                                 withCompletion: ^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"FAILED dropboxSyncChangedFileAtURL: %@", url);
        }
    }];
    
    if (uploadTask == nil) {
        NSLog(@"FAILED create task for dropboxSyncChangedFileAtURL: %@\
                   \r baseURL: %@", url, self.localDocumentsURL);
    }
    
    [self.dropbox.tasksQueue addTask: uploadTask];
}

- (void)downloadDocumentToURL:(NSURL *)URL
              fromDropboxPath:(NSString *)path
                   completion:(CDBErrorCompletion)completion  {

    TBDropboxFileEntry * entry =
        [TBDropboxEntryFactory fileEntryUsingDropboxPath: path];
    TBDropboxTask * downloadTask =
        [TBDropboxDownloadFileTask taskUsingEntry: entry
                                          fileURL: URL
                                       completion: ^(TBDropboxTask * _Nonnull task, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"FAILED dropboxSyncChangedDocumentAtURL: %@\
                       /r Dropbox path %@", URL, path);
        }
        if (completion != nil) {
            completion(error);
        }
    }];
    
    if (downloadTask == nil) {
        NSLog(@"FAILED create task for dropboxSyncChangedDocumentAtURL: %@\
                   \r Dropbox path: %@", URL, path);
    }
    
    [self.dropbox.tasksQueue addTask: downloadTask];
}


// MARK: tasks

- (TBDropboxCreateFolderTask *)dropboxCreateFolderTaskUsingDirectoryURL:(NSURL *)documentURL
                                                                baseURL:(NSURL *)baseURL
                                                         withCompletion:(CDBErrorCompletion)completion {
    TBDropboxFolderEntry * entry =
        [TBDropboxEntryFactory folderEntryByMirroringLocalURL: documentURL
                                                 usingBaseURL: baseURL];
    TBDropboxCreateFolderTask * result =
        [TBDropboxCreateFolderTask taskUsingEntry: entry
                                       completion: ^(TBDropboxTask * _Nonnull task,
                                                     NSError * _Nullable error) {
        if (completion != nil) {
            // we don't provide error because dropbox create folders
            // for uploaded files itself, now we just want to create empty folders if not exists
            completion(nil);
        }
    }];
    
    return result;
}

- (TBDropboxUploadFileTask *)dropboxUploadTaskUsingDocumentURL:(NSURL *)documentURL
                                                       baseURL:(NSURL *)baseURL
                                                withCompletion:(CDBErrorCompletion)completion {
    TBDropboxFileEntry * entry =
        [TBDropboxEntryFactory fileEntryByMirroringLocalURL: documentURL
                                               usingBaseURL: baseURL];
    TBDropboxUploadFileTask * result =
        [TBDropboxUploadFileTask taskUsingEntry: entry
                                        fileURL: documentURL
                                     completion: ^(TBDropboxTask * _Nonnull task,
                                                   NSError * _Nullable error) {
        if (completion != nil) {
            completion(error);
        }
    }];
    
    return result;
}

- (TBDropboxDeleteEntryTask *)dropboxDeleteTaskUsingDocumentURL:(NSURL *)documentURL
                                                        baseURL:(NSURL *)baseURL
                                                 withCompletion:(CDBErrorCompletion)completion {
    TBDropboxFileEntry * entry =
    [TBDropboxEntryFactory fileEntryByMirroringLocalURL: documentURL
                                           usingBaseURL: baseURL];
    TBDropboxDeleteEntryTask * result =
        [TBDropboxDeleteEntryTask taskUsingEntry: entry
                                      completion: ^(TBDropboxTask * _Nonnull task,
                                                    NSError * _Nullable error) {
        completion(error);
    }];
    
    return result;
}

- (TBDropboxMoveEntryTask *)dropboxMoveTaskUsingDocumentURL:(NSURL *)documentURL
                                             destinationURL:(NSURL *)destinationURL
                                                    baseURL:(NSURL *)baseURL
                                             withCompletion:(CDBErrorCompletion)completion {
    TBDropboxFileEntry * entry =
        [TBDropboxEntryFactory fileEntryByMirroringLocalURL: documentURL
                                               usingBaseURL: baseURL];
    TBDropboxFileEntry * destinationEntry =
        [TBDropboxEntryFactory fileEntryByMirroringLocalURL: destinationURL
                                               usingBaseURL: baseURL];
    TBDropboxMoveEntryTask * result =
        [TBDropboxMoveEntryTask taskUsingEntry: entry
                              destinationEntry: destinationEntry
                                    completion: ^(TBDropboxTask * _Nonnull task,
                                                   NSError * _Nullable error) {
        completion(error);
    }];
    
    return result;
}



@end
