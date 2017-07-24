//
//  YDPopoverView.m
//  common
//
//  Created by Tulipa on 14-8-27.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import "XPopoverView.h"
#import "UIView+ImageFromView.h"
#import "UIImageView+LBBlurredImage.h"
#import "UIImage+Blurry.h"

@implementation XPopoverView
{
	UIView *overView;
}
@synthesize bgView;

- (id)init
{
	return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:[UIScreen mainScreen].bounds])
	{
		[super setHidden:YES];
		[self setUserInteractionEnabled:YES];
        [self setBackgroundColor:[UIColor clearColor]];
		if ([self blurryBackground])
		{
			bgView = [[UIImageView alloc] init];
			[bgView setBackgroundColor:RGBACOLOR_HEX(0x000000, 0.3)];
			[self addSubview:bgView];
			overView = [[UIView alloc] init];
			[overView setBackgroundColor:RGBACOLOR(33, 33, 33, 0.3)];
			[bgView addSubview:overView];
		}
		
		[self view];
	}
	
	return self;
}

- (UIView *)view
{
	return _view;
}

- (instancetype)initWithView:(UIView *)view
{
	if (self = [self init])
	{
		_view = view;
	}
	return self;
}

- (void)_setHidden:(BOOL)hidden
{
	[super setHidden:hidden];
}

- (void)setHidden:(BOOL)hidden
{
	if (self.hidden == hidden)
	{
		return;
	}
	
	if (hidden)
	{
		weaklySelf();
		[weakSelf _setHidden:hidden];
		[self removeFromSuperview];
	}
	else
	{
		weaklySelf();
		
		if ([self blurryBackground])
		{
			[self.bgView setImageToBlur:[[UIApplication sharedApplication].keyWindow imageFromView] blurRadius:40 completionBlock:nil];
		}
		
		UIView *view = [self view];
		[self addSubview:view];
		[view setCenter:CGPointMake(self.width / 2.0f, self.height / 2.0f)];
		
		self.alpha = 0;
		[[[UIApplication sharedApplication] keyWindow] addSubview:self];
		[self _setHidden:hidden];
		[UIView animateWithDuration:0.4 animations:^{
			weakSelf.alpha = 1.0f;
		} completion:^(BOOL finished) {
			weakSelf.alpha = 1.0f;
		}];
	}
}

- (BOOL)blurryBackground
{
	return NO;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	[bgView setFrame:self.bounds];
	[overView setFrame:bgView.bounds];
}

- (void)dealloc
{
	YDLog();
}

@end
