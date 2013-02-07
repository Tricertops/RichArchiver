//
//  RTAppDelegate.m
//  RichText
//
//  Created by Martin Kiss on 4.9.12.
//  Copyright (c) 2012 Martin Kiss. All rights reserved.
//

#import "RTAppDelegate.h"
#import "RTViewController.h"



@implementation RTAppDelegate



#pragma mark Initialization

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    RTViewController *viewController = [[RTViewController alloc] init];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    return YES;
}



@end
