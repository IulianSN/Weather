//
//  MUAnnotationView.m
//  MarriU
//
//  Created by Admin on 10/19/14.
//  Copyright (c) 2014 IDAP Group. All rights reserved.
//

#import "MUAnnotationView.h"
#import "MUAnnotationContentView.h"
#import "UINib+IDPExtensions.h"
#import "MUVendorModel.h"

@interface MUAnnotationView ()

@property (nonatomic, strong) MUAnnotationContentView  *contentView;

@end

@implementation MUAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation
                   reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        MUAnnotationContentView *contentView = [UINib loadClass:[MUAnnotationContentView class]];
        CGRect frame = self.frame;
        
        frame.size.width = 300.f;
        frame.size.height = 146.f;
        self.frame = frame;
        self.opaque = YES;
        
        self.contentView = contentView;
        [self addSubview:contentView];
        
        self.centerOffset = CGPointMake(0.f,
                                        -160.f / 2);
    }
    
    return self;
}

- (void)setUpWithVendorModel:(MUVendorModel *)vendorModel {
    MUAnnotationContentView *contentView = self.contentView;
    
    contentView.nameLabel.text = vendorModel.name;
    contentView.addressLabel.text = vendorModel.address;
    contentView.phoneLabel.text = vendorModel.phone;
    contentView.emailLabel.text = nil;
}

@end
