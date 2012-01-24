//
//  UIView+Translate.h
//  inagua
//
//  Created by StJacques COUVREUR on 7/29/11.
//  Copyright 2011 inagua.ch. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIView (UIView_Translate)

-(void) verticalTransform:(CGFloat)offsetY duration:(float)seconds;
-(void) verticalTransform:(CGFloat)offsetY;
-(void) verticalSetupInContainer:(UIView*)container;
-(void) verticalShowOrHide;

-(void) lateralTransform:(CGFloat)offsetX;
-(void) lateralSetupInContainer:(UIView*)container;
-(void) lateralShowOrHide;

-(void) alphaShowOrHide;

-(void) roundCourners;

@end
