//
//  MapPointsAppDelegate.m
//  MapPoints
//
//  Created by Steve Baker on 1/31/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import "MapPointsAppDelegate.h"
#import "MapPointsViewController.h"

@implementation MapPointsAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end


