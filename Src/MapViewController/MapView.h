//
//  MapView.h
//  GetWeather
//
//  Created by Iulian Nikolaiev on 6/25/15.
//  Copyright (c) 2015 Iulian Nikolaiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapView : UIView

@property (nonatomic, weak) IBOutlet MKMapView  *mapView;
@property (nonatomic, weak) IBOutlet UILabel    *cloudsLabel;
@property (nonatomic, weak) IBOutlet UILabel    *humidityLabel;
@property (nonatomic, weak) IBOutlet UILabel    *pressureLabel;
@property (nonatomic, weak) IBOutlet UILabel    *seaLevelLabel;
@property (nonatomic, weak) IBOutlet UILabel    *currentTempLabel;
@property (nonatomic, weak) IBOutlet UILabel    *minTempLabel;
@property (nonatomic, weak) IBOutlet UILabel    *maxTempLabel;
@property (nonatomic, weak) IBOutlet UILabel    *sunriseLabel;
@property (nonatomic, weak) IBOutlet UILabel    *sunsetLabel;
@property (nonatomic, weak) IBOutlet UILabel    *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel    *degriesLabel;
@property (nonatomic, weak) IBOutlet UILabel    *speedLabel;
@property (nonatomic, weak) IBOutlet UIImageView  *weatherImageView;

@end
