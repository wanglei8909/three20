//
//  YDTableLoadMoreView.h
//  pandaMentor
//
//  Created by 臧金晓 on 14/11/28.
//  Copyright (c) 2014年  reserved.
//

#import <UIKit/UIKit.h>

#import "XPRLMState.h"

@interface XTableLoadMoreView : UIView

@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, assign) XPRLMState state;

@end
