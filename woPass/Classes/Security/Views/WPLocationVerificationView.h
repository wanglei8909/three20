//
//  WPLocationVerificationView.h
//  woPass
//
//  Created by htz on 15/7/10.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XObject.h"
@class NIAttributedLabel;


@interface WPLocationVerificationViewCell : UIView

@property (nonatomic, strong)UIImageView *backgroundImageView;
@property (nonatomic, strong)NIAttributedLabel *titleLable;
@property (nonatomic, strong)UIImageView *iconImageView;

@end

@interface WPLocationVerificationView : UIView

@property (nonatomic, strong)NSArray *itemsArray;


@end
