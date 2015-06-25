//
//  CitiesView.m
//  GetWeather
//
//  Created by Iulian Nikolaiev on 6/25/15.
//  Copyright (c) 2015 Iulian Nikolaiev. All rights reserved.
//

#import "CitiesView.h"

@implementation CitiesView

- (void)showActivity:(BOOL)show {
    UIActivityIndicatorView *activityIndicatorView = self.activityIndicatorView;
    
    activityIndicatorView.hidden = !show;
    if (show) {
        [activityIndicatorView startAnimating];
        self.tableView.userInteractionEnabled = NO;
    } else {
        [activityIndicatorView stopAnimating];
        self.tableView.userInteractionEnabled = YES;
    }
}

@end
