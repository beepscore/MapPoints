//
//  MapPointsAppDelegate.h
//  MapPoints
//
//  Created by Steve Baker on 1/31/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapPointsViewController;

@interface MapPointsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MapPointsViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MapPointsViewController *viewController;

@end

