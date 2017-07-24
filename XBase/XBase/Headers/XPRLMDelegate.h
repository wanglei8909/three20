//
//  YDPRLMDelegate.h
//  pandaMentor
//
//  Created by Tulipa on 14/10/13.
//  Copyright (c) 2014年  reserved.
//

#import <Foundation/Foundation.h>

@class XPRLMWrapper;

@protocol XPRLMDelegate <NSObject>

#pragma mark - Pull To Refresh -

@optional

- (void)scrollView:(UIScrollView *)inScrollView willTriggerPullToRefresh:(XPRLMWrapper *)inWrapper;
- (void)scrollView:(UIScrollView *)inScrollView willCancelPullToReFresh:(XPRLMWrapper *)inWrapper;
- (void)scrollView:(UIScrollView *)inScrollView didTriggerPullToRefresh:(XPRLMWrapper *)inWrapper;
//- (BOOL)scrollView:(UIScrollView *)inScrollView shouldTriggerPullToRefresh:(YDPRLMWrapper *)inWrapper;

- (void)scrollView:(UIScrollView *)inScrollView willTriggerLoadMore:(XPRLMWrapper *)inWrapper;
- (void)scrollView:(UIScrollView *)inScrollView willCancelLoadMore:(XPRLMWrapper *)inWrapper;
- (void)scrollView:(UIScrollView *)inScrollView didTriggerLoadMore:(XPRLMWrapper *)inWrapper;
//- (BOOL)scrollView:(UIScrollView *)inScrollView shouldTriggerLoadMore:(YDPRLMWrapper *)inWrapper;

@end
