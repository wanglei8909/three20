//
//  WPLoginHistoryCellItem.m
//  woPass
//
//  Created by htz on 15/7/19.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLoginHistoryCellItem.h"
#import "NIAttributedLabel.h"

@interface WPLoginHistoryCellItem ()

@end

@implementation WPLoginHistoryCellItem

- (Class)cellClass {
    return [WPLoginHistoryCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return (self.isFirst ? 132 : 73);
}

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"deviceType" : @"loginDeviceType",
             @"loginCity" : @"loginRegion",
             @"loginIP" : @"loginIp"
             };
}

@end

@interface WPLoginHistoryCell ()

@property (nonatomic, strong)UIButton *dateButton;
@property (nonatomic, strong)NIAttributedLabel *timeLabel;
@property (nonatomic, strong)UIImageView *msgBoxImageView;
@property (nonatomic, strong)UIImageView *deviceImageView;
@property (nonatomic, strong)UIImageView *abnormalLoginView;
@property (nonatomic, strong)UIImageView *accessoryImageView;
@property (nonatomic, strong)NIAttributedLabel *cityLabel;
@property (nonatomic, strong)NIAttributedLabel *appLabel;
@property (nonatomic, strong)NIAttributedLabel *ipLabel;
@property (nonatomic, strong)UIView *line;
@property (nonatomic, strong)UIImageView *icon;


@end

@implementation WPLoginHistoryCell

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGBCOLOR_HEX(0xFFDBBB);
        [self.contentView addSubview:_line];
    }
    return _line;
}
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yuan"]];
        [self.contentView addSubview:_icon];
        
    }
    return _icon;
}
- (UIButton *)dateButton {
    if (!_dateButton) {
        _dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dateButton.titleLabel.font = XFont(kFontMiddle);
        [_dateButton setTitleColor:RGBCOLOR_HEX(0xED750D) forState:UIControlStateNormal];
        _dateButton.backgroundColor = RGBCOLOR_HEX(0xFFDBBB);
        _dateButton.layer.masksToBounds = YES;
        [self.contentView addSubview:_dateButton];
    }
    return _dateButton;
}
- (NIAttributedLabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(0xED750D)];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}
- (UIImageView *)msgBoxImageView {
    if (!_msgBoxImageView) {
        
        _msgBoxImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_msgBoxImageView];
    }
    return _msgBoxImageView;
}
- (UIImageView *)deviceImageView {
    if (!_deviceImageView) {
        _deviceImageView = [[UIImageView alloc] init];
        _deviceImageView.image = [UIImage imageNamed:@"mac-b"];
        [self.msgBoxImageView addSubview:_deviceImageView];
    }
    return _deviceImageView;
}
- (UIImageView *)abnormalLoginView {
    if (!_abnormalLoginView) {
        _abnormalLoginView = [[UIImageView alloc] init];
        _abnormalLoginView.image = [UIImage imageNamed:@"baocuo-loginHistory"];
        [self.msgBoxImageView addSubview:_abnormalLoginView];
    }
    return _abnormalLoginView;
}
- (UIImageView *)accessoryImageView {
    if (!_accessoryImageView) {
        _accessoryImageView = [[UIImageView alloc] init];
        _accessoryImageView.image = [UIImage imageNamed:@"youjiantou-"];
        [self.msgBoxImageView addSubview:self.accessoryImageView];
    }
    return _accessoryImageView;
}
- (NIAttributedLabel *)cityLabel {
    if (!_cityLabel) {
        _cityLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        [self.msgBoxImageView addSubview:_cityLabel];
    }
    return _cityLabel;
}
- (NIAttributedLabel *)appLabel {
    if (!_appLabel) {
        _appLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        [self.msgBoxImageView addSubview:_appLabel];
    }
    return _appLabel;
}
- (NIAttributedLabel *)ipLabel {
    if (!_ipLabel) {
        _ipLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        [self.msgBoxImageView addSubview:_ipLabel];
    }
    return _ipLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.line.frame = CGRectMake(60, 0, 2, self.contentView.height);
    
    if (self.dateButton.isHidden) {
        
        self.dateButton.frame = CGRectMake(0, 0, 0, 0);
    } else {
        
        [self.dateButton x_sizeToFit];
    }
    self.dateButton.size = CGSizeMake(self.dateButton.size.width + 30, self.dateButton.size.height);
    self.dateButton.layer.cornerRadius = self.dateButton.height / 2;
    self.dateButton.centerX = 60;
    self.dateButton.top = 20;
    
    [self.icon x_sizeToFit];
    self.icon.centerX = self.line.centerX;
    
    if (!self.dateButton.isHidden) {
        
        self.icon.top = self.dateButton.bottom + 44;
    } else {
        
        self.icon.top = 34;
    }
    
    [self.timeLabel x_sizeToFit];
    self.timeLabel.right = self.icon.left - 3;
    self.timeLabel.centerY = self.icon.centerY;
    if (!self.dateButton.isHidden) {

        self.msgBoxImageView.frame = CGRectMake(self.icon.right + 5, self.dateButton.bottom + 20, SCREEN_WIDTH - SCALED(100), 62);
    } else {
        
        self.msgBoxImageView.frame = CGRectMake(self.icon.right + 5, 10, SCREEN_WIDTH - SCALED(100), 62);
    }
    
    [self.accessoryImageView x_sizeToFit];
    self.accessoryImageView.centerY = self.msgBoxImageView.height / 2;
    self.accessoryImageView.right = self.msgBoxImageView.width - 12;
    
    [self.abnormalLoginView x_sizeToFit];
    self.abnormalLoginView.centerY = self.msgBoxImageView.height / 2;
    self.abnormalLoginView.right = self.accessoryImageView.left - 8;
    
    [self.deviceImageView x_sizeToFit];
    self.deviceImageView.centerX = 40;
    self.deviceImageView.centerY = self.msgBoxImageView.height / 2;
    
    [self.appLabel x_sizeToFit];
    self.appLabel.left = 32;
    self.appLabel.top = self.msgBoxImageView.height / 2 + 3;
    
    [self.cityLabel x_sizeToFit];
    self.cityLabel.bottom = self.msgBoxImageView.height / 2 - 5;
    self.cityLabel.left = 32;
 
    [self.ipLabel x_sizeToFit];
    self.ipLabel.top = self.msgBoxImageView.height / 2 + 5;
    self.ipLabel.left = self.cityLabel.left;
    
    [self.contentView bringSubviewToFront:self.dateButton];
}

- (void)setTableViewCellItem:(WPLoginHistoryCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    [self.dateButton setTitle:tableViewCellItem.loginDate forState:UIControlStateNormal];
    
    self.deviceImageView.hidden = YES;
    self.ipLabel.hidden = YES;
    
    if (tableViewCellItem.isFirst) {
        
        self.dateButton.hidden = NO;
    } else {
        
        self.dateButton.hidden = YES;
    }
    
    if ([tableViewCellItem.remoteLogin integerValue]) {
        
        self.abnormalLoginView.hidden = NO;
        
        UIImage *bgimage = [UIImage imageNamed:@"messageBox-normal"];
        bgimage = [bgimage stretchableImageByCenter];
        self.msgBoxImageView.image = bgimage;
        
        [self.appLabel setTextColor:RGBCOLOR_HEX(kLabelredColor)];
        [self.cityLabel setTextColor:RGBCOLOR_HEX(kLabelredColor)];
    } else {
        
        self.abnormalLoginView.hidden = YES;
        
        UIImage *bgimage = [UIImage imageNamed:@"messageBox-abnormal"];
        bgimage = [bgimage stretchableImageByCenter];
        self.msgBoxImageView.image = bgimage;
        
        [self.appLabel setTextColor:RGBCOLOR_HEX(kLabelDarkColor)];
        [self.cityLabel setTextColor:RGBCOLOR_HEX(kLabelDarkColor)];
    }
    
    self.timeLabel.text = tableViewCellItem.loginTime;
    
    if ([tableViewCellItem.deviceType isEqualToString:@"pc"]) {
        
        self.deviceImageView.image = [UIImage imageNamed:@"mac"];
    } else {
        
        self.deviceImageView.image = [UIImage imageNamed:@"iphone"];
    }
    self.cityLabel.text = [NSString stringWithFormat:@"【%@】",tableViewCellItem.loginCity];
    
    self.appLabel.text = tableViewCellItem.loginAppName;
    self.ipLabel.text = [NSString stringWithFormat:@"IP: %@", tableViewCellItem.loginIP];
    
    [self setNeedsLayout];
}

@end

