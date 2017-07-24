//
//  WPRealNameVerifcationView.m
//  woPass
//
//  Created by htz on 15/7/13.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPRealNameVerifcationView.h"
#import "WPTextField.h"

@interface WPRealNameVerifcationView () <UITextFieldDelegate>



@end

@implementation WPRealNameVerifcationView

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder beginEdite:(void (^)(void))beginEditeAction {
    if (self = [super init]) {
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1;
        self.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        self.layer.masksToBounds = YES;
        
        self.title = title;
        self.placeHolder = placeholder;
        
        self.beginEditeAction = beginEditeAction;
    }
    return self;
}

- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [[UIButton alloc] init];
        [_titleButton setTitleColor:RGBCOLOR_HEX(kLabelDarkColor) forState:UIControlStateNormal];
        _titleButton.titleLabel.font = XFont(kFontMiddle);
        _titleButton.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
        _titleButton.userInteractionEnabled = NO;
        [self addSubview:_titleButton];
    }
    return _titleButton;
}
- (WPTextField *)inputTextField {
    if (!_inputTextField) {
        _inputTextField = [WPTextField textFieldWithPlaceholder:self.placeHolder];
        _inputTextField.layer.borderWidth = 0;
        _inputTextField.layer.cornerRadius = 0;
        _inputTextField.backgroundColor = [UIColor whiteColor];
        _inputTextField.delegate = self;
        [self addSubview:_inputTextField];
    }
    return _inputTextField;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleButton.frame = CGRectMake(0, 0, 0.3 * self.width, self.height);
    self.inputTextField.frame = CGRectMake(self.titleButton.right, 0, self.width - self.titleButton.width, self.height);
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.titleButton setTitle:title forState:UIControlStateNormal];
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    
    _placeHolder = placeHolder;
    NSAttributedString *attPlaceholder = [[NSAttributedString alloc] initWithString:_placeHolder attributes:@{
                                                                                                             NSFontAttributeName : XFont(kFontLarge),
                                                                                                             NSForegroundColorAttributeName : RGBCOLOR_HEX(kPlaceHolderColor)}];
    self.inputTextField.attributedPlaceholder = attPlaceholder;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (self.beginEditeAction) {
        
        self.beginEditeAction();
    }
}

@end
