//
//  AppDelegate.m
//  TBDropboxKitMac-Example
//
//  Created by Bucha Kanstantsin on 4/6/17.
//  Copyright © 2017 truebucha. All rights reserved.
//

#import "AppDelegate.h"
@import TBDropboxKit.TBDropboxKit;

@interface AppDelegate ()

@end


@implementation AppDelegate

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification {
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [[NSAppleEventManager sharedAppleEventManager] setEventHandler: self
                                                       andSelector: @selector(handleAppleEvent:withReplyEvent:)
                                                     forEventClass: kInternetEventClass
                                                        andEventID: kAEGetURL];

}

- (void)handleAppleEvent: (NSAppleEventDescriptor *)event
          withReplyEvent: (NSAppleEventDescriptor *)replyEvent {
    NSString * stringURL = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
    NSURL * URL = [NSURL URLWithString: stringURL];
    [[TBDropboxClient sharedInstance].connection handleAuthorisationRedirectURL: URL];
}


@end
