//
//  WPAppAlertView.m
//  woPass
//
//  Created by htz on 15/7/27.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPAppAlertView.h"
#import "NIAttributedLabel.h"

@interface WPAppAlertView ()

@property (nonatomic, strong)UIButton *cancelButton;
@property (nonatomic, strong)UIButton *configButton;
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)NIAttributedLabel *titleLabel;
@property (nonatomic, strong)NIAttributedLabel *subTitleLabel;
@property (nonatomic, strong)UIView *margin1;
@property (nonatomic, strong)UIView *margin2;


@end

@implementation WPAppAlertView

- (UIView *)margin1 {
    if (!_margin1) {
        _margin1 = [[UIView alloc] init];
        _margin1.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self.backView addSubview:_margin1];
    }
    return _margin1;
}

- (UIView *)margin2 {
    if (!_margin2) {
        _margin2 = [[UIView alloc] init];
        _margin2.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self.backView addSubview:_margin2];
    }
    return _margin2;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitleColor:RGBCOLOR_HEX(KTextOrangeColor) forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = XFont(kFontLarge);
        
        [self.backView addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (UIButton *)configButton {
    if (!_configButton) {
        _configButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_configButton setTitle:@"确定" forState:UIControlStateNormal];
        [_configButton setTitleColor:RGBCOLOR_HEX(KTextOrangeColor) forState:UIControlStateNormal];
        [_configButton addTarget:self action:@selector(clickconfigButton) forControlEvents:UIControlEventTouchUpInside];
        _configButton.titleLabel.font = XFont(kFontLarge);
        
        [self.backView addSubview:_configButton];
    }
    return _configButton;
}

- (NIAttributedLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [NIAttributedLabel labelWithFontSize:kFontLarge color:RGBCOLOR_HEX(kLabelDarkColor)];
        _titleLabel.text = @"提示";
        [self.backView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (NIAttributedLabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [NIAttributedLabel labelWithFontSize:kFontLarge color:RGBCOLOR_HEX(kLabelDarkColor)];
        _subTitleLabel.text = @"确定解绑此应用?";
        [self.backView addSubview:_subTitleLabel];
    }
    return _subTitleLabel;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10;
        [self addSubview:_backView];
    }
    return _backView;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.alpha = 0;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title {
    
    if (self = [self init]) {
        
        self.subTitleLabel.text = title;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.backView.size = CGSizeMake(210, 110);
    self.backView.centerX = self.width / 2;
    self.backView.centerY = self.height / 3;
    
    self.cancelButton.height = self.backView.height / 2.5;
    self.cancelButton.width = self.backView.width / 2;
    self.cancelButton.bottom = self.backView.height;
    self.cancelButton.left = 0;
    
    
    self.configButton.height = self.backView.height / 2.5;
    self.configButton.width = self.backView.width / 2;
    self.configButton.bottom = self.backView.height;
    self.configButton.left = self.backView.width / 2;
    
    [self.titleLabel x_sizeToFit];
    self.titleLabel.top = 12;
    self.titleLabel.centerX = self.backView.width / 2;
    
    [self.subTitleLabel x_sizeToFit];
    self.subTitleLabel.top = self.titleLabel.bottom + 12;
    self.subTitleLabel.centerX = self.backView.width / 2;
    
    self.margin1.frame = CGRectMake(0, self.cancelButton.top, self.backView.width, 1);
    self.margin2.frame = CGRectMake(self.backView.width / 2, self.cancelButton.top, 1, self.cancelButton.height);
}

- (void)clickCancelButton {
    
    if ([self.delegate respondsToSelector:@selector(appAlertViewCancelButtonClick)]) {
        
        [self.delegate appAlertViewCancelButtonClick];
    }
}

- (void)clickconfigButton {
    
    [self.delegate appAlertViewConfigButtonClick];
}



@end
