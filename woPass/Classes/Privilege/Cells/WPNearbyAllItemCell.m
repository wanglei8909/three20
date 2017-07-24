//
//  WPNearbyAllItemCell.m
//  woPass
//
//  Created by 王蕾 on 15/8/27.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPNearbyAllItemCell.h"

@implementation WPNearbyAllItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)layoutSubviews{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    float perH = 40;
    float h = ((self.items.count-2)/3+1)*perH+35+10;
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, h-10)];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.borderWidth = 1;
    back.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
    [self.contentView addSubview:back];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 35, SCREEN_WIDTH-20, 0.5)];
    line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
    [back addSubview:line];
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH-20, 35) ;
    titleBtn.backgroundColor = [UIColor clearColor];
    [titleBtn addTarget:self action:@selector(ItemClick:) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.tag = 100;
    [back addSubview:titleBtn];
    
    NSString *imageName = [NSString stringWithFormat:@"nearby%d",self.indexPath];
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 25, 25)];
    icon.image = [UIImage imageNamed:imageName];
    [titleBtn addSubview:icon];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, titleBtn.width-25, 35)];
    title.text = self.items[0];
    [titleBtn addSubview:title];
    
    //youjiantou-
    UIImageView *accView = [[UIImageView alloc]initWithFrame:CGRectMake(back.width-20, 11, 8, 13.5)];
    accView.image = [UIImage imageNamed:@"youjiantou-"];
    [back addSubview:accView];
    
    switch (self.indexPath) {
        case 0:
            title.textColor = RGBCOLOR_HEX(0xf76363);
            break;
        case 1:
            title.textColor = RGBCOLOR_HEX(0x57aef3);
            break;
        case 2:
            title.textColor = RGBCOLOR_HEX(0xffb506);
            break;
        case 3:
            title.textColor = RGBCOLOR_HEX(0x85cd1d);
            break;
        case 4:
            title.textColor = RGBCOLOR_HEX(0xed6d00);
            break;
            
        default:
            break;
    }
    
    for ( int i = 0; i<(self.items.count-2/3+1); i++) {
        for (int j = 0; j<3; j++) {
            if (i*3+j<=self.items.count-2) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(j*(SCREEN_WIDTH-20)/3, 35+i*perH, (SCREEN_WIDTH-20)/3, perH);
                [btn setTitle:self.items[1+i*3+j] forState:UIControlStateNormal];
                [btn setTitleColor:RGBCOLOR_HEX(kLabelDarkColor) forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(ItemClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = 101+i*3+j;
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                [back addSubview:btn];
                
                UIView *line = [[UIView alloc]initWithFrame:CGRectMake(btn.width, 10, 1, btn.height-20)];
                line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
                [btn addSubview:line];
                
                line = [[UIView alloc]initWithFrame:CGRectMake(0, btn.height-1, btn.width, 0.5)];
                line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
                [btn addSubview:line];
            }
        }
    }    
}
- (void)ItemClick:(UIButton *)sender{
    NSString *content = self.items[sender.tag - 100];
    if (self.searchBlock) {
        self.searchBlock(content);
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
