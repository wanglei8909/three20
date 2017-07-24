//
//  WPTicketDetailTopView.m
//  woPass
//
//  Created by 王蕾 on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPTicketDetailTopView.h"

@implementation WPTicketDetailTopView

-(instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 130)];
    if (self) {
        _topVivew = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-0, 35)];
        _topVivew.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_topVivew];
        
        UIImageView *botView = [[UIImageView alloc]initWithFrame:CGRectMake(_topVivew.left, _topVivew.bottom-12, _topVivew.width, 130-35-2)];
        botView.image = [UIImage imageNamed:@"ddbd"];
        [self addSubview:botView];
        
        _storeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_topVivew.left+13, _topVivew.top, _topVivew.width-6, _topVivew.height-12)];
        _storeNameLabel.backgroundColor = [UIColor clearColor];
        _storeNameLabel.font = [UIFont systemFontOfSize:14];
        _storeNameLabel.textColor = [UIColor whiteColor];
        [self addSubview:_storeNameLabel];
        
        
        _ticketNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, botView.top + 12, 138, 17)];
        _ticketNameLabel.text = @"傻傻的名字";
        _ticketNameLabel.font = [UIFont systemFontOfSize:16];
        _ticketNameLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        [self addSubview:_ticketNameLabel];
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(_ticketNameLabel.left, _ticketNameLabel.bottom+10, SCREEN_HEIGHT-30, 12)];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        _dateLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_dateLabel];
        
        UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(_topVivew.left+10, _dateLabel.bottom+10, _topVivew.width-20, 3)];
        lineView.image = [UIImage imageNamed:@"linecoupons"];
        [self addSubview:lineView];
        
        _smallIcon = [[UIImageView alloc]initWithFrame:CGRectMake(13, lineView.bottom+7, 21.5, 15)];
        [self addSubview:_smallIcon];
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(_smallIcon.right+5, _smallIcon.top, 250, 15)];
        _numLabel.backgroundColor =[UIColor clearColor];
        _numLabel.font =[UIFont systemFontOfSize:13];
        
        [self addSubview:_numLabel];
        
        _priceLabel = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(_ticketNameLabel.right, _ticketNameLabel.top-10, _topVivew.width-_ticketNameLabel.right-15, 40)];
        _priceLabel.text  = @"158";
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.textColor = RGBCOLOR_HEX(KTextOrangeColor);
        [_priceLabel setFont:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
        [self addSubview:_priceLabel];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.model.couponStatus == 0) {
        _topVivew.image = [UIImage imageNamed:@"ddbd-6-"];
        _priceLabel.textColor = RGBCOLOR_HEX(KTextOrangeColor);
        _smallIcon.image = [UIImage imageNamed:@"iconfont"];
    }else{
        _topVivew.image = nil;
        _priceLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        _smallIcon.image = [UIImage imageNamed:@"iconfont-youhuiquan"];
    }
    if (self.model.expire == 1) {//已过期
        _topVivew.image = nil;
        _priceLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        _smallIcon.image = [UIImage imageNamed:@"iconfont-youhuiquan"];
    }else{
        _topVivew.image = [UIImage imageNamed:@"ddbd-6-"];
        _priceLabel.textColor = RGBCOLOR_HEX(KTextOrangeColor);
        _smallIcon.image = [UIImage imageNamed:@"iconfont"];
    }
    _dateLabel.text = [NSString stringWithFormat:@"有效期：%@--%@",self.model.validStartDate,self.model.validEndDate];
    _storeNameLabel.text = self.model.storeName;
    _ticketNameLabel.text = self.model.activityName;
    _ticketNameLabel.text = @"优惠券名字";
    _numLabel.text = [NSString stringWithFormat:@"优惠券码：%@",self.model.couponNo];
    _priceLabel.text = [NSString stringWithFormat:@"￥%d",self.model.couponBalance];
    [_priceLabel setFont:[UIFont systemFontOfSize:30] range:NSMakeRange(1, _priceLabel.text.length-1)];
}

@end
