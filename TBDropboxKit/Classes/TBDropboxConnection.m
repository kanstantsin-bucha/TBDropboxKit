//
//  TBDropboxConnection.m
//  Pods
//
//  Created by Bucha Kanstantsin on 12/12/2016.
//
//

#import "TBDropboxConnection+Private.h"


#define AccessTokenUIDKey @"TB.TBDropboxConnection.AccessToken.UID=NSString"


@interface TBDropboxConnection ()

@property (assign, nonatomic, readwrite) TBDropboxConnectionState state;
@property (copy, nonatomic, readwrite) NSString * accessTokenUID;

@end


@implementation TBDropboxConnection

@synthesize accessTokenUID = _accessTokenUID;

/// MARK: property

- (void)setState:(TBDropboxConnectionState)state {
    if (_state == state) {
        return;
    }
    
    _state = state;
    
    if (state == TBDropboxConnectionStateConnected) {
        [self noteChangedSessionID: self.accessTokenUID];
    }
    
    [self noteConnectionStateChanged];
}

- (void)setAccessTokenUID:(NSString *)tokenUID {
    if (_accessTokenUID == tokenUID) {
        return;
    }
    _accessTokenUID = tokenUID;
    
    [self saveAccessTokenUID: tokenUID];
}

- (NSString *)accessTokenUID {
    if (_accessTokenUID != nil) {
        return _accessTokenUID;
    }
    
    _accessTokenUID = [self loadPreviousAccessTokenUID];
    return _accessTokenUID;
}

/// MARK: life cycle

- (instancetype)initInstance {
    if (self = [super init]) {
    }
    return self;
}

+ (instancetype _Nullable)connectionUsingAppKey:(NSString * _Nonnull)key
                                       delegate:(id<TBDropboxConnectionDelegate> _Nonnull)delegate {
    if (key == nil
        || delegate == nil) {
        return nil;
    }
    
    TBDropboxConnection * result = [[[self class] alloc] initInstance];
    [result subscribeToNotifications];
    [DBClientsManager setupWithAppKey: key];
    result.delegate = delegate;
    result.state = TBDropboxConnectionStateDisconnected;
    
    return result;
}

/// MARK: public

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

/// MARK - protected -

- (void)openConnection {
    if (self.state == TBDropboxConnectionStateAuthorization ||
        self.state == TBDropboxConnectionStateConnected) {
        return;
    }
    
    if (self.accessTokenUID != nil) {
        DBUserClient * client =
            [self authorizedClientUsingTokenUID: self.accessTokenUID];
        if (client != nil) {
            [DBClientsManager setAuthorizedClient:client];
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
    
    [DBClientsManager resetClients];
    self.accessTokenUID = nil;
    self.state = TBDropboxConnectionStateDisconnected;
}

- (void)pauseConnection {
    if (self.state != TBDropboxConnectionStateConnected) {
        return;
    }
    
    [DBClientsManager resetClients];
    self.state = TBDropboxConnectionStatePaused;
}

- (void)reauthorizeClient {
    
    DBOAuthManager * manager = [DBOAuthManager sharedOAuthManager];
    DBAccessToken * token = [manager getAccessToken: self.accessTokenUID];
    if (token != nil) {
        [[DBOAuthManager sharedOAuthManager] clearStoredAccessToken: token];
    }
    self.accessTokenUID = nil;
    [DBClientsManager setAuthorizedClient: nil];
    NSLog(@"Clear authorized user token during Auth error. Make user authorize again");
    
    [self authorize];
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
    [DBClientsManager authorizeFromController: [UIApplication sharedApplication]
                                   controller: [UIViewController new]
                                      openURL: ^(NSURL *url) {
        [self noteAuthStateChanged: TBDropboxAuthStateAuthorization];
        [[UIApplication sharedApplication] openURL: url];
    }
                                       browserAuth: YES];
}

/// MARK: connection logic

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
    DBOAuthResult * authResult = [DBClientsManager handleRedirectURL: url];
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

- (DBUserClient *)authorizedClientUsingTokenUID:(NSString *)tokenUID {
    if ([DBOAuthManager sharedOAuthManager] == nil) {
        return nil;
    }
    
    DBAccessToken * token =
        [[DBOAuthManager sharedOAuthManager] getAccessToken: self.accessTokenUID];
    if (token == nil) {
        return nil;
    }
    
    DBUserClient * result =
        [[DBUserClient alloc] initWithAccessToken: token.accessToken];
    return result;
}

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

/// MARK provide session ID

- (void)noteChangedSessionID:(NSString *)sessionID {
    SEL selector = @selector(dropboxConnection:didChangeSessionID:);
    if ([self.delegate respondsToSelector: selector]) {
        [self.delegate dropboxConnection: self
                      didChangeSessionID: sessionID];
    }
}

/// MARK convert auth result to NSError

- (NSError *)errorUsingAuthResult:(DBOAuthResult *)authResult {
    NSDictionary * userInfo = @{ NSLocalizedDescriptionKey: authResult.errorDescription };
    NSError * result = [NSError errorWithDomain: TBDropboxErrorDomain
                                           code: authResult.errorType
                                       userInfo: userInfo];
    return result;
}

@end
