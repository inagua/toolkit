//
//  UIView+Utils.m
//  Celli
//
//  Created by Stéphane Tavera on 10/17/11.
//  Copyright 2011 inagua.ch. All rights reserved.
//

#import "UIView+Utils.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIView (UIView_Utils)

- (void) roundBorderWithRadius:(CGFloat)radius width:(CGFloat)width color:(UIColor*)color {
    self.layer.cornerRadius     = radius;
    self.layer.borderWidth      = width;
    self.layer.borderColor      = [color CGColor];    
    self.layer.masksToBounds    = YES;
}

- (void) roundBorderWithRadius:(CGFloat)radius color:(UIColor*)color {
    [self  roundBorderWithRadius:radius width:1. color:color];    
}

- (void) roundBorderWithColor:(UIColor*)color {
    [self roundBorderWithRadius:5.0 color:color];
}

@end
