//
//  WPAdsView.m
//  woPass
//
//  Created by htz on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPAdsView.h"
#import "NIAttributedLabel.h"
#import "JMWhenTapped.h"
#import "WPURLManager.h"


@implementation WPAdsViewCellItem

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"subTitle" : @"subTitle",
             @"title" : @"mainTitle",
             @"imageURL" : @"img",
             @"actionURL" : @"url",
             
             };
}

- (Action)action {

    weaklySelf();
    return ^ {
        
        [BaiduMob logEvent:@"id_coupons" eventLabel:@"home"];
        [WPURLManager openURLWithMainTitle:weakSelf.title urlString:weakSelf.actionURL];
    };
}

@end


@interface WPAdsViewCell ()

@property (nonatomic, strong)UIView *marginView;

@end

@implementation WPAdsViewCell

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.titleLabel.font = XFont(kFontMiddle);
        self.titleLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
    }
    return self;
}

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
    
    if (self.layoutType == WPAdsLayoutDouble) {
        
        self.iconImageView.size = CGSizeMake(SCALED(35), SCALED(30));
        self.iconImageView.top = SCALED(15);
        self.iconImageView.centerX = self.width / 2;
        
        self.titleLabel.bottom = self.bottom - SCALED(10);
        self.titleLabel.centerX = self.width / 2;
        
        self.marginView.frame = CGRectMake(self.width, (self.height - SCALED(60)) / 2, 1, SCALED(60));
    } else if (WPAdsLayoutSingle) {
        
        self.iconImageView.size = CGSizeMake(70, 65);
        self.iconImageView.left = 30;
        self.iconImageView.top = (self.height - self.iconImageView.height) / 2;
        
        self.titleLabel.bottom = self.iconImageView.centerY - 4;
        self.titleLabel.left = self.iconImageView.right + 30;
        
        self.marginView.frame = CGRectMake(self.width, self.height * 0.2 / 2, 1, self.height * 0.8);
    }
    
}

- (void)setItem:(WPAdsViewCellItem *)item {
    
    [super setItem:item];
    
    [self setNeedsLayout];
}

@end

@implementation WPAdsView

- (void)setSudokuCellItemArray:(NSArray *)sudokuCellItemArray {
    [super setSudokuCellItemArray:sudokuCellItemArray];
    
    [self.subviews enumerateObjectsUsingBlock:^(WPAdsViewCell *subView, NSUInteger idx, BOOL *stop) {
        
        subView.layoutType = self.layoutType;
    }];
    
    [self setNeedsLayout];
}

- (Class)viewCellClass {
    return [WPAdsViewCell class];
}

@end
