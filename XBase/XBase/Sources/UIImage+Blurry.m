//
//  UIImage+Blurry.m
//  ZhengXing
//
//  Created by Tulipa on 14-6-12.

//

#import "UIImage+Blurry.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (Blurry)

- (UIImage *)blurryImageWithBlurLevel:(CGFloat)blur
{
    if ((blur < 0.1f) || (blur > 2.0f))
	{
        blur = 0.5f;
    }

    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
	
    YDLog(@"boxSize:%i",boxSize);

    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;

    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error)
	{
        YDLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(self.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}


@end
