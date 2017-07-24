//
//  WPFangSaoRaoNavigation.m
//  woPass
//
//  Created by 王蕾 on 16/2/25.
//  Copyright © 2016年 unisk. All rights reserved.
//

#import "WPFangSaoRaoNavigation.h"

@implementation WPFangSaoRaoNavigation

{
    UILabel *title;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:18];
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"电话防骚扰";
        [self addSubview:title];
        
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        back.frame = CGRectMake(0, 20, 60, 44);
        back.backgroundColor = [UIColor clearColor];
        [back addTarget:self action:@selector(BackClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:back];
        
        UIImageView *butImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 14.8, 9, 15)];
        butImage.image = [UIImage imageNamed:@"fangsaoraoBack"];
        [back addSubview:butImage];
        
        UILabel *butLabel = [[UILabel alloc]initWithFrame:CGRectMake(butImage.right, 0, 40, 44)];
        butLabel.backgroundColor = [UIColor clearColor];
        butLabel.font = [UIFont systemFontOfSize:kFontLarge];
        butLabel.textColor = [UIColor whiteColor];
        butLabel.textAlignment = NSTextAlignmentCenter;
        butLabel.text = @"返回";
        [back addSubview:butLabel];
        
        self.backgroundColor = [UIColor colorWithRed:95/255.f green:120/255.f blue:210/255.f alpha:1];
        
    }
    return self;
}
- (void)setITitle:(NSString *)iTitle{
    title.text = iTitle;
}
- (void)BackClick{
    self.backBlock();
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
