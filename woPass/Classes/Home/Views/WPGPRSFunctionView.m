//
//  WPGPRSFunctionView.m
//  woPass
//
//  Created by htz on 15/9/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPGPRSFunctionView.h"
#import "NIAttributedLabel.h"

@implementation WPGPRSFunctionViewCellItem


@end

@implementation WPGPRSFunctionViewCell

- (NIAttributedLabel *)subTitleLabel {
    if (!_subTitleLabel) {
        
        _subTitleLabel = [[NIAttributedLabel alloc] init];
        [self addSubview:_subTitleLabel];
    }
    return _subTitleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1;
        self.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        
        self.titleLabel.font = XFont(kFontTiny);
        self.subTitleLabel.font = XFont(kFontTiny);
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.subTitleLabel x_sizeToFit];
    
    self.iconImageView.size = CGSizeMake(SCALED(35), SCALED(35));
    self.iconImageView.centerY = self.height / 2;
    self.iconImageView.left = SCALED(7);
    
    self.titleLabel.centerY = self.iconImageView.centerY;
    self.titleLabel.left = self.iconImageView.right + SCALED(5);
    
    self.subTitleLabel.left = self.titleLabel.centerX;
    self.subTitleLabel.top = self.titleLabel.bottom + SCALED(2);
}

- (void)setItem:(WPGPRSFunctionViewCellItem *)item {
    [super setItem:item];
    self.subTitleLabel.text = item.subTitle;
    
    self.subTitleLabel.textColor = item.labelColor;
    self.titleLabel.textColor = item.labelColor;
    
    [self setNeedsLayout];
}

@end

@implementation WPGPRSFunctionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.veritcalPadding = 10;
        self.horizontalPadding = 10;
    }
    
    return self;
}


- (Class)viewCellClass {
    
    return [WPGPRSFunctionViewCell class];
}

@end
