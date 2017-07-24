//
//  XPRLMCollectionViewController.h
//  BabyDress
//
//  Created by 臧金晓 on 15/1/7.
//  Copyright (c) 2015年 7ul.ipa. All rights reserved.
//

#import "XCollectionViewController.h"
#import "XPullToRefreshView.h"
#import "XPRLMWrapper.h"
#import "XTableLoadMoreView.h"

@interface XPRLMCollectionViewController : XCollectionViewController <XPRLMDelegate>

@property (nonatomic, readonly) XPRLMWrapper *prlmWrapper;
@property (nonatomic, readonly) XPullToRefreshView *pullToRefreshView;
@property (nonatomic, readonly) XTableLoadMoreView *loadMoreView;

@end
