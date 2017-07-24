//
//  WPPhoneInfoView.m
//  woPass
//
//  Created by 王蕾 on 15/8/31.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPPhoneInfoView.h"

@implementation WPPhoneInfoView

-(instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 200 )];
    if (self) {
        
        
        UIView *subBack = [[UIView alloc]initWithFrame:CGRectMake(0, 70, self.width, 200)];
        subBack.backgroundColor = [UIColor clearColor];
        subBack.layer.borderWidth = 1;
        subBack.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        subBack.layer.masksToBounds = YES;
        subBack.layer.cornerRadius = 3;
        [self addSubview:subBack];
        
        for (int i = 0; i<6; i++) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, i*40, self.width, 0.6)];
            line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
            [subBack addSubview:line];
        }
        for (int i = 0; i<5; i++) {
            UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10+i*40, 20, 20)];
            icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"info%d",i]];
            icon.contentMode = UIViewContentModeScaleAspectFit;
            [subBack addSubview:icon];
        }
        
        NSArray *nameArray = @[@"账户:",@"套餐:",@"网络:",@"用户状态:",@"付费类型:"];
        for (int i = 0; i<5; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, i*40, 100, 40)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = RGBCOLOR_HEX(kLabelDarkColor);
            label.font = [UIFont systemFontOfSize:kFontMiddle];
            label.textAlignment = NSTextAlignmentLeft;
            label.text = nameArray[i];
            [subBack addSubview:label];
        }
        
        for (int i = 0; i<5; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(110, i*40, subBack.width-100, 40)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = RGBCOLOR_HEX(kLabelDarkColor);
            label.font = [UIFont systemFontOfSize:kFontMiddle];
            label.textAlignment = NSTextAlignmentLeft;
            [subBack addSubview:label];
            
            i==0?_phoneNum = label: @"";
            i==1?_package = label: @"";
            i==2?_netLabel = label: @"";
            i==3?_phoneStatus = label: @"";
            i==4?_payType = label: @"";
        }
    }
    return self;
}
- (void)LoadContent:(NSDictionary *)dict{
    _phoneNum.text = dict[@"mobile"];
    _phoneStatus.text = dict[@"userState"];
    _package.text = dict[@"productName"];
    _netLabel.text = dict[@"brand"];
    _payType.text = dict[@"userType"];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
