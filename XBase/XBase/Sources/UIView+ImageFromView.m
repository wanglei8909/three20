//
//  UIView+ImageFromView.m
//  common
//
//  Created by Tulipa on 14-9-3.
//  Copyright (c) 2014年  com.7ulipa All rights reserved.
//

#import "UIView+ImageFromView.h"

@implementation UIView (ImageFromView)

- (UIImage *)imageFromView
{
    CGSize size = self.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    image = [UIImage imageWithCGImage:image.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    return image;
}

@end
