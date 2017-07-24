//
//  WPAlertView.h
//  woPass
//
//  Created by 王蕾 on 15/8/20.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPAlertView;
typedef void(^AVCancelBlock)();
typedef void(^AVOKBlock)();

@interface WPAlertView : UIView

@property (nonatomic, copy)AVCancelBlock cancelBlock;
@property (nonatomic, copy)AVOKBlock okBlock;

- (void)show;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles andCancleClick:(void(^)())cancleClick  andOKClick:(void(^)())OKClick;

@end
