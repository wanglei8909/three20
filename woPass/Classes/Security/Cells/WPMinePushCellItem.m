//
//  WPMinePushCellItem.m
//  woPass
//
//  Created by htz on 15/11/2.
//  Copyright © 2015年 unisk. All rights reserved.
//


#import "WPMinePushCellItem.h"
#import "NIAttributedLabel.h"

@interface WPMinePushCellItem ()

@end

@implementation WPMinePushCellItem

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.iconName = @"mine_push";
        self.title = @"推送开关";
        self.accessoryName = @"youjiantou-";
    }
    return self;
}

- (Class)cellClass {
    return [WPMinePushCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    
    return 45;
}

- (NSString *)subTitle {
    
    NSString *result = nil;

    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.999 ) {
        
        if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
            
            result = @"已开启";
        } else {
            
            result = @"已关闭";
        }
    } else {
        
        
        if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes] == UIRemoteNotificationTypeNone) {
            
            result = @"已关闭";
        } else {
            
            result = @"已开启";
        }
    }
    return result;
}

@end

@interface WPMinePushCell ()

@property (nonatomic, strong)NIAttributedLabel *subTitleLabel;
@property (nonatomic, strong)UIView *bottomMarginView;

@end

@implementation WPMinePushCell

- (NIAttributedLabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [NIAttributedLabel labelWithFontSize:kFontLarge color:RGBCOLOR_HEX(kDisableTitleColor)];
        [self.contentView addSubview:_subTitleLabel];
        
    }
    return _subTitleLabel;
}

- (UIView *)bottomMarginView {
    if (!_bottomMarginView) {
        _bottomMarginView = [[UIView alloc] init];
        _bottomMarginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:_bottomMarginView];
    }
    return _bottomMarginView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.subTitleLabel x_sizeToFit];
    self.subTitleLabel.centerY = self.contentView.height / 2;
    self.subTitleLabel.right = self.contentView.width - 10;
    
    self.bottomMarginView.frame = CGRectMake(0, self.contentView.height, self.contentView.width, 1);
}

- (void)setTableViewCellItem:(WPMinePushCellItem *)tableViewCellItem {
    
    [super setTableViewCellItem:tableViewCellItem];
    self.accessoryImageView.hidden = YES;
    self.subTitleLabel.text = tableViewCellItem.subTitle;
    
    [self setNeedsLayout];
}

@end


