//
//  WPMyOrderCell.m
//  woPass
//
//  Created by 王蕾 on 15/7/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMyOrderCell.h"
#import "UIImageView+WebCache.h"

@implementation WPMyOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(-1, 0, SCREEN_HEIGHT+2, 125)];
        back.backgroundColor =[UIColor whiteColor];
        back.layer.borderWidth = 1;
        back.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        [self.contentView addSubview:back];
        
        _iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 65, 65)];
        [self.contentView addSubview:_iconImage];
        
        _nameLabel = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(_iconImage.right+10, _iconImage.top+5, SCREEN_WIDTH-15-_iconImage.right-10, 40)];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_nameLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom, _nameLabel.width, 20)];
        _priceLabel.textColor = RGBCOLOR_HEX(KTextOrangeColor);
        _priceLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_priceLabel];
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left+60, _priceLabel.top, 50, 20)];
        _numLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        _numLabel.font = _priceLabel.font;
        [self.contentView addSubview:_numLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(_iconImage.left, _iconImage.bottom+10, SCREEN_WIDTH-20, 1)];
        lineView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self.contentView addSubview:lineView];
        
        UILabel *heLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconImage.left, lineView.bottom, 50, 125-lineView.bottom)];
        heLabel.text = @"合计：";
        heLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:heLabel];
        
        _totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(heLabel.right, heLabel.top, 100, heLabel.height)];
        _totalLabel.font = heLabel.font;
        [self.contentView addSubview:_totalLabel];
        
        for (int i = 0; i<2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 60, 26);
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 3;
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = i==0?RGBCOLOR_HEX(kLabelDarkColor).CGColor:RGBCOLOR_HEX(KTextOrangeColor).CGColor;
            btn.tag = 100+i;
            [btn setTitle:i==0?@"删除":@"付款" forState:UIControlStateNormal];
            [btn setTitleColor:i==0?RGBCOLOR_HEX(kLabelDarkColor):RGBCOLOR_HEX(KTextOrangeColor) forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
            if (i==0) {
                _deleteBtn = btn;
            }else _payBtn = btn;
        }
    }
    return self;
}
-(void)BtnClick:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    if (sender.tag == 100) {
        if (self.deleteBlock) {
            self.deleteBlock(weakSelf);
        }
    }else{
        if (self.payBlock) {
            self.payBlock(weakSelf);
        }
    }
}

-(void)layoutSubviews{
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:self.model.img] placeholderImage:[UIImage imageNamed:@"iconfont-duihuanshangpin"]];
    _nameLabel.text = self.model.goodsName;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.model.originalPrice];
    _totalLabel.text = [NSString stringWithFormat:@"￥%.2f",self.model.orderPrice];
    _numLabel.text = [NSString stringWithFormat:@"x%d",self.model.buyNum];
    
    if (self.model.orderPayState == 0) {
        _payBtn.hidden = NO;
        _deleteBtn.frame = CGRectMake(SCREEN_WIDTH-140, _totalLabel.top+6, 60, 26);
        _payBtn.frame = CGRectMake(_deleteBtn.right+10, _deleteBtn.top, 60, 26);
    }else{
        _payBtn.hidden = YES;
        _deleteBtn.frame = CGRectMake(SCREEN_WIDTH-70, _totalLabel.top+5, 60, 26);
    }
}

@end












