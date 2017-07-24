//
//  WPLIfeServiceView.m
//  woPass
//
//  Created by htz on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLIfeServiceView.h"
#import "NIAttributedLabel.h"
#import "WPURLManager.h"

@implementation WPLIfeServiceViewCellItem

+ (NSDictionary *)replacedKeyFromPropertyName {
    
    return @{
             @"imageURL" : @"appHomeIcon",
             @"title" : @"appName",
             @"actionURL" : @"appUrl"
             };
}

- (Action)action {

    weaklySelf();
    return ^ {
        [BaiduMob logEvent:@"id_life_serve" eventLabel:weakSelf.title];
        [WPURLManager openURLWithMainTitle:weakSelf.title urlString:weakSelf.actionURL];
    };
}

@end

@interface WPLIfeServiceViewCell ()

@property (nonatomic, strong)UIView *buttomMarginView;

@end

@implementation WPLIfeServiceViewCell

- (UIView *)buttomMarginView {
    if (!_buttomMarginView) {
        _buttomMarginView = [[UIView alloc] init];
        _buttomMarginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:_buttomMarginView];
    }
    return _buttomMarginView;
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.titleLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        self.titleLabel.font = XFont(kFontMiddle);
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.size = CGSizeMake(43, 44);
    self.iconImageView.top = kPadding;
    self.iconImageView.centerX = self.width / 2;
    
    self.titleLabel.top = self.iconImageView.bottom + kPadding;
    self.titleLabel.centerX = self.width / 2;
    
    self.buttomMarginView.frame = CGRectMake(0, self.height, self.width, 1);
}

@end

@implementation WPLIfeServiceView

- (Class)viewCellClass {
    return [WPLIfeServiceViewCell class];
}

@end
