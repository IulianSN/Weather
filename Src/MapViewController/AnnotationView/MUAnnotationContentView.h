//
//  MUAnnotationContentView.h
//  MarriU
//
//  Created by Admin on 10/19/14.
//  Copyright (c) 2014 IDAP Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MUAnnotationContentView : UIView

@property (nonatomic, strong) IBOutlet UIView   *calloutView;
@property (nonatomic, strong) IBOutlet UILabel  *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel  *addressLabel;
@property (nonatomic, strong) IBOutlet UILabel  *phoneLabel;
@property (nonatomic, strong) IBOutlet UILabel  *emailLabel;

- (IBAction)onPin:(id)sender;

@end
