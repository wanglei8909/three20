//
//  YDPRLMWrapper.m
//  pandaMentor
//
//  Created by Tulipa on 14/10/13.
//  Copyright (c) 2014年  reserved.
//

#import "XPRLMWrapper.h"
#import "XPullToRefreshView.h"
#import "XTableLoadMoreView.h"

@interface XPRLMWrapper ()

@property (nonatomic, strong) XPullToRefreshView *pullToRefreshView;
@property (nonatomic, strong) XTableLoadMoreView *loadMoreView;

@end

@implementation XPRLMWrapper

- (instancetype)initWithScrollView:(UIScrollView *)inScrollView delegate:(id<XPRLMDelegate>)inDelegate
{
	if (self = [super init])
	{
		self.delegate = inDelegate;
		self.scrollView = inScrollView;
		self.contentOffsetNeededToTriggerPullToRefresh = 62;
		self.contentOffsetNeededToTriggerLoadMore = 62;
		self.state = XPRLMStateNormal;
        
        _pullToRefreshView = [[XPullToRefreshView alloc] initWithFrame:CGRectMake(0, - self.contentOffsetNeededToTriggerPullToRefresh, _scrollView.width, self.contentOffsetNeededToTriggerPullToRefresh)];
        [_scrollView addSubview:_pullToRefreshView];
        _pullToRefreshView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        
	}
	return self;
}

- (void)triggerPullToRefresh
{
	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];
	UIEdgeInsets inset = self.scrollView.contentInset;
	inset.top += self.contentOffsetNeededToTriggerPullToRefresh + 1;
	[self.scrollView setContentInset:inset];
	
    [UIView animateWithDuration:0.3 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0, - self.contentOffsetNeededToTriggerPullToRefresh - 2)];
    }completion:^(BOOL finished) {
        [self setState:XPRLMStateRefreshing];
        [_pullToRefreshView setState:XPRLMStateRefreshing];
        if ([self.delegate respondsToSelector:@selector(scrollView:didTriggerPullToRefresh:)])
        {
            [self.delegate scrollView:self.scrollView didTriggerPullToRefresh:self];
        }
        
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (self.scrollView == scrollView)
	{
		if (self.state == XPRLMStateRefreshing)
		{
			CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
			offset = MIN(offset, self.contentOffsetNeededToTriggerPullToRefresh);
			if (scrollView.dragging)
			{
				scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
			}
			else
			{
				[UIView animateWithDuration:0.5 animations:^{
					scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
				}];
			}
		}
		else if (self.state == XPRLMStateLoadingMore)
		{
			CGFloat offset = MAX(scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height, 0);
			offset = MIN(offset, self.contentOffsetNeededToTriggerLoadMore);
			if (scrollView.dragging)
			{
				scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, offset, 0.0f);
			}
			else
			{
				[UIView animateWithDuration:0.5 animations:^{
					scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, offset, 0.0f);
				}];
			}
		}
		else if (scrollView.contentOffset.y < - self.contentOffsetNeededToTriggerPullToRefresh)
		{
			if (self.state != XPRLMStateWillTriggerPullToRefresh)
			{
                if ([self.delegate respondsToSelector:@selector(scrollView:willTriggerPullToRefresh:)])
                {
                    [self.delegate scrollView:scrollView willTriggerPullToRefresh:self];
                }
				
                [_pullToRefreshView setState:XPRLMStateWillTriggerPullToRefresh];
			}
			
			self.state = XPRLMStateWillTriggerPullToRefresh;
		}
		else if (self.enableLoadMore && self.hasMore && self.scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.height + self.contentOffsetNeededToTriggerLoadMore)
		{
			if (self.state != XPRLMStateWillTriggerLoadMore)
			{
                if ([self.delegate respondsToSelector:@selector(scrollView:willTriggerLoadMore:)])
                {
                    [self.delegate scrollView:scrollView willTriggerLoadMore:self];
                }
                
                [_loadMoreView setState:XPRLMStateWillTriggerLoadMore];
			}
			
			self.state = XPRLMStateWillTriggerLoadMore;
		}
		else
		{
			if (self.state == XPRLMStateWillTriggerPullToRefresh)
			{
                if ([self.delegate respondsToSelector:@selector(scrollView:willCancelPullToReFresh:)])
                {
                    [self.delegate scrollView:scrollView willCancelPullToReFresh:self];
                }
                [_pullToRefreshView setState:XPRLMStateNormal];
			}
			
			if (self.state == XPRLMStateWillTriggerLoadMore)
			{
                if ([self.delegate respondsToSelector:@selector(scrollView:willCancelLoadMore:)])
                {
                    [self.delegate scrollView:scrollView willCancelLoadMore:self];
                }
                [_loadMoreView setState:XPRLMStateNormal];
			}
			
			self.state = XPRLMStateNormal;
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if (self.scrollView == scrollView)
	{
		if (self.state == XPRLMStateWillTriggerPullToRefresh)
		{
			self.state = XPRLMStateRefreshing;
			
            if ([self.delegate respondsToSelector:@selector(scrollView:didTriggerPullToRefresh:)])
            {
                [self.delegate scrollView:scrollView didTriggerPullToRefresh:self];
            }
            [_pullToRefreshView setState:XPRLMStateRefreshing];
		}
		else if (self.state == XPRLMStateWillTriggerLoadMore)
		{
			self.state = XPRLMStateLoadingMore;
			
            if ([self.delegate respondsToSelector:@selector(scrollView:didTriggerLoadMore:)])
            {
                [self.delegate scrollView:scrollView didTriggerLoadMore:self];
            }
            [_loadMoreView setState:XPRLMStateLoadingMore];
		}
	}
}

- (void)didFinishRefreshing
{
	if (self.state == XPRLMStateRefreshing)
	{
        [_pullToRefreshView setState:XPRLMStateNormal];
		self.state = XPRLMStateNormal;
		UIEdgeInsets insert = self.scrollView.contentInset;
		insert.top = 0;
		[UIView animateWithDuration:0.5 animations:^{
			[self.scrollView setContentInset:insert];
		}];
	}
}

- (void)didFinishLoadMore
{
	if (self.state == XPRLMStateLoadingMore)
	{
        [_loadMoreView setState:XPRLMStateNormal];
		self.state = XPRLMStateNormal;
		UIEdgeInsets insert = self.scrollView.contentInset;
		insert.bottom = 0;
		[UIView animateWithDuration:0.5 animations:^{
			[self.scrollView setContentInset:insert];
		}];
	}
}

- (void)setHasMore:(BOOL)hasMore
{
    _hasMore = hasMore;
    [_loadMoreView setState:_hasMore ? XPRLMStateNormal : XPRLMStateNoMore];
}

- (void)setEnableLoadMore:(BOOL)enableLoadMore
{
    if (_enableLoadMore != enableLoadMore)
    {
        _enableLoadMore = enableLoadMore;
        
        if (_enableLoadMore)
        {
            _loadMoreView = [[XTableLoadMoreView alloc] initWithFrame:CGRectMake(0, MAX(_scrollView.height, _scrollView.contentSize.height), _scrollView.width, self.contentOffsetNeededToTriggerLoadMore)];
            [_scrollView addSubview:_loadMoreView];
            _loadMoreView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        }
        else
        {
            [_loadMoreView removeFromSuperview];
            _loadMoreView = nil;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"] && [object isKindOfClass:[UIScrollView class]])
    {
        UIScrollView *scrollView = object;
        [_loadMoreView setTop:MAX(scrollView.contentSize.height, scrollView.height)];
    }
}

@end
