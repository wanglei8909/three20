//
//  WPLockingAccountCellItem.m
//  woPass
//
//  Created by htz on 15/7/10.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLockingAccountCellItem.h"
#import "NIAttributedLabel.h"
#import "WPTimerManager.h"

@implementation WPLockingAccountCellItem 


- (Class)cellClass {
    return [WPLockingAccountCell class];
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return 110;
}

- (NSString *)iconName {
    
    return @"iconfont_mima";
}

@end

@interface WPLockingAccountCell () <UIAlertViewDelegate>

@end

@implementation WPLockingAccountCell

- (UISwitch *)switchAccessoryView {
    if (!_switchAccessoryView) {
        _switchAccessoryView = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 55, 30)];
        _switchAccessoryView.onTintColor = RGBCOLOR_HEX(KTextOrangeColor);
        [_switchAccessoryView addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_switchAccessoryView];
    }
    
    [_switchAccessoryView setOn:![gUser.thirdLogin integerValue] animated:YES];
    
    return _switchAccessoryView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.headTitleLabel.width = self.contentView.width - 50;
    self.headTitleLabel.numberOfLines = 0;
    self.headTitleLabel.height = 30;
    self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(60, 0, 0, 0));
    self.switchAccessoryView.right = self.contentView.right - 10;
    self.switchAccessoryView.top = (self.contentView.height - self.switchAccessoryView.height) / 2;
    
    self.iconImageView.top = (self.contentView.height - self.iconImageView.height) / 2;
    self.titleLabel.top = (self.contentView.height - self.titleLabel.height) / 2;
}

- (void)switchChange:(UISwitch *)thriAuthSwitch {
    
    NSLog(@"%@", gUser.thirdLogin);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"为了您的安全，需要进行实名认证才能完成此操作" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    WPTimerManager *timerManager = [WPTimerManager sharedManager];
    if ([timerManager isTimeOutForID:@"realName"]) {
        
        [timerManager removeTimerForID:@"realName"];
        [alertView show];
    } else {
        
        [self excuteChange];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    weaklySelf();
    if (buttonIndex == 0) {
        
        [self.switchAccessoryView setOn:![gUser.thirdLogin integerValue] animated:YES];
    } else if (buttonIndex == 1) {
        
        WPTimerManager *timerManager = [WPTimerManager sharedManager];
        [self fetchVerificationComplete:^{
            [timerManager registerTimerForID:@"realName" timeInterval:1800];
            [weakSelf excuteChange];
        }];
    }
}

- (void)fetchVerificationComplete:(void (^)(void))complete {
    
    if ([gUser.realNameIsauth integerValue]) {
    
        [@"WP://WPRealNameVerificationViewController" openWithQuery:@{@"completeAction": ^(id vc){
            
            [vc dismiss];
            CallBlock(complete);
        }}];
    } else {
        
        [@"WP://realNameAuthentication_vc" openWithQuery:@{@"showRed": @(0) ,@"completeAction": ^(id vc){
            
            [vc dismiss];
            [BaiduMob logEvent:@"id_account_lock" eventLabel:@"lock_realname"];
            CallBlock(complete);
        }}];
    }
}

- (void)excuteChange {
    if ([gUser.thirdLogin integerValue]) {
        
        [BaiduMob logEvent:@"id_account_lock" eventLabel:@"lock"];
    } else {
        
        [BaiduMob logEvent:@"id_account_lock" eventLabel:@"unlock"];
    }
    
    weaklySelf();
    [self.viewController showLoading:YES];
    [RequestManeger POST:@"/u/modifyLockPartner" parameters:@{
                                                              @"thirdLogin" : @(![gUser.thirdLogin boolValue] ? 1 : 0)
                                                              } complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        [weakSelf.viewController hideLoading:YES];
        [weakSelf.viewController showHint:msg hide:1];
        if (!msg) {
            
            gUser.thirdLogin = [NSString stringWithFormat:@"%d", ![gUser.thirdLogin boolValue] ? 1 : 0];
            [weakSelf.viewController showHint:[gUser.thirdLogin boolValue] ? @"解锁成功" : @"锁定成功" hide:1];
        } else {
            
            [weakSelf.switchAccessoryView setOn:![gUser.thirdLogin boolValue] animated:YES];
        }
    })];
}

- (void)setTableViewCellItem:(WPLockingAccountCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
}


@end


