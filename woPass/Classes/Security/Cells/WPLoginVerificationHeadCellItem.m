//
//  WPLoginVerificationHeadCellItem.m
//  woPass
//
//  Created by htz on 15/8/5.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLoginVerificationHeadCellItem.h"
#import "Reachability.h"

@interface WPLoginVerificationHeadCellItem ()

@end

@implementation WPLoginVerificationHeadCellItem

- (Class)cellClass {
    return [WPLoginVerificationHeadCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return [super heightForTableView:inTableView];
}

- (NSString *)title {
    
    return @"完全保护";
}

- (NSString *)subTitle {
    
    return @"任何登录都需要手机验证";
}

- (NSString *)iconName {
    
    return @"iconfont_mima";
}

- (TZBasicCellMarginType)marginType {
    
    return TZBasicCellAllMargin;
}

@end

@interface WPLoginVerificationHeadCell ()

@end

@implementation WPLoginVerificationHeadCell

- (UISwitch *)switchAccessoryView {
    
    UISwitch *switchAccessoryView = [super switchAccessoryView];
    [switchAccessoryView setOn:[gUser.isLoginProtect boolValue] animated:YES];
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

- (void)switchChange:(UISwitch *)protectSwitch {
    Reachability *reachbility = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reachbility currentReachabilityStatus];
    if (status == NotReachable) {
        
        [protectSwitch setOn:!protectSwitch.isOn animated:YES];
        [self.viewController showHint:@"网络异常，请重试" hide:1];
        return;
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:WPSwitchChangeNotification object:self];
}

- (void)setTableViewCellItem:(WPLoginVerificationHeadCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
}

@end


