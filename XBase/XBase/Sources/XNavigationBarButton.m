//
//  YDNavigationBarButton.m
//  common
//
//  Created by Tulipa on 14-7-15.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import "XNavigationBarButton.h"

@implementation XNavigationBarButton

//- (void)setFrame:(CGRect)frame
//{
//	[super setFrame:frame];
//	if (self.superview)
//	{
//        [self setCenterY:YDAvalibleOS(7) ? 42 : 22];
//	}
//}

@end

@implementation XNavigationBarButtonTabBarStyle

- (void)layoutSubviews
{
	[super layoutSubviews];
	[self.titleLabel setSize:[self.titleLabel sizeThatFits:self.size]];
	[self.imageView sizeToFit];
	[self.imageView setTop:0];
	self.imageView.centerX = self.width / 2.0f;
	self.titleLabel.bottom = self.height;
	self.titleLabel.centerX = self.width / 2.0f;
}

@end
