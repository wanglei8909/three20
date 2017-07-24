//
//  WPLoginedStatView.m
//  woPass
//
//  Created by htz on 15/7/14.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLoginedStatView.h"
#import "NIAttributedLabel.h"

@implementation WPLoginedStatViewCellItem

@end

@implementation WPLoginedStatViewCell

- (void)layoutSubviews {
    [super layoutSubviews];

    self.titleLabel.centerY = self.centerY;
    self.titleLabel.left = 0.16 * self.width;
    
    self.iconImageView.centerY = self.centerY;
    self.iconImageView.left = self.titleLabel.right + 0.16 * self.width;
    
}


@end

@interface WPLoginedStatView ()

@property (nonatomic, strong)UIView *middleMarginView;
@property (nonatomic, strong)UIView *bottomMarginView;


@end

@implementation WPLoginedStatView

- (UIView *)bottomMarginView {
    if (!_bottomMarginView) {
        
        _bottomMarginView = [[UIView alloc] init];
        _bottomMarginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:_bottomMarginView];
    }
    return _bottomMarginView;
}
- (UIView *)middleMarginView {
    if (!_middleMarginView) {
        
        _middleMarginView = [[UIView alloc] init];
        _middleMarginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:_middleMarginView];
    }
    return _middleMarginView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.middleMarginView.frame = CGRectMake(self.centerX, 0.2 * self.height / 2, 1, self.height * 0.8);
    self.bottomMarginView.frame = CGRectMake(0, self.height, self.width, 1);

}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (Class)viewCellClass {
    return [WPLoginedStatViewCell class];
}

@end
