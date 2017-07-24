//
//  WPNearbyCellItem.m
//  woPass
//
//  Created by 王蕾 on 15/8/28.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPNearbyCellItem.h"

@implementation WPNearbyCellItem

- (Class)cellClass {
    return [WPNearbyCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return 175;
}

@end


@implementation WPNearbyCell
- (UIView *)mainView {
    if (!_mainView) {
        float perH = 40;
        float h = 3*perH+35;
        
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h)];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.layer.borderWidth = 1;
        _mainView.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        [self.contentView addSubview:_mainView];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 35, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [_mainView addSubview:line];
        
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 35) ;
        titleBtn.backgroundColor = [UIColor clearColor];
        [titleBtn addTarget:self action:@selector(ItemClick:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.tag = 1000;
        [_mainView addSubview:titleBtn];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleBtn.width-25, 35)];
        title.text = @"周边快查";
        title.font = [UIFont systemFontOfSize:15];
        [titleBtn addSubview:title];
        
        //youjiantou-
        UIImageView *accView = [[UIImageView alloc]initWithFrame:CGRectMake(_mainView.width-20, 11, 8, 13.5)];
        accView.image = [UIImage imageNamed:@"youjiantou-"];
        [_mainView addSubview:accView];
        
        perH = 40;
        
        NSArray *items = @[@"[出行]",@"公交站",@"地铁站",@"加油站",@"[生活]",@"银行",@"超市",@"药店",@"[美食]",@"中餐",@"火锅",@"川菜"];
        
        for ( int i = 0; i<(items.count-1/4+1); i++) {
            for (int j = 0; j<4; j++) {
                if (i*4+j<=items.count-1) {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake(j*(SCREEN_WIDTH)/4, 35+i*perH, SCREEN_WIDTH/4, perH);
                    [btn setTitle:items[i*4+j] forState:UIControlStateNormal];
                    [btn setTitleColor:RGBCOLOR_HEX(kLabelDarkColor) forState:UIControlStateNormal];
                    btn.tag = 100+i*4+j;
                    btn.titleLabel.font = [UIFont systemFontOfSize:14];
                    [_mainView addSubview:btn];
                    
                    if (j == 0) {
                        [btn setTitleColor:RGBCOLOR_HEX(kLabelWeakColor) forState:UIControlStateNormal];
                    }else{
                        [btn addTarget:self action:@selector(ItemClick:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    
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
    return _mainView;
}
- (void)ItemClick:(UIButton *)sender{
    if (sender.tag == 1000) {
        [@"WP://WPNearbyAllItemsCtrl" open];
        [BaiduMob logEvent:@"id_local" eventLabel:@"more"];
        return;
    }
    NSArray *items = @[@"[出行]",@"公交站",@"地铁站",@"加油站",@"[生活]",@"银行",@"超市",@"药店",@"[美食]",@"中餐",@"火锅",@"川菜"];
    NSString *content = items[sender.tag-100];
    [@"WP://WPNearbyPOIViewController" openWithQuery:@{
                                                       @"searchKey" :content
                                                       }];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(kPadding, 0, 0, 0));
    
}

- (void)setTableViewCellItem:(WPNearbyCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    
    self.mainView.hidden = NO;
}


@end








