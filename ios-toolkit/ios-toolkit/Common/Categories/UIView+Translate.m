//
//  UIView+Translate.m
//  inagua
//
//  Created by Jacques COUVREUR on 7/29/11.
//  Copyright 2011 inagua.ch. All rights reserved.
//

#import "UIView+Translate.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIView (UIView_Translate)

-(void) verticalTransform:(CGFloat)offsetY duration:(float)seconds {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:seconds];
    [UIView setAnimationDelegate:self];       
    BOOL isShown = self.transform.ty != 0;
    if (isShown) {
        [self setTransform:CGAffineTransformMakeTranslation(0, 0)];    
    } else {
        [self setTransform:CGAffineTransformMakeTranslation(0, -offsetY)];    
    }        
    [UIView commitAnimations];    
}

-(void) verticalTransform:(CGFloat)offsetY {
    [self verticalTransform:offsetY duration:0.5];
}

-(void) lateralTransform:(CGFloat)offsetX {       
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];       
    BOOL isShown = self.transform.tx != 0;
    if (isShown) {
        [self setTransform:CGAffineTransformMakeTranslation(0, 0)];    
    } else {
        [self setTransform:CGAffineTransformMakeTranslation(-offsetX, 0)];    
    }        
    [UIView commitAnimations];    
}

-(void) verticalSetupInContainer:(UIView*)container {
    self.frame = CGRectMake(0, container.frame.size.height, self.frame.size.width, self.frame.size.height);
}

-(void) verticalShowOrHide {
    [self verticalTransform:self.frame.size.height];
}

-(void) lateralSetupInContainer:(UIView*)container {
    self.frame = CGRectMake(container.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
}

-(void) lateralShowOrHide {
    [self lateralTransform:self.frame.size.width];
}

-(void) alphaShowOrHide {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];       
    BOOL isVisible = self.alpha > 0;
    if (isVisible) {
        self.alpha = 0.;
    } else {
        self.alpha = 1.;
    }        
    [UIView commitAnimations];    
}

-(void) roundCourners {
    self.layer.masksToBounds  = YES;  // #import <QuartzCore/QuartzCore.h>
    self.layer.cornerRadius   = 5.0;  // #import <QuartzCore/QuartzCore.h>
}

@end
