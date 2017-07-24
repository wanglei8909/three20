//
//  WPSecurityLevelView.m
//  woPass
//
//  Created by htz on 15/7/8.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPSecurityLevelView.h"
#import "NIAttributedLabel.h"

@implementation WPSecurityLevelViewCellItem


@end

@interface WPSecurityLevelViewCell ()

@property (nonatomic, strong)UIView *marginView;

@end
@implementation WPSecurityLevelViewCell

- (UIView *)marginView {
    if (!_marginView) {
        _marginView = [[UIView alloc] init];
        _marginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:_marginView];
    }
    return _marginView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.iconImageView x_sizeToFit];
    self.iconImageView.top = 10;
    self.iconImageView.centerX = self.width / 2;
    
    [self.titleLabel x_sizeToFit];
    self.titleLabel.centerX = self.width / 2;
    self.titleLabel.top = self.iconImageView.bottom + 5;

    self.marginView.frame = CGRectMake(self.width, self.height * 0.2 / 2, 1, self.height * 0.8);
}

@end

@implementation WPSecurityLevelView

- (Class)viewCellClass {
    
    return [WPSecurityLevelViewCell class];
}

@end
