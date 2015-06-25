//
//  CitiesViewController.m
//  GetWeather
//
//  Created by Iulian Nikolaiev on 6/25/15.
//  Copyright (c) 2015 Iulian Nikolaiev. All rights reserved.
//

#import "CitiesViewController.h"
#import "CitiesView.h"
#import "Constants.h"
#import "CityCell.h"
#import "MapViewController.h"

@interface CitiesViewController () <UITableViewDataSource, UITableViewDelegate, NSURLSessionDelegate>
@property (nonatomic, readonly) CitiesView    *citiesView;
@property (nonatomic, strong)   NSArray       *cities;
@property (nonatomic, copy)     NSString      *selectedCityName;
@property (nonatomic, strong)   NSDictionary  *information;
@property (nonatomic, assign)   BOOL          tuned;
@end

@implementation CitiesViewController

@dynamic citiesView;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CitiesView *citiesView = self.citiesView;
    
    if (!self.tuned) {
        [citiesView showActivity:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *path = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"json"];
            NSError *error = nil;
            NSData *data = [NSData dataWithContentsOfFile:path];
            NSArray *cities = [NSJSONSerialization JSONObjectWithData:data
                                                              options:kNilOptions
                                                                error:&error];
//            cities = [cities sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO]]];
            self.cities = cities;
            if (error) {
                NSLog(@"%@", error);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [citiesView showActivity:NO];
                [citiesView.tableView reloadData];
            });
        });
        self.tuned = YES;
        self.title = @"Cities";
    }
    [citiesView.tableView deselectRowAtIndexPath:[citiesView.tableView indexPathForSelectedRow] animated:YES];
}

- (CitiesView *)citiesView {
    return (CitiesView *)self.view;
}

- (NSString *)nameForIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictionary = [self.cities objectAtIndex:indexPath.row];
    return [dictionary objectForKey:@"name"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MapViewController *controller = segue.destinationViewController;
    
    controller.cityName = self.selectedCityName;
    controller.information = self.information;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell"];
    cell.cityLabel.text = [self nameForIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = [self nameForIndexPath:indexPath];
    NSString *URLString = [NSString stringWithFormat:@"%@%@%@", kRootURL, kCityURI, name];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              if (error) {
                                                  NSLog(@"%@", error);
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [self.citiesView showActivity:NO];
                                                      [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                                  message:@"Sory, try another city"
                                                                                 delegate:nil
                                                                        cancelButtonTitle:@"Ok"
                                                                        otherButtonTitles:nil] show];
                                                  });
                                              } else {
                                                  self.information = [NSJSONSerialization JSONObjectWithData:data
                                                                                                     options:kNilOptions
                                                                                                       error:&error];
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [self.citiesView showActivity:NO];
                                                      [self performSegueWithIdentifier:@"toMapViewController" sender:self];
                                                  });
                                              }
                                          }];
    
    [downloadTask resume];
    [self.citiesView showActivity:YES];
    self.selectedCityName = name;
}

@end
