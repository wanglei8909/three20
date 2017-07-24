//
//  WPAppAlertView.h
//  woPass
//
//  Created by htz on 15/7/27.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WPAppAlertViewDelegate <NSObject>

@required
- (void)appAlertViewConfigButtonClick;
- (void)appAlertViewCancelButtonClick;


@end

@interface WPAppAlertView : UIView

@property (nonatomic, weak)id<WPAppAlertViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title;


@end
