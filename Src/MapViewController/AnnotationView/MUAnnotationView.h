//
//  MUAnnotationView.h
//  MarriU
//
//  Created by Admin on 10/19/14.
//  Copyright (c) 2014 IDAP Group. All rights reserved.
//

#import <MapKit/MapKit.h>
@class MUVendorModel;

@interface MUAnnotationView : MKAnnotationView

- (void)setUpWithVendorModel:(MUVendorModel *)vendorModel;

@end
