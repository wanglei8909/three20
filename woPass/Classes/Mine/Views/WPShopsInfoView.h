//
//  WPShopsInfoView.h
//  woPass
//
//  Created by 王蕾 on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPShopsInfoView : UIView

@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *addressStr;
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, assign) NSInteger phoneNum;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *address;

@end
