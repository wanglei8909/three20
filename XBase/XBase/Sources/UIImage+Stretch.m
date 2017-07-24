//
//  UIImage+Stretch.m
//  Weibo
//
//  Created by Kai on 11/17/11.
//  Copyright (c) 2011  com.7ulipa All rights reserved.
//

#import "UIImage+Stretch.h"

@implementation UIImage (Stretch)

- (UIImage *)stretchableImageByCenter
{
	CGFloat leftCapWidth = floorf(self.size.width / 2);
	if (leftCapWidth == self.size.width / 2)
	{
		leftCapWidth--;
	}
	
	CGFloat topCapHeight = floorf(self.size.height / 2);
	if (topCapHeight == self.size.height / 2)
	{
		topCapHeight--;
	}
	
	return [self stretchableImageWithLeftCapWidth:leftCapWidth 
									 topCapHeight:topCapHeight];
}

- (UIImage *)stretchableImageByHeightCenter
{
	CGFloat topCapHeight = floorf(self.size.height / 2);
	if (topCapHeight == self.size.height / 2)
	{
		topCapHeight--;
	}
	
	return [self stretchableImageWithLeftCapWidth:0
									 topCapHeight:topCapHeight];
}

- (UIImage *)stretchableImageByWidthCenter
{
	CGFloat leftCapWidth = floorf(self.size.width / 2);
	if (leftCapWidth == self.size.width / 2)
	{
		leftCapWidth--;
	}
	
	return [self stretchableImageWithLeftCapWidth:leftCapWidth 
									 topCapHeight:0];
}

- (NSInteger)rightCapWidth
{
	return (NSInteger)self.size.width - (self.leftCapWidth + 1);
}


- (NSInteger)bottomCapHeight
{
	return (NSInteger)self.size.height - (self.topCapHeight + 1);
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), NO, 0.0f);
	UIBezierPath* roundedRect = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 1, 1)];
    [color setFill];
    [roundedRect fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image stretchableImageByCenter];
}

@end
