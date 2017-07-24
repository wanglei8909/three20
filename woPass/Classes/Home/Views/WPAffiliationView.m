//
//  WPAffiliationView.m
//  woPass
//
//  Created by htz on 15/7/31.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPAffiliationView.h"
#import "NIAttributedLabel.h"

@interface WPAffiliationViewModel ()

@end

@implementation WPAffiliationViewModel


@end



@interface WPAffiliationView ()

@property (nonatomic, strong)NIAttributedLabel *phoneTitleLabel;
@property (nonatomic, strong)NIAttributedLabel *phoneNumLabel;
@property (nonatomic, strong)NIAttributedLabel *affilicationTitleLabel;
@property (nonatomic, strong)NIAttributedLabel *affilicationNameLabel;
@property (nonatomic, strong)NIAttributedLabel *phoneCodeTitleLabel;
@property (nonatomic, strong)NIAttributedLabel *phoneCodeLabel;

@end

@implementation WPAffiliationView

- (UILabel *)_phoneTitleLabel {
    if (!_phoneTitleLabel) {
        _phoneTitleLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        
        [self addSubview:_phoneTitleLabel];
    }
    return _phoneTitleLabel;
}

- (UILabel *)phoneNumLabel {
    if (!_phoneNumLabel) {
        _phoneNumLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        
        [self addSubview:_phoneNumLabel];
    }
    return _phoneNumLabel;
}

- (UILabel *)affilicationTitleLabel {
    if (!_affilicationTitleLabel) {
        _affilicationTitleLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        
        [self addSubview:_affilicationTitleLabel];
    }
    return _affilicationTitleLabel;
}

- (UILabel *)affilicationNameLabel {
    if (!_affilicationNameLabel) {
        _affilicationNameLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        
        [self addSubview:_affilicationNameLabel];
    }
    return _affilicationNameLabel;
}

- (UILabel *)phoneCodeTitleLabel {
    if (!_phoneCodeTitleLabel) {
        _phoneCodeTitleLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        
        [self addSubview:_phoneCodeTitleLabel];
    }
    return _phoneCodeTitleLabel;
}

- (UILabel *)phoneCodeLabel {
    if (!_phoneCodeLabel) {
        _phoneCodeLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        
        [self addSubview:_phoneCodeLabel];
    }
    return _phoneCodeLabel;
}

- (instancetype)init {
    if (self = [super init]) {
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

@end
