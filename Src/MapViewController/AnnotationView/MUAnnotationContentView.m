//
//  MUAnnotationContentView.m
//  MarriU
//
//  Created by Admin on 10/19/14.
//  Copyright (c) 2014 IDAP Group. All rights reserved.
//

#import "MUAnnotationContentView.h"

@interface MUAnnotationContentView ()
@property (nonatomic, assign, getter = isCalloutVisible) BOOL  calloutVisible;
@end

@implementation MUAnnotationContentView

- (void)awakeFromNib {
    self.calloutView.layer.cornerRadius = 10.f;
    [self setCalloutVisible:YES animated:YES];
}

- (IBAction)onPin:(id)sender {
    [self setCalloutVisible:!self.isCalloutVisible animated:YES];
}

- (void)setCalloutVisible:(BOOL)calloutVisible {
    [self setCalloutVisible:calloutVisible animated:NO];
}

- (void)setCalloutVisible:(BOOL)calloutVisible animated:(BOOL)animated {
    [UIView animateWithDuration:0.15f
                     animations:^{
                         self.calloutView.alpha = (calloutVisible) ? 1.f : 0.f;
                     }
                     completion:^(BOOL finished) {
                         _calloutVisible = calloutVisible;
                     }];
}

@end
