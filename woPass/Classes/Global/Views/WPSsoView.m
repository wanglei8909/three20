//
//  WPSsoView.m
//  woPass
//
//  Created by htz on 15/10/13.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPSsoView.h"
#import "NIAttributedLabel.h"
#import "UIImageView+WebCache.h"
#import "JMWhenTapped.h"

@interface WPSsoView ()

@property (nonatomic, strong) UIImageView       *leftAppView;
@property (nonatomic, strong) UIImageView       *centerExchangeView;
@property (nonatomic, strong) UIImageView       *rightAppView;
@property (nonatomic, strong) NIAttributedLabel *leftAppLabel;
@property (nonatomic, strong) NIAttributedLabel *rightAppLabel;
@property (nonatomic, strong) UIView            *centerMarginView;
@property (nonatomic, strong) UIImageView       *avatarView;
@property (nonatomic, strong) NIAttributedLabel *phoneLabel;
@property (nonatomic, strong)NIAttributedLabel *changeAccountLabel;


@end

@implementation WPSsoView


#pragma mark - Constructors and Life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        self.layer.borderWidth = 1;
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}

- (instancetype)initWithContentModel:(id<WPSsoViewAdapterProtocol>)model {
    
    if (self = [self init]) {
        
        [self setContentWithModel:model];
    }
    return self;
}



- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.leftAppView.size    = CGSizeMake(SCALED(62), SCALED(62));
    self.leftAppView.centerX = 0.3 * self.width;
    self.leftAppView.centerY = 0.31 * self.height;
    
    self.centerExchangeView.size    = CGSizeMake(SCALED(20), SCALED(20));
    self.centerExchangeView.centerX = self.width / 2;
    self.centerExchangeView.centerY = self.leftAppView.centerY;
    
    self.rightAppView.size    = CGSizeMake(SCALED(62), SCALED(62));
    //    self.rightAppView.centerX = 0.7 * self.width;
    self.rightAppView.centerX = 0.5 * self.width;
    self.rightAppView.centerY = self.leftAppView.centerY;
    
    self.centerMarginView.size    = CGSizeMake(0.9375 * self.width, 1);
    self.centerMarginView.centerX = self.centerX;
    self.centerMarginView.top     = 0.6875 * self.height;
    
    self.avatarView.size    = CGSizeMake(SCALED(35), SCALED(35));
    self.avatarView.left    = self.centerMarginView.left;
    self.avatarView.centerY = self.height - (self.height - self.centerMarginView.top) / 2;
    self.avatarView.layer.cornerRadius = self.avatarView.width / 2;
    self.avatarView.layer.masksToBounds = YES;
    
    [self.leftAppLabel x_sizeToFit];
    self.leftAppLabel.centerX = self.leftAppView.centerX;
    self.leftAppLabel.centerY = 0.55 * self.height;
    
    [self.rightAppLabel x_sizeToFit];
    self.rightAppLabel.centerX = self.rightAppView.centerX;
    self.rightAppLabel.centerY = self.leftAppLabel.centerY;
    
    [self.phoneLabel x_sizeToFit];
    self.phoneLabel.left    = self.avatarView.right + SCALED(15);
    self.phoneLabel.centerY = self.avatarView.centerY;
    
    [self.changeAccountLabel x_sizeToFit];
    self.changeAccountLabel.centerY = self.phoneLabel.centerY;
    self.changeAccountLabel.right = self.width - kPadding;
    
}





#pragma mark - Private Method

- (void)setup {
    
    self.leftAppView = [[UIImageView alloc] init];
    self.leftAppView.layer.borderWidth = 1;
    self.leftAppView.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
    self.leftAppView.layer.cornerRadius = 10;
    self.leftAppView.layer.masksToBounds = YES;
    self.leftAppView.hidden = YES;
    [self addSubview:self.leftAppView];
    
    self.centerExchangeView = [[UIImageView alloc] init];
    self.centerExchangeView.hidden = YES;
    [self addSubview:self.centerExchangeView];
    
    self.rightAppView = [[UIImageView alloc] init];
    self.rightAppView.layer.borderWidth = 1;
    self.rightAppView.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
    self.rightAppView.layer.cornerRadius = 10;
    self.rightAppView.layer.masksToBounds = YES;
    [self addSubview:self.rightAppView];
    
    self.avatarView = [[UIImageView alloc] init];
    [self addSubview:self.avatarView];
    
    self.leftAppLabel = [NIAttributedLabel labelWithFontSize:kFontTiny color:RGBCOLOR_HEX(kLabelDarkColor)];
    self.leftAppLabel.hidden = YES;
    [self addSubview:self.leftAppLabel];
    
    self.rightAppLabel = [NIAttributedLabel labelWithFontSize:kFontTiny color:RGBCOLOR_HEX(kLabelDarkColor)];
    [self addSubview:self.rightAppLabel];
    
    self.phoneLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
    [self addSubview:self.phoneLabel];
    
    self.centerMarginView = [[UIView alloc] init];
    self.centerMarginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
    [self addSubview:self.centerMarginView];
    
    self.changeAccountLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(KTextOrangeColor)];
    self.changeAccountLabel.text = @"切换帐号";
    weaklySelf();
    [self.changeAccountLabel whenTapped:^{
        
        CallBlock(weakSelf.changeAccountLabelClick);
    }];
    [self addSubview:self.changeAccountLabel];
    
}



#pragma mark - Event Reponse







#pragma mark - Delegate









#pragma mark - Getter and Setter







#pragma mark - Public

- (void)setContentWithModel:(id<WPSsoViewAdapterProtocol>)model {
    
    UIImage *placeHolderImage = [UIImage imageNamed:@"iconfont-morentu"];
    
    [self.rightAppView sd_setImageWithURL:[NSURL URLWithString:[model rightAppImageSrc]] placeholderImage:placeHolderImage];
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:[model avartaImageSrc]] placeholderImage:placeHolderImage];
    
    self.leftAppView.image        = [UIImage imageNamed:[model leftAppImageSrc]];
    self.centerExchangeView.image = [UIImage imageNamed:[model centerImageSrc]];
    self.leftAppLabel.text        = [model leftAppName];
    self.rightAppLabel.text       = [model rightAppName];
    self.phoneLabel.text          = [model phoneNum];
    
    [self setNeedsLayout];
}

- (instancetype)applyChangeAccountLabelCick:(WPChangeAccountLabelClick)click {
    
    self.changeAccountLabelClick = click;
    return self;
}

@end
