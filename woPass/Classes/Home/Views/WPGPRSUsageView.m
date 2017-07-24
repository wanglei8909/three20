//
//  WPGPRSUsageView.m
//  woPass
//
//  Created by htz on 15/8/10.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPGPRSUsageView.h"
#import "NIAttributedLabel.h"

@implementation WPGPRSUsageViewCellItem


@end

@interface WPGPRSUsageViewCell ()

@property (nonatomic, strong)UIView *rightMarginView;
@property (nonatomic, strong)UIView *bottomMarginView;

@end

@implementation WPGPRSUsageViewCell

- (UIView *)rightMarginView {
    if (!_rightMarginView) {
        _rightMarginView = [[UIView alloc] init];
        _rightMarginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:_rightMarginView];
    }
    return _rightMarginView;
}

- (UIView *)bottomMarginView {
    if (!_bottomMarginView) {
        _bottomMarginView = [[UIView alloc] init];
        _bottomMarginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:_bottomMarginView];
    }
    return _bottomMarginView;
}

- (NIAttributedLabel *)titleLabel {
    
    NIAttributedLabel *titleLabel = [super titleLabel];
    titleLabel.textColor = RGBCOLOR_HEX(KLabelGreenColor);
    titleLabel.font = XFont(kFontLarge);
    return titleLabel;
}

- (NIAttributedLabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [NIAttributedLabel labelWithFontSize:kFontTiny color:RGBCOLOR_HEX(kLabelDarkColor)];
        [self addSubview:_subtitleLabel];
    }
    return _subtitleLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconImageView.hidden = YES;
    
    [self.titleLabel x_sizeToFit];
    self.titleLabel.centerX = self.width / 2;
    self.titleLabel.top = 0.22 * self.height;
    
    [self.subtitleLabel x_sizeToFit];
    self.subtitleLabel.centerX = self.titleLabel.centerX;
    self.subtitleLabel.bottom = self.height * (1- 0.22);
    
    self.rightMarginView.frame = CGRectMake(self.width, self.height * 0.2 / 2, 1, self.height * 0.8);
    self.bottomMarginView.frame = CGRectMake(0, self.height, self.width, 1);
}

- (void)setItem:(WPGPRSUsageViewCellItem *)item {
    
    [super setItem:item];
    self.subtitleLabel.text = item.subtitle;
}


@end

@implementation WPGPRSUsageView

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (Class)viewCellClass {
    
    return [WPGPRSUsageViewCell class];
}

- (NSInteger)numCol {
    return 3;
}

@end
