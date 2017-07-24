//
//  WPLLCell.m
//  woPass
//
//  Created by 王蕾 on 15/8/12.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLLCell.h"

@implementation WPLLCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 69)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius =2;
//        view.layer.borderWidth = 1;
//        view.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        [self.contentView addSubview:view];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, view.width-80, 16)];
        _nameLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [view addSubview:_nameLabel];
        
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _nameLabel.bottom, view.width-80, 40)];
        _desLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        _desLabel.numberOfLines = 2;
        _desLabel.font = [UIFont systemFontOfSize:14];
        [view addSubview:_desLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(view.width-75, 15, 1, view.height-30)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [view addSubview:line];
        
        _priceLabel = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(view.width-75, 25, 75, 30)];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.textColor = RGBCOLOR_HEX(KTextOrangeColor);
        _priceLabel.backgroundColor =[UIColor clearColor];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        [view addSubview:_priceLabel];
        
        UIImageView *normal = [[UIImageView alloc]initWithFrame:view.bounds];
        normal.image = [UIImage imageNamed:@"weixuanzhong"];
        [view addSubview:normal];
        
        //[UIImage imageNamed:@"xuazhongtop02"]
        _selectedView = [[UIImageView alloc]initWithFrame:view.bounds];
        _selectedView.image = [UIImage imageNamed:@"xuazhongtop02"];
        [view addSubview:_selectedView];
    }
    return self;
}
-(void)layoutSubviews{
    _nameLabel.text = self.model.productName;
    _desLabel.text = self.model.des;
    _priceLabel.text = self.model.current_price;
    _selectedView.hidden = !self.model.selected;
}

@end
