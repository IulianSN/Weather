//
//  MapViewController.m
//  GetWeather
//
//  Created by Iulian Nikolaiev on 6/25/15.
//  Copyright (c) 2015 Iulian Nikolaiev. All rights reserved.
//

#import "MapViewController.h"
#import "MapView.h"
#import "Constants.h"

@interface MapViewController ()
@property (nonatomic, readonly) MapView  *mapView;
@end

@implementation MapViewController

@dynamic mapView;

- (MapView *)mapView {
    return (MapView *)self.view;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Map and Information";
    
    NSDictionary *coordinates = [self.information objectForKey:@"coord"];
    CGFloat latitude = [[coordinates objectForKey:@"lat"] floatValue];
    CGFloat longitude = [[coordinates objectForKey:@"lon"] floatValue];
    
    
    MKMapView *mapView = self.mapView.mapView;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(latitude,
                                                                                              longitude),
                                                                   5000.f,
                                                                   5000.f);
    MKPointAnnotation *pointAnnotation = [MKPointAnnotation new];
    
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(latitude,
                                                            longitude);
    [mapView setRegion:region];
    [mapView addAnnotation:pointAnnotation];
    [self fillLabels];
    [self downloadWeatherImage];
}

- (void)fillLabels {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    
    MapView *mapView = self.mapView;
    NSDictionary *information = self.information;
    
    NSDictionary *cloudsDictionary = [information objectForKey:@"clouds"];
    
    mapView.cloudsLabel.text = [NSString stringWithFormat:@"%@%%", [cloudsDictionary objectForKey:@"all"]];
    
    NSDictionary *mainDictionary = [information objectForKey:@"main"];
    
    mapView.humidityLabel.text = [NSString stringWithFormat:@"%@%%", [mainDictionary objectForKey:@"humidity"]];
    mapView.pressureLabel.text = [NSString stringWithFormat:@"%@", [mainDictionary objectForKey:@"pressure"]];
    mapView.seaLevelLabel.text = [NSString stringWithFormat:@"%@", [mainDictionary objectForKey:@"sea_level"]];
    mapView.currentTempLabel.text = [NSString stringWithFormat:@"%@K", [mainDictionary objectForKey:@"temp"]];
    mapView.minTempLabel.text = [NSString stringWithFormat:@"%@K", [mainDictionary objectForKey:@"temp_min"]];
    mapView.maxTempLabel.text = [NSString stringWithFormat:@"%@K", [mainDictionary objectForKey:@"temp_max"]];
    
    NSDictionary *sysDictionary = [information objectForKey:@"sys"];
    NSUInteger sunriseSecs = [[sysDictionary objectForKey:@"sunrise"] unsignedIntegerValue];
    NSUInteger sunsetSecs = [[sysDictionary objectForKey:@"sunset"] unsignedIntegerValue];
    NSDate *sunriseDate = [NSDate dateWithTimeIntervalSince1970:sunriseSecs];
    NSDate *sunsetDate = [NSDate dateWithTimeIntervalSince1970:sunsetSecs];
    
    mapView.sunriseLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:sunriseDate]];
    mapView.sunsetLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:sunsetDate]];
    
    NSArray *weatherArray = [information objectForKey:@"weather"];
    NSDictionary *weatherDictionary = weatherArray.firstObject;
    
    mapView.descriptionLabel.text = [NSString stringWithFormat:@"%@", [weatherDictionary objectForKey:@"description"]];
    
    NSDictionary *windDictionary = [information objectForKey:@"wind"];
    
    mapView.degriesLabel.text = [NSString stringWithFormat:@"%@", [windDictionary objectForKey:@"deg"]];
    mapView.speedLabel.text = [NSString stringWithFormat:@"%@", [windDictionary objectForKey:@"speed"]];
}

- (void)downloadWeatherImage {
    NSArray *weatherArray = [self.information objectForKey:@"weather"];
    NSDictionary *weatherDictionary = weatherArray.firstObject;
    NSString *URLString = [NSString stringWithFormat:@"%@%@%@", kRootURL, kWeatherThumbnailURI, [weatherDictionary objectForKey:@"icon"]];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession]
                                                   downloadTaskWithURL:URL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                       if (error) {
                                                           NSLog(@"%@", error);
                                                       } else {
                                                           UIImage *image = [UIImage imageWithData:
                                                                             [NSData dataWithContentsOfURL:location]];
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               self.mapView.weatherImageView.image = image;
                                                           });
                                                       }
                                                   }];
    
    [downloadPhotoTask resume];
}

@end
