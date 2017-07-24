//
//  WPTicketCell.m
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPTicketCell.h"
#import "UIImageView+WebCache.h"
#import "WPDateFormatterManager.h"

@implementation WPTicketCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _topVivew = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-20, 35)];
        _topVivew.backgroundColor = [UIColor colorWithRed:191/255.0 green:195/255.0 blue:195/255.0 alpha:1];
        [self.contentView addSubview:_topVivew];
        
        UIImageView *botView = [[UIImageView alloc]initWithFrame:CGRectMake(_topVivew.left, _topVivew.bottom-12, _topVivew.width, 144-23-15)];
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
        
        _ticketNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconImageView.right+15, _iconImageView.top-3, 138, 17)];
        _ticketNameLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_ticketNameLabel];
        
        UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(_topVivew.left+10, _iconImageView.bottom+10, _topVivew.width-20, 3)];
        lineView.image = [UIImage imageNamed:@"linecoupons"];
        [self.contentView addSubview:lineView];
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconImageView.left, lineView.bottom, SCREEN_WIDTH-40, 35)];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        _dateLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        _dateLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_dateLabel];
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(_ticketNameLabel.left, _ticketNameLabel.bottom+10, 250, 15)];
        _numLabel.backgroundColor =[UIColor clearColor];
        _numLabel.font =[UIFont systemFontOfSize:13];
        _numLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        [self.contentView addSubview:_numLabel];
        
        _priceLabel = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(_ticketNameLabel.right, _ticketNameLabel.top-10, _topVivew.width-_ticketNameLabel.right, 40)];
        _priceLabel.text  = @"158";
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.textColor = RGBCOLOR_HEX(KTextOrangeColor);
        [_priceLabel setFont:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
        [self.contentView addSubview:_priceLabel];
        
        _getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getBtn.frame = CGRectMake(_priceLabel.right-70, lineView.bottom+5, 70, 26);
        _getBtn.layer.masksToBounds = YES;
        _getBtn.layer.cornerRadius = 3;
        _getBtn.backgroundColor = [UIColor colorWithRed:191/255.0 green:195/255.0 blue:195/255.0 alpha:1];
        _getBtn.userInteractionEnabled = NO;
        [_getBtn setTitle:@"免费领取" forState:UIControlStateNormal];
        _getBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_getBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_getBtn addTarget:self action:@selector(GetClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_getBtn];
        
        _hasGot = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"received"]];
        _hasGot.hidden = YES;
        _hasGot.center = CGPointMake(botView.width*0.5, _iconImageView.center.y);
        [self.contentView addSubview:_hasGot];
    }
    return self;
}
- (void)GetClick{
    if (self.getClick) {
        self.getClick();
    }
}

-(void)layoutSubviews{
    
    /*
     activityName = wsxing;
     couponBalance = 10;
     endDate = "2015-07-16";
     hasGot = 1;
     id = 1;
     img = "http://api.life.wobendi.cn/res/2015/07/15/f0b39697-2084-4ba2-b635-3794c953a3f4.png";
     restNum = 1;
     startDate = "2015-07-14";
     storeImg = "http://api.life.wobendi.cn/res/2015/04/14/a35d22ba-9242-4d2d-9ed9-051385e94657.jpeg";
     storeName = "\U5929\U732b";
     totalNum = 1;
    */
    if (self.model.hasGot == 0) {//没领
        [_getBtn setBackgroundImage:[UIImage imageNamed:@"button2"] forState:UIControlStateNormal];
        _getBtn.enabled = YES;
        _topVivew.image = [UIImage imageNamed:@"bdcolor"];
        _priceLabel.textColor = RGBCOLOR_HEX(KTextOrangeColor);
        _hasGot.hidden = YES;
        //判断有没有过期
        NSDate *date = [[WPDateFormatterManager sharedManager] dateFromString:self.model.endDate];
        NSLog(@"-----------||||%@",date);
        NSTimeInterval nInterval = [date timeIntervalSince1970];
        if (nInterval <= [[NSDate date] timeIntervalSince1970]) {
            //过期了
            _getBtn.enabled = NO;
            [_getBtn setBackgroundImage:nil forState:UIControlStateNormal];
            _topVivew.image = nil;
            _priceLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        }else{
            //没过期
        }
    }else{
        _getBtn.enabled = NO;
        [_getBtn setBackgroundImage:nil forState:UIControlStateNormal];
        _hasGot.hidden = NO;
        _topVivew.image = nil;
        _priceLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
    }

    _dateLabel.text = [NSString stringWithFormat:@"%@--%@",self.model.startDate,self.model.endDate];
    _storeNameLabel.text = self.model.storeName;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:self.model.storeImg] placeholderImage:[UIImage imageNamed:@"iconfont-dianpu"]];
    _ticketNameLabel.text = self.model.activityName;
    _numLabel.text = [NSString stringWithFormat:@"剩余：%d",self.model.restNum];
    _priceLabel.text = [NSString stringWithFormat:@"￥%d",self.model.couponBalance];
    [_priceLabel setFont:[UIFont systemFontOfSize:30] range:NSMakeRange(1, _priceLabel.text.length-1)];
}

@end
