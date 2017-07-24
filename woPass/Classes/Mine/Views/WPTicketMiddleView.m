//
//  WPTicketMiddleView.m
//  woPass
//
//  Created by 王蕾 on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPTicketMiddleView.h"

@implementation WPTicketMiddleView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *icon = [[UIView alloc]initWithFrame:CGRectMake(10, 8, 5, 15)];
        icon.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
        [self addSubview:icon];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(icon.right+5, icon.top, 100, 16)];
        title.font = [UIFont systemFontOfSize:16];
        title.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        title.text = @"活动详情";
        [self addSubview:title];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, icon.bottom+5, SCREEN_WIDTH-20, 0.3)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:line];
        
        self.desLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, line.bottom+5, SCREEN_WIDTH-30, 0)];
        self.desLabel.numberOfLines = 0;
        self.desLabel.font = [UIFont systemFontOfSize:12];
        self.desLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        [self addSubview:self.desLabel];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)LoadContent:(NSString *)des{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:des];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [text addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSParagraphStyleAttributeName :paragraphStyle
                          } range:NSMakeRange(0, text.length)];
    self.desLabel.height = [self getTextWidthAndHeight:des fontSize:12 uiWidth:self.desLabel.width].height;
    self.desLabel.attributedText = text;
    self.height = self.desLabel.height+45;
}
- (CGSize) getTextWidthAndHeight:(NSString *)str fontSize:(int) fontSize uiWidth:(int) uiWidth{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];//调整行间距
    
    return [str boundingRectWithSize:CGSizeMake(uiWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:
  @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName :paragraphStyle
    } context:nil].size;
}


@end







