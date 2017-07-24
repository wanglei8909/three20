//
//  WPLoginVerificationComCellItem.m
//  woPass
//
//  Created by htz on 15/8/5.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLoginVerificationComCellItem.h"
#import "WPCityManager.h"
#import "Reachability.h"

@interface WPLoginVerificationComCellItem ()

@end

@implementation WPLoginVerificationComCellItem

- (Class)cellClass {
    return [WPLoginVerificationComCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return 15 + (![gUser.isLoginProtect boolValue] ? 115 : 60);
}

- (NSString *)title {
    return @"常用地点免验证";
}

- (NSString *)subTitle {
    
    return @"最多可设置三个常用地点";
}

- (NSString *)iconName {
    
    return @"iconfont_didian";
}

- (TZBasicCellMarginType)marginType {
    
    return TZBasicCellAllMargin;
}

- (NSArray *)itemsArray {
    
    return [[[WPCityManager alloc] init] cityNameArrayWithCityCodeArrayString:gUser.commonLoginPlace];
}

@end

@interface WPLoginVerificationComCell ()

@end

@implementation WPLoginVerificationComCell

- (UISwitch *)switchAccessoryView {
    
    UISwitch *switchAccessoryView = [super switchAccessoryView];
    [switchAccessoryView setOn:![gUser.isLoginProtect boolValue] animated:YES];
    self.locationVerificationView.userInteractionEnabled = switchAccessoryView.isOn;
    return switchAccessoryView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.switchAccessoryView addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)switchChange:(UISwitch *)comSwitch {
    
    Reachability *reachbility = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reachbility currentReachabilityStatus];
    if (status == NotReachable) {
        
        [comSwitch setOn:!comSwitch.isOn animated:YES];
        [self.viewController showHint:@"网络异常，请重试" hide:1];
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:WPSwitchChangeNotification object:self];
    self.locationVerificationView.userInteractionEnabled = comSwitch.isOn;
}

- (void)setTableViewCellItem:(WPLoginVerificationComCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    
    if (![gUser.isLoginProtect boolValue]) {
        
        self.locationVerificationView.hidden = NO;
    } else {
        
        self.locationVerificationView.hidden = YES;
    }
    [self setNeedsLayout];
}

@end