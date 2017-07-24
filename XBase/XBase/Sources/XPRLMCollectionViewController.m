//
//  XPRLMCollectionViewController.m
//  BabyDress
//
//  Created by 臧金晓 on 15/1/7.
//  Copyright (c) 2015年 7ul.ipa. All rights reserved.
//

#import "XPRLMCollectionViewController.h"

@interface XPRLMCollectionViewController ()
{
    XPullToRefreshView *pullToRefreshView;
    XTableLoadMoreView *loadMoreView;
}
@end

@implementation XPRLMCollectionViewController

@synthesize pullToRefreshView;
@synthesize loadMoreView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _prlmWrapper = [[XPRLMWrapper alloc] initWithScrollView:self.collectionView delegate:self];
    pullToRefreshView = [[XPullToRefreshView alloc] initWithFrame:CGRectMake(0, -62, SCREEN_WIDTH, 62)];
    [self.collectionView addSubview:pullToRefreshView];
    
    loadMoreView = [[XTableLoadMoreView alloc] initWithFrame:CGRectMake(0, self.collectionView.bottom, self.collectionView.width, 62)];
    [self.collectionView addSubview:loadMoreView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_prlmWrapper scrollViewDidScroll:scrollView];
    [loadMoreView setTop:MAX(self.collectionView.height, self.collectionView.contentSize.height)];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_prlmWrapper scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}


- (void)scrollView:(UIScrollView *)inScrollView willTriggerPullToRefresh:(XPRLMWrapper *)inWrapper
{
    [pullToRefreshView setState:XPRLMStateWillTriggerPullToRefresh];
}

- (void)scrollView:(UIScrollView *)inScrollView willCancelPullToReFresh:(XPRLMWrapper *)inWrapper
{
    [pullToRefreshView setState:XPRLMStateNormal];
}

- (void)scrollView:(UIScrollView *)inScrollView didTriggerPullToRefresh:(XPRLMWrapper *)inWrapper
{
    [pullToRefreshView setState:XPRLMStateRefreshing];
}

- (void)scrollView:(UIScrollView *)inScrollView willTriggerLoadMore:(XPRLMWrapper *)inWrapper
{
    [loadMoreView setState:XPRLMStateWillTriggerLoadMore];
}

- (void)scrollView:(UIScrollView *)inScrollView didTriggerLoadMore:(XPRLMWrapper *)inWrapper
{
    
}

- (void)scrollView:(UIScrollView *)inScrollView willCancelLoadMore:(XPRLMWrapper *)inWrapper
{
    [loadMoreView setState:XPRLMStateNormal];
}

@end
