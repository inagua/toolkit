//
//  UIImage+Resize.h
//  inagua
//
//  Created by Jacques COUVREUR on 27/07/11.
//  Copyright 2011 inagua.ch. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (UIImage_Resize)

- (UIImage*) imageScaledToSize:(CGSize)size;
- (UIImage *) extractThumbnailAtCenter;
- (UIImage *) extractSmallAtCenter;
- (UIImage*) mergeFromBottomLeftCoinWith:(UIImage*)foregroundImage;

- (UIImage*) imageThumb;
- (UIImage*) imageMedium;
- (UIImage*) imageToShare;
- (UIImage*) imageAspectFillInSize:(CGSize)size;
- (UIImage*) imageAspectFitInSize:(CGSize)size;

- (BOOL) isLandscape;
- (UIImage*) rotateAs:(UIImageOrientation)orientation;
- (UIImage*) imageAsLandscape;

+ (UIImage*) imageOrPlaceholderIfNil:(UIImage*)image;
+ (UIImage*) imageOrPlaceholderIfNil:(UIImage*)image withPlaceholderName:(NSString*)placeholderImageName;

@end
