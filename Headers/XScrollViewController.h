//
//  XScrollViewController.h
//  XBase
//
//  Created by 臧金晓 on 15/4/5.
//  Copyright (c) 2015年 7ul.ipa. All rights reserved.
//

#import "XViewController.h"
#import "XPRLMWrapper.h"

@interface XScrollViewController : XViewController <XPRLMDelegate>

@property (nonatomic, readonly) XPRLMWrapper *prlmWrapper;

@property (nonatomic, strong) UIScrollView *scrollView;

- (Class)scrollViewClass;

- (void)createScrollView;

- (BOOL)enablePullToRefresh;

- (BOOL)enableLoadMore;

@end
