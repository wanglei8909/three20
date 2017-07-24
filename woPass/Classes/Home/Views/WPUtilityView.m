//
//  WPUtilityView.m
//  woPass
//
//  Created by htz on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPUtilityView.h"
#import "NIAttributedLabel.h"
#import "JMWhenTapped.h"
#import "WPURLManager.h"
#import "UIDeviceHardware.h"
#import "UIDevice+IdentifierAddition.h"

@implementation WPUtilityViewCellItem

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
        //weakSelf.actionURL = @"http://test.txz.wohulian.cn/txzApp/u/diandianCredit";
        [WPURLManager openURLWithMainTitle:weakSelf.title urlString:weakSelf.actionURL];
    };
}


@end

@interface WPUtilityViewCell ()

@property (nonatomic, strong)UIView *marginView;

@end

@implementation WPUtilityViewCell

- (UIView *)marginView {
    if (!_marginView) {
        _marginView = [[UIView alloc] init];
        _marginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:_marginView];
    }
    return _marginView;
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.titleLabel.font = XFont(kFontMiddle);
        self.titleLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconImageView.size = CGSizeMake(SCALED(25), SCALED(25));
    self.iconImageView.left = (self.width - self.iconImageView.width) / 2;
    self.iconImageView.top = self.height * 0.2;
    
    self.titleLabel.top = self.height * 0.7;
    self.titleLabel.centerX = self.iconImageView.centerX;
    
    self.marginView.frame = CGRectMake(self.width, (self.height - SCALED(45)) / 2, 1, SCALED(45));
    
}

- (void)setItem:(TZSudokuViewCellItem *)item {
    [super setItem:item];
    
}


@end

@implementation WPUtilityView

- (Class)viewCellClass {
    return [WPUtilityViewCell class];
}

@end
