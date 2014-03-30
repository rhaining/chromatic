//
//  RTHAppDelegate.m
//  Color Search
//
//  Created by Robert Tolar Haining on 2/2/13.
//  Copyright (c) 2013 Robert Tolar Haining. All rights reserved.
//

#import "RTHAppDelegate.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "RTHHomeViewController.h"
#import "RTHAnalytics.h"
#import "RTHConstants.h"
#import "RTHNavigationController.h"

@implementation RTHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.tintColor = [UIColor colorWithRed:110/255.0 green:192/255.0 blue:255/255.0 alpha:1];
	
	[RTHAnalytics start];

	RTHHomeViewController *viewController = [[RTHHomeViewController alloc] init];
	RTHNavigationController *nav = [[RTHNavigationController alloc] initWithRootViewController:viewController];
	[RTHAnalytics addNavigationController:nav];
	self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
	
	[[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
	NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
	[NSURLCache setSharedURLCache:URLCache];
	
	
    return YES;
}

@end
