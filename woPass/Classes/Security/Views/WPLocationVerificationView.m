//
//  WPLocationVerificationView.m
//  woPass
//
//  Created by htz on 15/7/10.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLocationVerificationView.h"
#import "NIAttributedLabel.h"
#import "JMWhenTapped.h"
#import "WPComCityViewController.h"
#import "WPCityManager.h"

@interface WPLocationVerificationViewCell ()

@end

@implementation WPLocationVerificationViewCell

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        [self addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}
- (NIAttributedLabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        [self.backgroundImageView addSubview:_titleLable];
    }
    return _titleLable;
}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        [self.backgroundImageView addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (instancetype)init {
    if (self = [super init]) {
    
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1;
        self.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        self.layer.masksToBounds = YES;
        
        weaklySelf();
        [self whenTapped:^{
           
            WPComCityViewController *cityController = [[WPComCityViewController alloc]init];
            __weak WPComCityViewController *weakCity_vc = cityController;
//            cityController.finishBlock = ^(NSDictionary *cityDict) {
//                
//                [[[WPCityManager alloc] init] ChangeCityCodeArrayStringWithCode:[NSString stringWithFormat:@"%@", cityDict[@"id"]] atIndex:self.tag];
//                [[NSNotificationCenter defaultCenter] postNotificationName:WPSelectCityNotification object:@"selectCity"];
//                [weakCity_vc dismiss];
//            };
            [cityController applyFinishedBlock:^(NSArray *cityArray) {
                
                [[[WPCityManager alloc] init] changeCityCodeArrayStringWithCityNameArray:cityArray];
                [[NSNotificationCenter defaultCenter] postNotificationName:WPSelectCityNotification object:@"selectCity"];
                [weakCity_vc dismiss];
            }];
            [weakSelf.viewController presentViewController:cityController animated:YES completion:^{
                
            }];
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundImageView.frame = self.bounds;
    
    
    if ([self.titleLable.text isEqualToString:@""]) {
        
        self.titleLable.width = self.width * 0.4;
        self.titleLable.height = 1;
        self.titleLable.left = 12;
        self.titleLable.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        self.titleLable.top = (self.height - self.titleLable.height) / 2;
    } else {
     
        [self.titleLable x_sizeToFit];
        self.titleLable.width = self.width * 0.6;
        self.titleLable.left = 8;
        self.titleLable.top = (self.height - self.titleLable.height) / 2;
        self.titleLable.backgroundColor = [UIColor clearColor];
    }
    
    [self.iconImageView x_sizeToFit];
    self.iconImageView.right = self.width - 10;
//    self.iconImageView.left = self.titleLable.right + 10;
    self.iconImageView.top = (self.height - self.iconImageView.height) / 2;
    
}

@end

@interface WPLocationVerificationView ()

@end

@implementation WPLocationVerificationView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    __block NSInteger index = 0;
    weaklySelf();
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        
        if ([subView isKindOfClass:[WPLocationVerificationViewCell class]]) {
            
            subView.width = (weakSelf.width - 12 * 3) / 3;
            subView.height = 40;
            subView.left = index * (12 + subView.width);
            index ++;
        }
    }];
}

- (void)setItemsArray:(NSArray *)itemsArray {
    _itemsArray = itemsArray;
    
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        
        if ([subView isKindOfClass:[WPLocationVerificationViewCell class]]) {
            
            [subView removeFromSuperview];
        }
    }];
    
    weaklySelf();
    [itemsArray enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
       
        WPLocationVerificationViewCell *cell = [[WPLocationVerificationViewCell alloc] init];
        cell.titleLable.text = title;
        cell.tag = idx;
        cell.iconImageView.image = [UIImage imageNamed:@"xuanze"];
        [weakSelf addSubview:cell];
    }];
}

- (CGSize)sizeThatFits:(CGSize)size {
    
    return [super sizeThatFits:size];
}

@end
