//
//  WPMIneAppCellItem.m
//  woPass
//
//  Created by htz on 15/7/13.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMIneAppCellItem.h"
#import "NIAttributedLabel.h"
#import "UIImageView+WebCache.h"
#import "WPAppAlertView.h"
#import <objc/runtime.h>
#import "WPURLManager.h"

@implementation WPMIneAppCellItem

- (Class)cellClass {
    
    return [WPMIneAppCell class];
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return 70;
}

+ (NSDictionary *)replacedKeyFromPropertyName {
    
    return @{
             @"title" : @"appName",
             @"imageURL" : @"appIcon",
             @"actionURL" : @"openUrl",
             @"starLevel" : @"startLevel"
             };

}

- (TZBasicCellMarginType)marginType {
    
    return TZBasicCellAllMargin;
}


@end

@interface WPMIneAppCell ()

@property (nonatomic, strong)NSString *notice;

@end

@implementation WPMIneAppCell

- (WPstarLevelVIew *)starLevelView {
    if (!_starLevelView) {
        _starLevelView = [[WPstarLevelVIew alloc] init];
        
        [self.contentView addSubview:_starLevelView];
    }
    return _starLevelView;
}

- (NIAttributedLabel *)subTitleLable {
    if (!_subTitleLable) {
        _subTitleLable = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        
        [self.contentView addSubview:_subTitleLable];
    }
    return _subTitleLable;
}

- (UIButton *)accessoryButton {
    if (!_accessoryButton) {
        _accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_accessoryButton setTitle:@"解绑" forState:UIControlStateNormal];
        [_accessoryButton setTitleColor:RGBCOLOR_HEX(0xED6D02) forState:UIControlStateNormal];
        [_accessoryButton setBackgroundColor:RGBCOLOR_HEX(0xFFDBBB)];
        _accessoryButton.layer.cornerRadius = 5;
        _accessoryButton.layer.borderColor = RGBCOLOR_HEX(0xED6D02).CGColor;
        _accessoryButton.layer.borderWidth = 1;
        _accessoryButton.titleLabel.font = XFont(kFontMiddle);
        [_accessoryButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_accessoryButton];
    }
    return _accessoryButton;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)clickButton:(UIButton *)button {
    
    WPMIneAppCellItem *item = objc_getAssociatedObject(self.accessoryButton, BUTTONITEMKEY);
    if (item.actionURL) {
        
        [BaiduMob logEvent:@"id_app" eventLabel:@"unbundling"];
        [[NSNotificationCenter defaultCenter] postNotificationName:WPMineAppDebindingNotification object:self];
    } else if (item.bindUrl) {
        
        [BaiduMob logEvent:@"id_app" eventLabel:@"check"];
        [WPURLManager openURLWithMainTitle:self.titleLabel.text urlString:item.bindUrl];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.iconImageView.size = CGSizeMake(55, 55);
    self.iconImageView.left = 13;
    self.iconImageView.top = (self.contentView.height - self.iconImageView.height) / 2;
    
    if (!self.subTitleLable.isHidden) {
     
        [self.subTitleLable x_sizeToFit];
        self.subTitleLable.left = self.iconImageView.right + 18;
        self.subTitleLable.bottom = self.height / 2 + 1;

        [self.titleLabel x_sizeToFit];
        self.titleLabel.left = self.iconImageView.right + 18;
        self.titleLabel.bottom = self.subTitleLable.top;
        
    } else {
        
        [self.subTitleLable x_sizeToFit];
        
        [self.titleLabel x_sizeToFit];
        self.titleLabel.left = self.iconImageView.right + 18;
        self.titleLabel.bottom = self.height / 2 - 5;
    }
    
    [self.starLevelView x_sizeToFit];
    self.starLevelView.left = self.titleLabel.left;
    self.starLevelView.top = self.height / 2 + 10;
    
    self.accessoryButton.size = CGSizeMake(42, 25);
    self.accessoryButton.right = self.width - 10;
    self.accessoryButton.centerY = self.height / 2;
}

- (void)setTableViewCellItem:(WPMIneAppCellItem *)tableViewCellItem {
    
    [super setTableViewCellItem:tableViewCellItem];
    
    objc_setAssociatedObject(self.accessoryButton, BUTTONITEMKEY, tableViewCellItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (tableViewCellItem.actionURL) {
     
        [tableViewCellItem applyActionBlock:^(UITableView *tableView, id info) {
            
            [WPURLManager openURLWithMainTitle:self.titleLabel.text urlString:tableViewCellItem.actionURL];
        }];
        
        [self.accessoryButton setTitle:@"解绑" forState:UIControlStateNormal];
    }
    
    if (tableViewCellItem.bindUrl) {
        
        
        [self.accessoryButton setTitle:@"查看" forState:UIControlStateNormal];
    }
    
    if (tableViewCellItem.subTitle) {
        
        self.subTitleLable.hidden = NO;
    } else {
        
        self.subTitleLable.hidden = YES;
    }
    
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:tableViewCellItem.imageURL] placeholderImage:(tableViewCellItem.iconName ? [UIImage imageNamed:tableViewCellItem.iconName] : [UIImage imageNamed:@"iconfont-morentu"])];
    self.subTitleLable.text = tableViewCellItem.subTitle;
    self.starLevelView.starLevel = tableViewCellItem.starLevel;
    
    [self setNeedsLayout];
}

@end

