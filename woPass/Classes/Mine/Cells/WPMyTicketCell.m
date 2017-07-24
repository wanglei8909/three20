//
//  WPMyTicketCell.m
//  woPass
//
//  Created by 王蕾 on 15/7/22.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMyTicketCell.h"
#import "UIImageView+WebCache.h"

@implementation WPMyTicketCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _topVivew = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 35)];
        _topVivew.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_topVivew];
        
        UIImageView *botView = [[UIImageView alloc]initWithFrame:CGRectMake(_topVivew.left, _topVivew.bottom-12, _topVivew.width, 133-35+5)];
        botView.image = [UIImage imageNamed:@"couponsBg"];
        [self.contentView addSubview:botView];
        
        _storeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_topVivew.left+3, _topVivew.top, _topVivew.width-6, _topVivew.height-12)];
        _storeNameLabel.backgroundColor = [UIColor clearColor];
        _storeNameLabel.font = [UIFont systemFontOfSize:14];
        _storeNameLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_storeNameLabel];
        
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_topVivew.left+15, _topVivew.bottom+5, 37.5, 37.5)];
        //_iconImageView.backgroundColor = [UIColor lightGrayColor];
        _iconImageView.image = [UIImage imageNamed:@"iconfont-dianpu"];
        [self.contentView addSubview:_iconImageView];
        
        _ticketNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconImageView.right+15, _iconImageView.top, 138, 17)];
        _ticketNameLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_ticketNameLabel];
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(_ticketNameLabel.left, _ticketNameLabel.bottom+10, _ticketNameLabel.width+20, 12)];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        _dateLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_dateLabel];
        
        UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(_topVivew.left+10, _iconImageView.bottom+10, _topVivew.width-20, 3)];
        lineView.image = [UIImage imageNamed:@"linecoupons"];
        [self.contentView addSubview:lineView];
        
        _smallIcon = [[UIImageView alloc]initWithFrame:CGRectMake(_iconImageView.left+5, lineView.bottom+10, 21.5, 15)];
        [self.contentView addSubview:_smallIcon];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(_smallIcon.right+5, _smallIcon.top, 65, 15)];
        label.backgroundColor =[UIColor clearColor];
        label.font =[UIFont systemFontOfSize:13];
        label.text = @"优惠券码：";
        [self.contentView addSubview:label];
        
        _numLabel = [[UITextView alloc]initWithFrame:CGRectMake(label.right, _smallIcon.top-9, 250, 25)];
        _numLabel.backgroundColor =[UIColor clearColor];
        _numLabel.font =[UIFont systemFontOfSize:13];
        _numLabel.editable = NO;
        _numLabel.scrollEnabled = NO;
        [self.contentView addSubview:_numLabel];
        
        _priceLabel = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(_ticketNameLabel.right, _ticketNameLabel.top-10, _topVivew.width-_ticketNameLabel.right, 40)];
        _priceLabel.text  = @"158";
        _priceLabel.textAlignment = NSTextAlignmentRight;
        //_priceLabel.font = [UIFont systemFontOfSize:30];
        _priceLabel.textColor = RGBCOLOR_HEX(KTextOrangeColor);
        [_priceLabel setFont:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
        [self.contentView addSubview:_priceLabel];
    }
    return self;
}

-(void)layoutSubviews{
    /*
    {
        "couponStatus": 0,  //卡券状态  0：未使用 1：已使用
        "img": "http://img.wohulian.com/avatar/2015/07/15/f0b39697-2084-4ba2-b635-3794c953a3f4.png", //卡券图标
        "activityName": "wsxing",//活动名称
        "storeName": "\u5929\u732b", //商家名称
        "couponNo": "10000", //卡券码
        "expire": false, //是否过期   true：过期   false：未过期
        "couponBalance": 10, //卡券面值
        "id": 1  //用户卡券ID
    },*/
    
    if (self.model.couponStatus == 0) {
        _topVivew.image = [UIImage imageNamed:@"bdcolor"];
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
        _topVivew.image = [UIImage imageNamed:@"bdcolor"];
        _priceLabel.textColor = RGBCOLOR_HEX(KTextOrangeColor);
        _smallIcon.image = [UIImage imageNamed:@"iconfont"];
    }
    _dateLabel.text = [NSString stringWithFormat:@"%@--%@",self.model.validStartDate,self.model.validEndDate];
    _storeNameLabel.text = self.model.storeName;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:self.model.img] placeholderImage:[UIImage imageNamed:@"iconfont-dianpu"]];
    _ticketNameLabel.text = self.model.activityName;
    _numLabel.text = [NSString stringWithFormat:@"%@",self.model.couponNo];
    _priceLabel.text = [NSString stringWithFormat:@"￥%d",self.model.couponBalance];
    [_priceLabel setFont:[UIFont systemFontOfSize:30] range:NSMakeRange(1, _priceLabel.text.length-1)];
}


@end
