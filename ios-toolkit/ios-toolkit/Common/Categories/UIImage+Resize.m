//
//  UIImage+Resize.m
//  inagua
//
//  Created by Jacques COUVREUR on 27/07/11.
//  Copyright 2011 inagua.ch. All rights reserved.
//

#import "UIImage+Resize.h"
//#import "Constants.h"

#define PICTURE_THUMB_WIDTH             58.0
#define PICTURE_THUMB_HEIGHT            58.0
#define PICTURE_SHARE_WIDTH             538.0
#define PICTURE_SHARE_HEIGHT            720.0
#define SMALL_PHOTO_WIDTH               150
#define SMALL_PHOTO_HEIGHT              150
#define PICTURE_PLACEHOLDER             @"picto_photos.png"


@implementation UIImage (UIImage_Resize)


#pragma mark -
#pragma mark Private Methods

- (double) radians:(double)degrees {
    return degrees * M_PI/180;
}

- (UIImage*)imageWithWidth:(float)wantedWidth andHeight:(float)wantedHeight isFill:(BOOL)isFit {
    float xScale = self.size.width / wantedWidth;
    float yScale = self.size.height / wantedHeight;
    
    float scale = 1.0;
    if (isFit) {
        scale = xScale < yScale ? yScale : xScale;
    } else { // is Fill
        scale = xScale < yScale ? xScale : yScale;
    }
    
    float scaledWidth = self.size.width / scale;
    float scaledHeight = self.size.height / scale;
    
    float finalWidth;
    float finalHeight;
    if (isFit) {
        finalWidth = (wantedWidth < scaledWidth) ? wantedWidth : scaledWidth;
        finalHeight = (wantedHeight < scaledHeight) ? wantedHeight : scaledHeight;
    } else { // is Fill
        finalWidth = wantedWidth;
        finalHeight = wantedHeight;
    }
    
    float rectX = (finalWidth - scaledWidth) / 2;
    float rectY = (finalHeight - scaledHeight) / 2;
    
    UIGraphicsBeginImageContext(CGSizeMake(finalWidth, finalHeight)); // this will crop
    CGRect resultRect = CGRectMake(rectX, rectY, scaledWidth, scaledHeight);
    [self drawInRect:resultRect];
    
    UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    if(resultImage == nil) {
        NSLog(@"could not scale image");
    }
    UIGraphicsEndImageContext();
    return resultImage;
    
}


#pragma mark -
#pragma mark API

- (UIImage*)imageScaledToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageCroppedToRect:(CGRect)rect {	
	CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);	    
	UIImage *cropped    = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:self.imageOrientation];
	CGImageRelease(imageRef);    
	return cropped;	
}

- (UIImage *)extractImageAtCenterWithSize:(CGSize)size {
    CGFloat deltaDim = self.size.height - self.size.width;
    CGRect cropRect;
    if (deltaDim>0) {
        cropRect = CGRectMake(0, deltaDim/2.0, self.size.width, self.size.width);    
    } else {
        cropRect = CGRectMake(-deltaDim/2.0, 0, self.size.width, self.size.width);    
    }    
    
    UIImage *squareCentered = [self imageCroppedToRect:cropRect];
    UIImage *squareResized      = [squareCentered imageScaledToSize:CGSizeMake(size.width, size.height)];        
    return squareResized;    
}

- (UIImage *)extractThumbnailAtCenter {
    NSLog(@"extractThumbnailAtCenter");
    return [self extractImageAtCenterWithSize:CGSizeMake(PICTURE_THUMB_WIDTH, PICTURE_THUMB_HEIGHT)];
}

- (UIImage *)extractSmallAtCenter {
    NSLog(@"extractSmallAtCenter");
    return [self extractImageAtCenterWithSize:CGSizeMake(SMALL_PHOTO_WIDTH, SMALL_PHOTO_HEIGHT)];
}


- (UIImage*) mergeFromBottomLeftCoinWith:(UIImage*)foregroundImage {
    float selfWidth         = self.size.width;
    float selfHeight        = self.size.height;
    float foregroundWidth   = foregroundImage.size.width;
    float foregroundHeight  = foregroundImage.size.height;
    
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, selfWidth, selfHeight)];
    [foregroundImage drawInRect:CGRectMake(0, selfHeight - foregroundHeight, foregroundWidth, foregroundHeight) blendMode:kCGBlendModeNormal alpha:1.0];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/*
 * The result image is cut off the original image : no blank left
 */
- (UIImage*)imageAspectFillInSize:(CGSize)size {
    return [self imageWithWidth:size.width andHeight:size.height isFill:NO];
}


/*
 * The whole original image is included in the result image : blanks are used to complete
 */
- (UIImage*)imageAspectFitInSize:(CGSize)size {
    return [self imageWithWidth:size.width andHeight:size.height isFill:YES];
}

- (UIImage*) imageThumb {
    
    if (self.size.width==PICTURE_THUMB_WIDTH && self.size.height==PICTURE_THUMB_HEIGHT) {
        return self;
    }
    
    NSLog(@"current size %f %f, target = %f %f", self.size.width,  self.size.height, PICTURE_THUMB_WIDTH, PICTURE_THUMB_HEIGHT);
    
    CGSize targetSize = CGSizeMake(PICTURE_THUMB_WIDTH, PICTURE_THUMB_HEIGHT);
    UIImage* result = [self imageAspectFillInSize:targetSize];
    return result;
}

- (UIImage*) imageMedium {
    BOOL isPortrait = self.size.height > self.size.width;
    float targetWidth = PICTURE_SHARE_HEIGHT;
    float targetHeight = PICTURE_SHARE_WIDTH;
    if (isPortrait) {
        targetHeight = PICTURE_SHARE_HEIGHT;
        targetWidth = PICTURE_SHARE_WIDTH;
    }
    CGSize targetSize = CGSizeMake(targetWidth, targetHeight);
    UIImage* result = [self imageAspectFitInSize:targetSize];
    return result;
}

- (UIImage*) imageToShare {
    UIImage* background = [self imageMedium];
    UIImage* foreground = [UIImage imageNamed:@"masque_publication.png"];
    UIImage* result = [background mergeFromBottomLeftCoinWith:foreground];
    return result;
}

- (BOOL) isLandscape {
    return self.size.width > self.size.height;
}

- (UIImage*) rotateAs:(UIImageOrientation)orientation {
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orientation == UIImageOrientationRight) {
        CGContextRotateCTM (context, [self radians:90]);
        
    } else if (orientation == UIImageOrientationLeft) {
        CGContextRotateCTM (context, [self radians:-90]);
        
    } else if (orientation == UIImageOrientationDown) {
        // NOTHING
    } else if (orientation == UIImageOrientationUp) {
        CGContextRotateCTM (context, [self radians:90]);
        
    }
    [self drawAtPoint:CGPointMake(0, 0)];
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (UIImage*) imageAsLandscape {
    if ([self isLandscape]) {
        return self;
    }
    
    
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation([self radians:-90]);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    [rotatedViewBox release];
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, [self radians:-90]);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage*) imageOrPlaceholderIfNil:(UIImage*)image {
    return [UIImage imageOrPlaceholderIfNil:image withPlaceholderName:PICTURE_PLACEHOLDER];
}

+ (UIImage*) imageOrPlaceholderIfNil:(UIImage*)image withPlaceholderName:(NSString*)placeholderImageName {
    if (image) {
        return image;
    }
    return [UIImage imageNamed:placeholderImageName];
}


@end
