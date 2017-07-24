//
//  WPKeyboardToolBar.m
//  woPass
//
//  Created by htz on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPKeyboardToolBar.h"

@implementation WPKeyboardToolBar

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:RGBCOLOR_HEX(KTextOrangeColor) forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.titleLabel.font = XFont(kFontLarge);
        [self addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (UIButton *)configButton {
    if (!_configButton) {
        
        _configButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_configButton setTitle:@"确定" forState:UIControlStateNormal];
        [_configButton setTitleColor:RGBCOLOR_HEX(KTextOrangeColor) forState:UIControlStateNormal];
        _configButton.titleLabel.font = XFont(kFontLarge);
        [_configButton addTarget:self action:@selector(clickConfigButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_configButton];
    }
    return _configButton;
}

- (instancetype)applyCancelAction:(Action)cancelAction configAction:(Action)configAction {
    self.cancelAction = cancelAction;
    self.configAction = configAction;
    return self;
}

- (void)clickCancelButton {
    
    self.cancelAction();
}

- (void)clickConfigButton {
    
    self.configAction();
}

- (void)layoutSubviews {
    
    [self.cancelButton x_sizeToFit];
    self.cancelButton.left = 14;
    self.cancelButton.height = self.height;
    
    [self.configButton x_sizeToFit];
    self.configButton.right = self.width - 14;
    self.configButton.height = self.height;
}

@end
