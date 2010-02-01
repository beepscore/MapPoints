//
//  MapPointsViewController.m
//  MapPoints
//
//  Created by Steve Baker on 1/31/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import "MapPointsViewController.h"
#import "PointOfInterest.h"

@implementation MapPointsViewController

#pragma mark -
#pragma mark properties
@synthesize myMapView;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the points of interest. Very manual for now.    
    CLLocationCoordinate2D coord1 = { 37.323388, -122.013958 };
    PointOfInterest *pointOfInterest1 = [[PointOfInterest alloc] init];
    pointOfInterest1.coordinate = coord1;
    pointOfInterest1.title = @"Point 1";
    
    CLLocationCoordinate2D coord2 = { 37.5, -122.2 };
    PointOfInterest *pointOfIntererst2 = [[PointOfInterest alloc] init];
    pointOfIntererst2.coordinate = coord2;
    pointOfIntererst2.title = @"Point 2";
    
    CLLocationCoordinate2D coord3 = { 37.7, -122.4};
    PointOfInterest *pointOfInterest3 = [[PointOfInterest alloc] init];
    pointOfInterest3.coordinate = coord3;
    pointOfInterest3.title = @"Point 3";
    
    CLLocationCoordinate2D initialCenter = pointOfInterest1.coordinate;
    
//  MKCoordinateSpan initialSpan = MKCoordinateSpanMake(0.454305, 0.398254);
    MKCoordinateSpan initialSpan = MKCoordinateSpanMake(1.0, 1.0);
    
    MKCoordinateRegion initialRegion = MKCoordinateRegionMake(initialCenter, initialSpan);
    self.myMapView.region = initialRegion;
    
    [self.myMapView addAnnotation:pointOfInterest1];
    [self.myMapView addAnnotation:pointOfIntererst2];
    [self.myMapView addAnnotation:pointOfInterest3];
    [pointOfInterest1 release], pointOfInterest1 = nil;
    [pointOfIntererst2 release], pointOfIntererst2 = nil;
    [pointOfInterest3 release], pointOfInterest3 = nil;
}


- (void)viewDidAppear:(BOOL)animated {
    
}


#pragma mark destructors and memory cleanUp
// use cleanUp method to avoid repeating code in setView, viewDidUnload, and dealloc
- (void)cleanUp {
    [myMapView release], myMapView = nil;
}


// Release IBOutlets in setView.  
// Ref http://developer.apple.com/iPhone/library/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/mmNibObjects.html
//
// http://moodle.extn.washington.edu/mod/forum/discuss.php?d=3162
- (void)setView:(UIView *)aView {
    
    if (!aView) { // view is being set to nil        
        // set outlets to nil, e.g. 
        // self.anOutlet = nil;
        [self cleanUp];
    }    
    // Invoke super's implementation last    
    [super setView:aView];    
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	[self cleanUp];
}


- (void)dealloc {
    [self cleanUp];
    [super dealloc];
}


#pragma mark -
#pragma mark MKMapViewDelegate methods
- (MKAnnotationView *)mapView:(MKMapView *)aMapView
            viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MKPinAnnotationView *annotationView = 
    (MKPinAnnotationView *) [aMapView dequeueReusableAnnotationViewWithIdentifier:@"myIdentifier"];
    if (nil == annotationView) {
        annotationView = [[[MKPinAnnotationView alloc] 
                           initWithAnnotation:annotation
                           reuseIdentifier:@"myIdentifier"]
                          autorelease];
    }
    [annotationView setPinColor:MKPinAnnotationColorPurple];
    [annotationView setCanShowCallout:YES];
    [annotationView setAnimatesDrop:YES];
    return annotationView;
}


- (void)mapView:(MKMapView *)aMapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"lat: %f, long: %f, latDelta: %f, longDelta: %f",
          aMapView.region.center.latitude, aMapView.region.center.longitude, 
          aMapView.region.span.latitudeDelta, aMapView.region.span.longitudeDelta);
}


// TODO: implement
// Used by the delegate to acquire an already allocated annotation view, in lieu of allocating a new one.
//- (MKAnnotationView *)dequeueReusableAnnotationViewWithIdentifier:(NSString *)identifier {
// return annotationView;   
//}

@end

