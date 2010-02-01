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
    // CLLocationCoordinate2D coord1 = { 37.323388, -122.013958 };
    // Seattle
    CLLocationCoordinate2D coord1 = { 47.65, -122.35 };
    PointOfInterest *pointOfInterest1 = [[PointOfInterest alloc] init];
    pointOfInterest1.coordinate = coord1;
    pointOfInterest1.title = @"Point 1";
    
    CLLocationCoordinate2D coord2 = { 47.55, -122.15 };
    PointOfInterest *pointOfIntererst2 = [[PointOfInterest alloc] init];
    pointOfIntererst2.coordinate = coord2;
    pointOfIntererst2.title = @"Point 2";
    
    CLLocationCoordinate2D initialCenter = pointOfInterest1.coordinate;
    
    //  MKCoordinateSpan initialSpan = MKCoordinateSpanMake(0.454305, 0.398254);
    MKCoordinateSpan initialSpan = MKCoordinateSpanMake(0.2, 0.2);
    
    MKCoordinateRegion initialRegion = MKCoordinateRegionMake(initialCenter, initialSpan);
    self.myMapView.region = initialRegion;
    
    [self.myMapView addAnnotation:pointOfInterest1];
    [self.myMapView addAnnotation:pointOfIntererst2];
    [pointOfInterest1 release], pointOfInterest1 = nil;
    [pointOfIntererst2 release], pointOfIntererst2 = nil;
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
// Ref Dudney sec 25.3
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MKPinAnnotationView *annotationView = nil;
    
    if(annotation != mapView.userLocation)
    {
        
        // Attempt to get an unused annotationView.  Returns nil if one isn't available.
        // Ref http://developer.apple.com/iphone/library/documentation/MapKit/Reference/MKMapView_Class/MKMapView/MKMapView.html#//apple_ref/occ/instm/MKMapView/dequeueReusableAnnotationViewWithIdentifier:
        annotationView = (MKPinAnnotationView *)
        [mapView dequeueReusableAnnotationViewWithIdentifier:@"myIdentifier"];
        
        // if dequeue didn't return an annotationView, allocate a new one
        if (nil == annotationView) {
            //NSLog(@"dequeue didn't return an annotationView, allocing a new one");
            annotationView = [[[MKPinAnnotationView alloc] 
                               initWithAnnotation:annotation
                               reuseIdentifier:@"myIdentifier"]
                              autorelease];
        } else {
            NSLog(@"dequeueReusableAnnotationViewWithIdentifier returned an annotationView");
        }    
        [annotationView setPinColor:MKPinAnnotationColorPurple];
        [annotationView setCanShowCallout:YES];
        [annotationView setAnimatesDrop:YES];
    } else {
        [mapView.userLocation setTitle:@"I am here"];
    }
    return annotationView;
}


- (void)mapView:(MKMapView *)aMapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"lat: %f, long: %f, latDelta: %f, longDelta: %f",
          aMapView.region.center.latitude, aMapView.region.center.longitude, 
          aMapView.region.span.latitudeDelta, aMapView.region.span.longitudeDelta);
}

#pragma mark -
// Ref http://stackoverflow.com/questions/1131101/whats-wrong-with-this-randomize-function
// Note this works for arguments in either algebraic order.  i.e. it works if minimum > maximum
- (float)randomValueBetweenMin:(float)minimum andMax:(float)maximum {
    return (((float) arc4random() / 0xFFFFFFFFu) * (maximum - minimum)) + minimum;
}


- (IBAction)nextAnnotation:(id)sender {
    
    for (int i=0; i<1000; i++) {
    
    float nextLatitude = [self randomValueBetweenMin:47.55 andMax:47.65];
    float nextLongitude = [self randomValueBetweenMin:-122.35 andMax:-122.15];    
    CLLocationCoordinate2D nextCoord = {nextLatitude, nextLongitude};
    
    PointOfInterest *nextPoint = [[PointOfInterest alloc] init];
    nextPoint.coordinate = nextCoord;
    nextPoint.title = @"Next point";
    
    [self.myMapView addAnnotation:nextPoint];
    [nextPoint release], nextPoint = nil; 
        
    }
}


@end

