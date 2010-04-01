//
//  PointOfInterest.m
//  MapPoints
//
//  Created by Steve Baker on 1/31/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "PointOfInterest.h"


@implementation PointOfInterest

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (void) dealloc
{
    [title release], title = nil;
    [subtitle release], subtitle = nil;
    [super dealloc];
}

@end
