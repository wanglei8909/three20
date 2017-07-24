//
//  XScrollViewController.m
//  XBase
//
//  Created by 臧金晓 on 15/4/5.
//  Copyright (c) 2015年 7ul.ipa. All rights reserved.
//

#import "XScrollViewController.h"

@interface XScrollViewController () <UIScrollViewDelegate>

@end

@implementation XScrollViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (YDAvalibleOS(7))
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self createScrollView];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_scrollView setDelegate:self];
    [self.view addSubview:_scrollView];
    
    [self setupPullToRefreshAndLoadMore];
}

- (void)setupPullToRefreshAndLoadMore
{
    if ([self enablePullToRefresh])
    {
        _prlmWrapper = [[XPRLMWrapper alloc] initWithScrollView:self.scrollView delegate:self];
        _prlmWrapper.enableLoadMore = [self enableLoadMore];
        [_scrollView addObserver:_prlmWrapper forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_prlmWrapper scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_prlmWrapper scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)createScrollView
{
    _scrollView = [[[self scrollViewClass] alloc] initWithFrame:self.view.bounds];
    
}

- (Class)scrollViewClass
{
    return [UIScrollView class];
}

- (BOOL)enableLoadMore
{
    return NO;
}

- (BOOL)enablePullToRefresh
{
    return NO;
}

- (void)dealloc
{
    if (_prlmWrapper)
    {
        [_scrollView removeObserver:_prlmWrapper forKeyPath:@"contentSize"];
    }
}

@end
