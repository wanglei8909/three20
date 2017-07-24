//
//  WPPhoneInfoView.h
//  woPass
//
//  Created by 王蕾 on 15/8/31.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPPhoneInfoView : UIView

@property (nonatomic, strong)UILabel *phoneNum;
@property (nonatomic, strong)UILabel *phoneStatus;
@property (nonatomic, strong)UILabel *package;
@property (nonatomic, strong)UILabel *netLabel;
@property (nonatomic, strong)UILabel *payType;


- (void)LoadContent:(NSDictionary *)dict;

@end
