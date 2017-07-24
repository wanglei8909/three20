//
//  WPLoginHistoryHeadCellItem.m
//  woPass
//
//  Created by htz on 15/7/19.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLoginHistoryHeadCellItem.h"
#import "TZButton.h"

@interface WPLoginHistoryHeadCellItem ()

@end

@implementation WPLoginHistoryHeadCellItem

- (Class)cellClass {
    return [WPLoginHistoryHeadCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return 45;
}

@end

@interface WPLoginHistoryHeadCell ()

@property (nonatomic, strong)TZButton *headButton;

@end

@implementation WPLoginHistoryHeadCell

- (TZButton *)headButton {
    if (!_headButton) {
        _headButton = [TZButton buttonWithType:UIButtonTypeCustom];
        [_headButton setImage:[UIImage imageNamed:@"iconfont_shijian_1"] forState:UIControlStateNormal];
        [_headButton setTitle:@"最近登录记录" forState:UIControlStateNormal];
        _headButton.titleLabel.font = XFont(kFontMiddle);
        [_headButton setTitleColor:RGBCOLOR_HEX(0xED750D) forState:UIControlStateNormal];
        _headButton.titleEdgeInsets = UIEdgeInsetsMake(6, 5, 0, 0);
        _headButton.layer.borderColor = RGBCOLOR_HEX(0xED750D).CGColor;
        _headButton.layer.borderWidth = 0.5;
        _headButton.layer.masksToBounds = YES;
        
        _headButton.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_headButton];
        
    }
    return _headButton;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.headButton x_sizeToFit];
    self.headButton.size = CGSizeMake(self.headButton.width + 7, self.headButton.height);
    self.headButton.left = 45;
    self.headButton.bottom = self.contentView.height;
    self.headButton.layer.cornerRadius = self.headButton.height / 2;
}

- (void)setTableViewCellItem:(WPLoginHistoryHeadCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
}

@end