//
//  PointOfInterest.h
//  MapPoints
//
//  Created by Steve Baker on 1/31/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PointOfInterest : NSObject <MKAnnotation> {
    // Xcode will automatically add instance variables to back properties
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end

