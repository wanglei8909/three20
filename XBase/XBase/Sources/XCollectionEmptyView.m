//
//  YDCollectionEmptyView.m
//  common
//
//  Created by Yamazoa on 11/28/14.
//  Copyright (c) 2014  com.7ulipa All rights reserved.
//

#import "XCollectionEmptyView.h"

@interface XCollectionEmptyView ()
{
	UILabel* msgLabel;
	//UIImageView* imageView;
}

@end

@implementation XCollectionEmptyView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		[self setBackgroundColor:RGBCOLOR(239, 239, 239)];
		msgLabel = [[UILabel alloc] init];
		[msgLabel setBackgroundColor:[UIColor clearColor]];
		[msgLabel setTextColor:[UIColor blackColor]];
		[msgLabel setFont:[UIFont systemFontOfSize:16]];
		[msgLabel setNumberOfLines:0];
		[msgLabel setTextAlignment:NSTextAlignmentCenter];
		[self addSubview:msgLabel];
	}
	return self;
}

- (void)setMsg:(NSString *)msg
{
	_msg = msg;
	[msgLabel setText:_msg];
	[self setNeedsLayout];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	[msgLabel setSize:[msgLabel sizeThatFits:self.size]];
	[msgLabel setCenter:self.center];
}
@end
