//
//  MapViewController.h
//  GetWeather
//
//  Created by Iulian Nikolaiev on 6/25/15.
//  Copyright (c) 2015 Iulian Nikolaiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController

@property (nonatomic, copy)   NSString      *cityName;
@property (nonatomic, strong) NSDictionary  *information;

@end
