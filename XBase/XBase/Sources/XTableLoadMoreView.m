//
//  YDTableLoadMoreView.m
//  pandaMentor
//
//  Created by 臧金晓 on 14/11/28.
//  Copyright (c) 2014年  reserved.
//

#import "XTableLoadMoreView.h"

@implementation XTableLoadMoreView

- (instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		self.stateLabel = [[UILabel alloc] init];
		[self.stateLabel setBackgroundColor:[UIColor clearColor]];
		[self.stateLabel setFont:[UIFont systemFontOfSize:14]];
		[self.stateLabel setTextColor:[UIColor grayColor]];
		[self addSubview:self.stateLabel];
		self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[self addSubview:self.indicatorView];
		[self.indicatorView setHidesWhenStopped:YES];
		[self setState:XPRLMStateNormal];
	}
	return self;
}

- (void)setState:(XPRLMState)state
{
	if (_state != state)
	{
		_state = state;
		
		[self.indicatorView stopAnimating];
		[self.indicatorView setHidden:YES];
		
		switch (_state)
		{
			case XPRLMStateNormal:
			{
				[self.stateLabel setText:@"上拉加载更多"];
				break;
			}
				
			case XPRLMStateWillTriggerLoadMore:
			{
				[self.stateLabel setText:@"松手加载更多"];
				break;
			}
				
			case XPRLMStateLoadingMore:
			{
				[self.stateLabel setText:@"正在加载..."];
				[self.indicatorView setHidden:NO];
				[self.indicatorView startAnimating];
				break;
			}
				
			case XPRLMStateNoMore:
			{
				[self.stateLabel setText:@"已加载全部"];
				break;
			}
				
			case XPRLMStateError:
			{
				[self.stateLabel setText:@"网络不给力，请检查网络！"];
				break;
			}
				
			default:
    break;
		}
		
		[self setNeedsLayout];
	}
}

- (void)layoutSubviews
{
	[self.stateLabel x_sizeToFit];
	[self.stateLabel setCenter:CGPointMake(self.width / 2.0f, self.height / 2.0f)];
	
	[self.indicatorView setCenterY:self.height / 2.0f];
	[self.indicatorView setRight:self.stateLabel.left - 10];
}

@end
