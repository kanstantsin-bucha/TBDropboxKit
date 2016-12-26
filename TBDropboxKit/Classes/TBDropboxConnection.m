//
//  TBDropboxConnection.m
//  Pods
//
//  Created by Bucha Kanstantsin on 12/12/2016.
//
//

#import "TBDropboxConnection.h"
#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>


#define AccessTokenUIDKey @"TB.TBDropboxConnection.AccessToken.UID=NSString"


@interface TBDropboxConnection ()

@property (assign, nonatomic, readwrite) TBDropboxConnectionState state;
@property (copy, nonatomic) NSString * accessTokenUID;

@end


@implementation TBDropboxConnection

/// MARK: property

- (void)setConnectionDesired:(BOOL)connectionDesired {
    if (_connectionDesired == connectionDesired) {
        return;
    }
    
    _connectionDesired = connectionDesired;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_connectionDesired) {
            [self openConnection];
        } else {
            [self closeConnection];
        }
    });
}

- (void)setState:(TBDropboxConnectionState)state {
    if (_state == state) {
        return;
    }
    
    _state = state;
    [self noteConnectionStateChanged];
}

- (void)setAccessTokenUID:(NSString *)tokenUID {
    [self saveAccessTokenUID:tokenUID];
}

- (NSString *)accessTokenUID {
    NSString * reusult = [self loadPreviousAccessTokenUID];
    return reusult;
}

/// MARK: life cycle

+ (instancetype)sharedInstance {
    static TBDropboxConnection * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[super allocWithZone:NULL] init];
    });
    
    return _sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return self;
}

/// MARK: public

- (void)initiateWithConnectionDesired:(BOOL)desired
                          usingAppKey:(NSString *)key
                             delegate:(id<TBDropboxConnectionDelegate>)delegate {
    [self subscribeToNotifications];
    [DropboxClientsManager setupWithAppKey: key];
    self.delegate = delegate;
    
    if (self.accessTokenUID == nil) {
        self.state = TBDropboxConnectionStateDisconnected;
    } else {
        self.state = TBDropboxConnectionStatePaused;
    }
    
    self.connectionDesired = desired;
}

- (NSArray *)provideDropboxURLSchemes {
    NSArray * URLTypes =
        [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleURLTypes"];
    
    NSArray * URLShemes = [self flatURLSchemesUsingURLTypes: URLTypes];
    
    NSPredicate * dropboxSchemePredicate =
        [NSPredicate predicateWithFormat: @"SELF BEGINSWITH[cd] %@", @"db-"];
    NSArray * result = [URLShemes filteredArrayUsingPredicate: dropboxSchemePredicate];
    return result;
}

- (BOOL)handleAuthorisationRedirectURL:(NSURL *)url {
    if (url == nil) {
        return NO;
    }
    
    NSString * dropboxScheme = [self provideDropboxURLSchemes].firstObject;
    
    if ([url.scheme isEqualToString:dropboxScheme] == NO) {
        return NO;
    }
    
    BOOL result = [self handleDropboxAuthorisationRedirectURL:url];
    return result;
}

- (void)pauseConnection {
    if (self.state != TBDropboxConnectionStateConnected) {
        return;
    }
    
    [DropboxClientsManager resetClients];
    self.state = TBDropboxConnectionStatePaused;
}

- (void)resumeConnection {
    if (self.state != TBDropboxConnectionStatePaused) {
        return;
    }
    
    [self openConnection];
}

/// MARK: notifications

- (void)subscribeToNotifications {
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(appBecomeActive:)
                                                 name: UIApplicationDidBecomeActiveNotification
                                               object: nil];
}

/// MARK: private

- (void)authorize {
    if (self.state == TBDropboxConnectionStateUndefined) {
        return;
    }
    
    self.state = TBDropboxConnectionStateAuthorization;
    [self noteAuthStateChanged: TBDropboxAuthStateInitiated];
    [DropboxClientsManager authorizeFromController: [UIApplication sharedApplication]
                                        controller: [UIViewController new]
                                           openURL: ^(NSURL *url) {
        [self noteAuthStateChanged: TBDropboxAuthStateAuthorization];
        [[UIApplication sharedApplication] openURL: url];
    }
                                       browserAuth: YES];
}

/// MARK: connection logic

- (void)openConnection {
    if (self.state == TBDropboxConnectionStateAuthorization ||
        self.state == TBDropboxConnectionStateConnected) {
        return;
    }
    
    if (self.accessTokenUID != nil) {
        BOOL connected = [DropboxClientsManager reauthorizeClient: self.accessTokenUID];
        if (connected) {
            self.state = TBDropboxConnectionStateConnected;
            return;
        }
    }
    
    [self authorize];
}

- (void)closeConnection {
    if (self.state != TBDropboxConnectionStateConnected) {
        return;
    }
    
    [DropboxClientsManager unlinkClients];
    self.accessTokenUID = nil;
    self.state = TBDropboxConnectionStateDisconnected;
}

- (void)appBecomeActive:(NSNotification *)notification {
    if (self.state != TBDropboxConnectionStateAuthorization) {
        return;
    }
    
    self.state = TBDropboxConnectionStateDisconnected;
    [self noteAuthStateChanged: TBDropboxAuthStateCancelled];
}

/// MARK: note state changes

- (void)noteConnectionStateChanged {
    SEL stateChangeSEL = @selector(dropboxConnection:didChangeStateTo:);
    if ([self.delegate respondsToSelector: stateChangeSEL] == NO) {
        return;
    }
    
    [self.delegate dropboxConnection: self
                    didChangeStateTo: self.state];
}

- (void)noteAuthStateChanged:(TBDropboxAuthState)state {
    [self noteAuthStateChanged: state
                         error: nil];
}

- (void)noteAuthStateChanged:(TBDropboxAuthState)state
                       error:(NSError *)error {
    SEL authStateChangeSEL = @selector(dropboxConnection:didChangeAuthStateTo:withError:);
    if ([self.delegate respondsToSelector: authStateChangeSEL] == NO) {
        return;
    }
    
    [self.delegate dropboxConnection: self
                didChangeAuthStateTo: state
                           withError: error];
}

/// MARK: redirect URL

- (BOOL)handleDropboxAuthorisationRedirectURL:(NSURL *)url {
    DBOAuthResult * authResult = [DropboxClientsManager handleRedirectURL: url];
    if (authResult == nil) {
        return NO;
    }
    
    if ([authResult isSuccess]) {
        NSLog(@"Success! User is logged into Dropbox.");
        self.accessTokenUID = authResult.accessToken.uid;
        self.state = TBDropboxConnectionStateConnected;
        [self noteAuthStateChanged: TBDropboxAuthStateSucceed];
    } else if ([authResult isCancel]) {
        NSLog(@"Authorization flow was manually canceled by user!");
        self.state = TBDropboxConnectionStateDisconnected;
        [self noteAuthStateChanged: TBDropboxAuthStateCancelled];
    } else if ([authResult isError]) {
        NSLog(@"Error: %@", authResult);
        NSError * error = [self errorUsingAuthResult:authResult];
        self.state = TBDropboxConnectionStateDisconnected;
        [self noteAuthStateChanged: TBDropboxAuthStateGotError
                             error: error];
    }
    
    return YES;
}

- (NSArray *)flatURLSchemesUsingURLTypes:(NSArray *)types {
    NSMutableArray * result = [NSMutableArray array];
    for (NSDictionary * type in types) {
        NSArray * schemes = type[@"CFBundleURLSchemes"];
        if (schemes.count == 0) {
            continue;
        }
        
        [result addObjectsFromArray: schemes];
    }
    
    if (result.count == 0) {
        return nil;
    }
    
    return result;
}

/// MARK: token uid

- (void)saveAccessTokenUID:(NSString *)token {
    if (token == nil) {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject: token
                                              forKey: AccessTokenUIDKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)loadPreviousAccessTokenUID {
    NSString * result =
        [[NSUserDefaults standardUserDefaults] objectForKey: AccessTokenUIDKey];
        
    if ([result isKindOfClass:[NSString class]] == NO) {
        return nil;
    }
    
    return result;
}

/// MARK convert auth result to NSError

- (NSError *)errorUsingAuthResult:(DBOAuthResult *)result {
    /// TODO : create error using result
    return nil;
}

@end
