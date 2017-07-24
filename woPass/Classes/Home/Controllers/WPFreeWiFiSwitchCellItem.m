//
//  WPFreeWiFiSwitchCellItem.m
//  woPass
//
//  Created by htz on 15/8/2.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPFreeWiFiSwitchCellItem.h"
#import "NIAttributedLabel.h"

@interface WPFreeWiFiSwitchCellItem ()

@end

@implementation WPFreeWiFiSwitchCellItem

- (Class)cellClass {
    return [WPFreeWiFiSwitchCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return 50;
}

- (NSString *)iconName {
    
    return @"iconfont-wifi-1-";
}

- (NSString *)title {
    
    return @"免费上网";
}

- (instancetype)applySwitchChangeAction:(SwitchChangeAction)switchChange {
    
    self.switchChangeAction = switchChange;
    return self;
}

@end

@interface WPFreeWiFiSwitchCell ()

@end

@implementation WPFreeWiFiSwitchCell

- (UISwitch *)wifiSwitch {
    if (!_wifiSwitch) {
        _wifiSwitch = [[UISwitch alloc] init];
        _wifiSwitch.onTintColor = RGBCOLOR_HEX(KTextOrangeColor);
        [_wifiSwitch setOn:[gUser.freeWifiIsAvaliable boolValue] animated:YES];
        [_wifiSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_wifiSwitch];
    }
    return _wifiSwitch;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.selectionStyle  = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.left = 15;
    self.titleLabel.left = self.iconImageView.right + 20;
    
    [self.wifiSwitch x_sizeToFit];
    self.wifiSwitch.right = SCREEN_WIDTH - 20;
    self.wifiSwitch.centerY = self.contentView.height / 2;
}

- (void)setTableViewCellItem:(WPFreeWiFiSwitchCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    self.switchChangeAction = tableViewCellItem.switchChangeAction;
    
}

- (void)switchChange:(UISwitch *)wifiSwitch {
    
    self.switchChangeAction(wifiSwitch, wifiSwitch.isOn);
}

@end
