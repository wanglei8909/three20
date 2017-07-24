//
//  WPSegementController.m
//  woPass
//
//  Created by htz on 15/7/12.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPSegementController.h"
#import "NIAttributedLabel.h"

typedef NS_ENUM(NSUInteger, WPSegementButtonType) {
    WPSegementButtonFirst,
    WPSegementButtonSecond
};

@interface WPSegementController ()

@property (nonatomic, strong)UIImageView *backgroundImageView;
@property (nonatomic, strong)UIButton *firstButton;
@property (nonatomic, strong)UIButton *secondButton;
@property (nonatomic, strong)UIView *centerMargin;
@property (nonatomic, strong)UIView *bottomMargin;
@property (nonatomic, strong)UIView *slider;

@end

@implementation WPSegementController

- (UIView *)centerMargin {
    if (!_centerMargin) {
        _centerMargin = [[UIView alloc] init];
        _centerMargin.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:_centerMargin];
    }
    return _centerMargin;
}

- (UIView *)bottomMargin {
    if (!_bottomMargin) {
        _bottomMargin = [[UIView alloc] init];
        _bottomMargin.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:_bottomMargin];
    }
    return _bottomMargin;
}

- (UIView *)slider {
    if (!_slider) {
        _slider = [[UIView alloc] init];
        _slider.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
        _slider.left = 15;
        [self addSubview:_slider];
    }
    return _slider;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.backgroundColor = [UIColor whiteColor];
        _backgroundImageView.userInteractionEnabled = YES;
        [self addSubview:_backgroundImageView];
    }
    
    return _backgroundImageView;
}


- (UIButton *)firstButton {
    if (!_firstButton) {
        _firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_firstButton setTitle:@"我的应用" forState:UIControlStateNormal];
        [_firstButton setTitleColor:RGBCOLOR_HEX(kLabelDarkColor) forState:UIControlStateNormal];
        [_firstButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _firstButton.tag = WPSegementButtonFirst;
        _firstButton.titleLabel.font = XFont(15);
        _firstButton.selected = YES;
        [_firstButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchDown];
        [self.backgroundImageView addSubview:_firstButton];
    }
    return _firstButton;
}

- (UIButton *)secondButton {
    if (!_secondButton) {
        _secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_secondButton setTitle:@"热门应用" forState:UIControlStateNormal];
        [_secondButton setTitleColor:RGBCOLOR_HEX(kLabelDarkColor) forState:UIControlStateNormal];
        [_secondButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _secondButton.tag = WPSegementButtonSecond;
        _secondButton.titleLabel.font = XFont(15);
        [_secondButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchDown];
        _secondButton.selected = NO;
        [self.backgroundImageView addSubview:_secondButton];
    }
    return _secondButton;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self clickedButton:self.firstButton];
        self.layer.cornerRadius = 5;
        self.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        self.layer.borderWidth = 1;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundImageView.frame = self.bounds;
    
    self.firstButton.frame = self.bounds;
    self.firstButton.width = self.width / 2;
    
    self.secondButton.frame = self.firstButton.frame;
    self.secondButton.left = self.firstButton.right;
    
    self.centerMargin.width = 1;
    self.centerMargin.height = self.height * 0.8;
    self.centerMargin.left = self.width / 2;
    self.centerMargin.centerY = self.height / 2;
    
    self.bottomMargin.frame = CGRectMake(0, self.height, self.width, 1);
    
    self.slider.width = self.width / 2.5;
    self.slider.height = 3;
    self.slider.top = self.height - self.slider.height;
    
}

- (void)clickedButton:(UIButton *)button {
    
    NSLog(@"%@", button);
    
    CGFloat delta = self.width / 2;
    
    switch (button.tag) {
        case WPSegementButtonFirst:
            
            button.selected = YES;
            button.userInteractionEnabled = NO;
            self.secondButton.selected = NO;
            self.secondButton.userInteractionEnabled = YES;
            delta = - delta;
            
            [self.delegate WPSegementController:self FirstButtonDidClicked:button];
            
            
            break;
            
        case WPSegementButtonSecond:
            
            button.selected = YES;
            button.userInteractionEnabled = NO;
            self.firstButton.selected = NO;
            self.firstButton.userInteractionEnabled = YES;
            delta = delta;
    
            [self.delegate WPSegementController:self secondButtonDidClicked:button];
            
            break;
    }
    
    weaklySelf();
    [UIView animateWithDuration:0.3 animations:^{
        
        weakSelf.slider.left += delta;
    }];
}


@end
