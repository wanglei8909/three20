//
//  WPLoginVerificationCellItem.m
//  woPass
//
//  Created by htz on 15/7/10.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLoginVerificationCellItem.h"
#import "NIAttributedLabel.h"

@implementation WPLoginVerificationCellItem

- (Class)cellClass {
    return [WPLoginVerificationCell class];
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return 15 + (self.itemsArray ? 115 : 60);
}

@end

@implementation WPLoginVerificationCell

- (UISwitch *)switchAccessoryView {
    if (!_switchAccessoryView) {
        _switchAccessoryView = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 55, 30)];
        _switchAccessoryView.onTintColor = RGBCOLOR_HEX(KTextOrangeColor);
        [self.contentView addSubview:_switchAccessoryView];
    }
    return _switchAccessoryView;
}
- (NIAttributedLabel *)subTitleLabel {
    if (!_subTitleLabel) {
        
        _subTitleLabel = [NIAttributedLabel labelWithFontSize:kFontTiny color:RGBCOLOR_HEX(kLabelWeakColor)];
        [self.contentView addSubview:_subTitleLabel];
    }
    return _subTitleLabel;
}

- (WPLocationVerificationView *)locationVerificationView {
    if (!_locationVerificationView) {
        _locationVerificationView = [[WPLocationVerificationView alloc] init];
        _locationVerificationView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_locationVerificationView];
        
    }
    return _locationVerificationView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.headTitleLabel.width = self.contentView.width - 50;
    self.headTitleLabel.numberOfLines = 0;
    self.headTitleLabel.height = 30;
    self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(15, 0, 0, 0));
    self.switchAccessoryView.right = self.contentView.right - 10;
    
    if (!self.locationVerificationView.isHidden) {
        
        self.iconImageView.top = 15;
        self.switchAccessoryView.top = 15;
    } else {
        
        self.iconImageView.top = (self.contentView.height - self.iconImageView.height) / 2;
        self.switchAccessoryView.top = (self.contentView.height - self.switchAccessoryView.height) / 2;
    }
    
    self.titleLabel.top = 15;
    
    [self.subTitleLabel x_sizeToFit];
    self.subTitleLabel.top = self.titleLabel.bottom + 5;
    self.subTitleLabel.left = self.titleLabel.left;
    
    self.locationVerificationView.width = SCREEN_WIDTH - 40 * 2;
    self.locationVerificationView.height = 40;
    self.locationVerificationView.left = 40;
    self.locationVerificationView.top = self.subTitleLabel.bottom + 15;
}

- (void)setTableViewCellItem:(WPLoginVerificationCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    self.subTitleLabel.text = tableViewCellItem.subTitle;
    self.locationVerificationView.itemsArray = tableViewCellItem.itemsArray;
    if (tableViewCellItem.itemsArray) {
        
        self.locationVerificationView.hidden = NO;
    } else {
        
        self.locationVerificationView.hidden = YES;
    }
    [self setNeedsLayout];

}

@end
