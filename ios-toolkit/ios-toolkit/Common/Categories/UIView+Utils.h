//
//  UIView+Utils.h
//  Celli
//
//  Created by Stéphane Tavera on 10/17/11.
//  Copyright 2011 inagua.ch. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIView (UIView_Utils)

- (void) roundBorderWithColor:(UIColor*)color;
- (void) roundBorderWithRadius:(CGFloat)radius color:(UIColor*)color;
- (void) roundBorderWithRadius:(CGFloat)radius width:(CGFloat)width color:(UIColor*)color;

@end
