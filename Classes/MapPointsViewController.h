//
//  MapPointsViewController.h
//  MapPoints
//
//  Created by Steve Baker on 1/31/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapPointsViewController : UIViewController 
<CLLocationManagerDelegate, MKMapViewDelegate> {

    MKMapView *myMapView;
}
#pragma mark -
#pragma mark properties
@property(nonatomic, retain) IBOutlet MKMapView *myMapView;

@end

