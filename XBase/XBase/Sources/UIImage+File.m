//
//  UIImage+File.m
//  common
//
//  Created by Tulipa on 14-8-27.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import "UIImage+File.h"

@implementation UIImage (File)

+ (instancetype)yd_ImageWithContentsOfFile:(NSString *)file
{
	UIImage *image = [[self class] imageWithContentsOfFile:file];
	if (image)
	{
		return image;
	}
	else
	{
		return [[self class] imageWithContentsOfFile:[NSString stringWithFormat:@"%@@2x.%@", [file stringByDeletingPathExtension], [file pathExtension]]];
	}
}

@end
