//
//  YDPRLMWrapper.h
//  pandaMentor
//
//  Created by Tulipa on 14/10/13.
//  Copyright (c) 2014年  reserved.
//

#import <Foundation/Foundation.h>
#import "XPRLMDelegate.h"
#import "XPRLMState.h"

@interface XPRLMWrapper : NSObject <UITableViewDelegate>

@property (nonatomic, assign) XPRLMState state;
@property (nonatomic, weak) id<XPRLMDelegate> delegate;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat contentOffsetNeededToTriggerPullToRefresh;
@property (nonatomic, assign) CGFloat contentOffsetNeededToTriggerLoadMore;

@property (nonatomic, assign) BOOL enableLoadMore;
@property (nonatomic, assign) BOOL hasMore;

- (instancetype)initWithScrollView:(UIScrollView *)inScrollView delegate:(id<XPRLMDelegate>)inDelegate;

- (void)didFinishRefreshing;
- (void)didFinishLoadMore;

- (void)triggerPullToRefresh;

@end
