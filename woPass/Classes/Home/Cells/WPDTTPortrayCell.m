//
//  WPDTTPortrayCell.m
//  woPass
//
//  Created by 王蕾 on 15/12/1.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPDTTPortrayCell.h"
#import "WPReturnTitle.h"
#import "WPDTTPortaryView.h"

@implementation WPDTTPortrayCell
{
    WPDTTPortaryView *portrayView;
}

- (void)configUI:(NSString *)PortrayString{
    
    self.backgroundColor = [UIColor clearColor];
    
    
    if (!portrayView) {
        portrayView = [[WPDTTPortaryView alloc]initWithFrame:CGRectMake(0, 0, 320, 235)];
        portrayView.centerX = SCREEN_WIDTH*0.5;
        [portrayView LoadContent:PortrayString];
        [self.contentView addSubview:portrayView];
    }
    
    [self.contentView addSubview:[WPReturnTitle ReturnTitleView:@"大头贴"]];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.contentView.bottom-1, SCREEN_WIDTH, 1)];
    line.image = [UIImage imageNamed:@"PorLine"];
    [self.contentView addSubview:line];

}

@end
