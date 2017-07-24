//
//  WPSexController.m
//  woPass
//
//  Created by 王蕾 on 15/7/16.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPSexController.h"
#import "WPModifyUserInfoViewModel.h"

@implementation WPSexController
{
    int genderIndex;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    genderIndex = [gUser.gender intValue];
    
    UIView *backBg = [[UIView alloc]initWithFrame:CGRectMake(-1, 80, SCREEN_WIDTH+2, 90)];
    backBg.backgroundColor = [UIColor whiteColor];
    backBg.layer.borderWidth = 1;
    backBg.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
    [self.view addSubview:backBg];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 44, SCREEN_WIDTH-15, 1)];
    lineView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
    [backBg addSubview:lineView];
    
    for (int i = 0; i<2; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, i*45, SCREEN_WIDTH-15, 45)];
        label.text = i==0?@"男":@"女";
        label.textAlignment = NSTextAlignmentLeft;
        label.tag = 1000+i;
        label.userInteractionEnabled = YES;
        [backBg addSubview:label];
        
        UIImageView *checkView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        checkView.center = label.center;
        checkView.right = SCREEN_WIDTH - 15;
        checkView.image = [UIImage imageNamed:@"back"];
        checkView.tag = 1100+i;
        [backBg addSubview:checkView];
        
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CheckClick:)]];
        if (genderIndex!=i) {
            checkView.hidden = YES;
        }
    }
}
- (void)CheckClick:(UITapGestureRecognizer *)tap{
    UIView *view = tap.view;
    for (UIView *checkView in view.superview.subviews) {
        if ([checkView isKindOfClass:[UIImageView class]]) {
            checkView.hidden = checkView.tag-1100 != view.tag-1000;
        }
    }
    genderIndex = (int)view.tag - 1000;
    [WPModifyUserInfoViewModel ChangeUserInfoWithType:@"gender" AndValue:[NSString stringWithFormat:@"%d",genderIndex] AndSecceed:^{
        
    }];
    [self dismiss];
}

- (BOOL)hideNavigationBar
{
    return YES;
}

- (BOOL)hasYDNavigationBar
{
    return YES;
}

- (BOOL)autoGenerateBackBarButtonItem
{
    return YES;
}

- (NSString *)title {
    return @"性别";
}

@end
