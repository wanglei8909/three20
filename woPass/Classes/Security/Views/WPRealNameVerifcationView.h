//
//  WPRealNameVerifcationView.h
//  woPass
//
//  Created by htz on 15/7/13.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XObject.h"
@class WPTextField;

@interface WPRealNameVerifcationView : UIView

@property (nonatomic, strong)UIButton *titleButton;
@property (nonatomic, strong)WPTextField *inputTextField;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *placeHolder;
@property (nonatomic, copy)void (^beginEditeAction)(void);

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder beginEdite:(void (^)(void)) beginEditeAction;

@end
