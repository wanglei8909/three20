//
//  WPFreeWiFiLabelCellItem.m
//  woPass
//
//  Created by htz on 15/8/2.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPFreeWiFiLabelCellItem.h"
#import "NIAttributedLabel.h"
#import "JMWhenTapped.h"

@interface WPFreeWiFiLabelCellItem ()

@end

@implementation WPFreeWiFiLabelCellItem

- (Class)cellClass {
    return [WPFreeWiFiLabelCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    
    return 200;
}

- (NSString *)title {
    
//    if ([gUser.freeWifiIsAvaliable integerValue]) {
//
//        return @"已连接chinaunicom热点，正在免费上网";
//    } else {
//        
//        return @"覆盖chinaunicom热点区域可实现免费上网，当前区域未覆盖chinaunicom热点，暂时无法免费上网";
//    }
    
    if ([gUser.freeWifiIsAvaliable integerValue]) {
        
        return @"您已可以通过chinaunicom热点免费上网";
    } else {
        
        return @"覆盖ChinaUnicom热点区域可实现免费上网";
    }
}

- (NSString *)wikiTitle {
    
    return @"使用说明(目前暂仅支持北京地区)";
}

@end

@interface WPFreeWiFiLabelCell ()

@end

@implementation WPFreeWiFiLabelCell

- (NIAttributedLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (NIAttributedLabel *)wikiLabel {
    if (!_wikiLabel) {
        _wikiLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(0x1a70b9)];
        _wikiLabel.textAlignment = NSTextAlignmentCenter;
        [_wikiLabel setUnderlineStyle:kCTUnderlineStyleSingle];
        [_wikiLabel whenTapped:^{
           
            [@"WP://WiFiWiKi_vc" open];
        }];
        [self.contentView addSubview:_wikiLabel];
    }
    return _wikiLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(40, 0, 0, 0));
    
    self.titleLabel.frame = CGRectMake(25, 0, SCREEN_WIDTH - 40, 40);
    self.titleLabel.numberOfLines = 0;
    
    [self.wikiLabel x_sizeToFit];
    self.wikiLabel.width *= 1.5;
    self.wikiLabel.height *= 1.5;
    self.wikiLabel.centerX = self.titleLabel.centerX;
    self.wikiLabel.top = self.titleLabel.bottom + 60;

}

- (void)setTableViewCellItem:(WPFreeWiFiLabelCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    self.titleLabel.text = tableViewCellItem.title;
    self.wikiLabel.text = tableViewCellItem.wikiTitle;
}

@end
