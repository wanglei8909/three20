//
//  XPullToRefreshView.m
//  BabyDress
//
//  Created by 臧金晓 on 15/1/7.
//  Copyright (c) 2015年 7ul.ipa. All rights reserved.
//

#import "XPullToRefreshView.h"

@implementation XPullToRefreshView
{
    UILabel *stateLabel;
    UIActivityIndicatorView *indicatorView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        stateLabel = [UILabel labelWithFontSize:16 color:[UIColor grayColor]];
        [self addSubview:stateLabel];
        
        indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicatorView sizeToFit];
        [self addSubview:indicatorView];
        [indicatorView setHidesWhenStopped:YES];
        [indicatorView stopAnimating];
        [self setState:XPRLMStateNormal];
    }
    return self;
}

- (void)setState:(XPRLMState)state
{
    _state = state;
    
    switch (state)
    {
        case XPRLMStateNormal:
        {
            [indicatorView stopAnimating];
            [indicatorView setHidden:YES];
            
            [stateLabel setText:@"下拉刷新"];
            [stateLabel setHidden:NO];
        }
            break;
        case XPRLMStateError:
        {
            [indicatorView stopAnimating];
            [indicatorView setHidden:YES];
            
            [stateLabel setText:@"刷新失败"];
            [stateLabel setHidden:NO];
        }
            break;
            
        case XPRLMStateWillTriggerPullToRefresh:
        {
            [stateLabel setText:@"松手刷新"];
            [stateLabel setHidden:NO];
            [indicatorView setHidden:YES];
            [indicatorView stopAnimating];
        }
            break;
            
        case XPRLMStateRefreshing:
        {
            [stateLabel setHidden:YES];
            [indicatorView setHidden:NO];
            [indicatorView startAnimating];
        }
            break;
        default:
            break;
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [stateLabel x_sizeToFit];
    
    [stateLabel setCenter:CGPointMake(self.width / 2.0, self.height / 2.0)];
    
    [indicatorView setCenter:stateLabel.center];
}

@end
