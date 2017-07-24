//
//  WPWPDTTLoginCell.m
//  woPass
//
//  Created by 王蕾 on 15/12/1.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPWPDTTLoginCell.h"
#import "WPReturnTitle.h"
#import "WPDTTLoginAndCityView.h"

@implementation WPWPDTTLoginCell
{
    WPDTTLoginAndCityView *loginView;
}

- (void)configUI:(NSMutableArray *)dataArray{
    
    self.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.contentView.bottom-1, SCREEN_WIDTH, 1)];
    line.image = [UIImage imageNamed:@"PorLine"];
    [self.contentView addSubview:line];
    
    if (!loginView) {
        loginView = [[WPDTTLoginAndCityView alloc]initWithFrame:CGRectMake(60, 50, SCREEN_WIDTH-120, self.frame.size.height)];
        loginView.dataSource = dataArray;
        [loginView loadContent];
        [self.contentView addSubview:loginView];
    }
    
    [self.contentView addSubview:[WPReturnTitle ReturnTitleView:@"登录业务"]];
    
}

@end
