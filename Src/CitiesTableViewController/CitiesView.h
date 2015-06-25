//
//  CitiesView.h
//  GetWeather
//
//  Created by Iulian Nikolaiev on 6/25/15.
//  Copyright (c) 2015 Iulian Nikolaiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitiesView : UIView

@property (nonatomic, weak) IBOutlet UITableView              *tableView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView  *activityIndicatorView;

- (void)showActivity:(BOOL)show;

@end
