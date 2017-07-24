//
//  WPLoginedHeaderCellItem.m
//  woPass
//
//  Created by htz on 15/7/14.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLoginedHeaderCellItem.h"
#import "NIAttributedLabel.h"
#import "WPLoginedStatView.h"
#import "UIImageView+WebCache.h"
#import "JMWhenTapped.h"

@interface WPLoginedHeaderCellItem ()

@property (nonatomic, copy)Action upperAction;
@property (nonatomic, copy)Action lowerAction;


@end

@implementation WPLoginedHeaderCellItem

- (Class)cellClass {
    return [WPLoginedHeaderCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return SCREEN_WIDTH * (90 + 65) / 320;
}

- (NSString *)headPortraitName {
    
    return gUser.avatarImg;
}

- (NSString *)realNameImageName {
    
    return @"hui";
}

- (NSString *)title {
    
    return gUser.nickname;
}

- (NSString *)subTitle {
    
    return gUser.maskedMobile;
}

- (NSString *)locationImageName {
    
    return @"lishi";
}

- (NSString *)locationTitle {
    
    return @"登录历史";
}

- (NSString *)locationSubTitle {
    
    return [NSString stringWithFormat:@"上次登录: %@", gUser.lastLoginRegion];
}

- (NSString *)locationAccessoryImageName {
    
    return @"youjiantou-";
}

- (NSString *)abnormalImageName {
    return @"baocuo-loginHistory";
}

- (instancetype)applyUpperAction:(Action)upperClickAction lowerAction:(Action)lowerClickAction {
    
    self.upperAction = upperClickAction;
    self.lowerAction = lowerClickAction;
    
    return self;
}
- (BOOL)showAbnormal {
    
    return [gUser.showShowAbnormal integerValue];
}

@end

@interface WPLoginedHeaderCell ()

@property (nonatomic, strong)UIImageView *upperBKImageView;
@property (nonatomic, strong)UIImageView *headPortraitImageView;
@property (nonatomic, strong)UIImageView *realNameImageView;
@property (nonatomic, strong)NIAttributedLabel *titleLabel;
@property (nonatomic, strong)NIAttributedLabel *subTitleLabel;
@property (nonatomic, strong)UIImageView *accessoryImageView;

@property (nonatomic, strong)UIView *lowerBKView;
@property (nonatomic, strong)UIImageView *locationImageView;
@property (nonatomic, strong)NIAttributedLabel *locationTitleLabel;
@property (nonatomic, strong)NIAttributedLabel *locationSubTitleLabel;
@property (nonatomic, strong)UIImageView *locationAccessoryImageView;
@property (nonatomic, strong)UIImageView *abnormalView;

@end

@implementation WPLoginedHeaderCell

- (UIView *)lowerBKView {
    if (!_lowerBKView) {
        _lowerBKView = [[UIView alloc] init];
        _lowerBKView.backgroundColor = [UIColor whiteColor];
        _lowerBKView.layer.borderWidth = 1;
        _lowerBKView.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        [self.contentView addSubview:_lowerBKView];
    }
    return _lowerBKView;
}

- (UIImageView *)locationImageView {
    if (!_locationImageView) {
        _locationImageView = [[UIImageView alloc] init];
        [self.lowerBKView addSubview:_locationImageView];
    }
    return _locationImageView;
}

- (NIAttributedLabel *)locationTitleLabel {
    if (!_locationTitleLabel) {
        _locationTitleLabel = [NIAttributedLabel labelWithFontSize:kFontLarge color:RGBCOLOR_HEX(kLabelDarkColor)];
        [self.lowerBKView addSubview:_locationTitleLabel];
    }
    return _locationTitleLabel;
}

- (NIAttributedLabel *)locationSubTitleLabel {
    if (!_locationSubTitleLabel) {
        _locationSubTitleLabel = [NIAttributedLabel labelWithFontSize:kFontTiny color:RGBCOLOR_HEX(0x48bd1f)];
        [self.lowerBKView addSubview:_locationSubTitleLabel];
    }
    return _locationSubTitleLabel;
}

- (UIImageView *)locationAccessoryImageView {
    if (!_locationAccessoryImageView) {
        _locationAccessoryImageView = [[UIImageView alloc] init];
        [self.lowerBKView addSubview:_locationAccessoryImageView];
    }
    return _locationAccessoryImageView;
}

- (UIImageView *)abnormalView {
    if (!_abnormalView) {
        _abnormalView = [[UIImageView alloc] init];
        [self.lowerBKView addSubview:_abnormalView];
    }
    return _abnormalView;
}

- (UIImageView *)realNameImageView {
    if (!_realNameImageView) {
        _realNameImageView = [[UIImageView alloc] init];
        [self.upperBKImageView addSubview:_realNameImageView];
    }
    return _realNameImageView;
}

- (UIImageView *)upperBKImageView {
    if (!_upperBKImageView) {
        _upperBKImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bd-6"]];
        [self.contentView addSubview:_upperBKImageView];
    }
    return _upperBKImageView;
}
- (UIImageView *)headPortraitImageView {
    if (!_headPortraitImageView) {
        _headPortraitImageView = [[UIImageView alloc] init];
        _headPortraitImageView.layer.cornerRadius = SCALED(30);
        _headPortraitImageView.layer.masksToBounds = YES;
        _headPortraitImageView.layer.borderWidth = 2;
        _headPortraitImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.upperBKImageView addSubview:_headPortraitImageView];
    }
    return _headPortraitImageView;
}
- (NIAttributedLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:[UIColor whiteColor]];
        [self.upperBKImageView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (NIAttributedLabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:[UIColor whiteColor]];
        [self.upperBKImageView addSubview:_subTitleLabel];
    }
    return _subTitleLabel;
}
- (UIImageView *)accessoryImageView {
    if (!_accessoryImageView) {
        _accessoryImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"youjiantou-"]];
        [self.upperBKImageView addSubview:_accessoryImageView];
    }
    return _accessoryImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.upperBKImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 90 / 320);
    
    self.headPortraitImageView.size = CGSizeMake(SCALED(60), SCALED(60));
    self.headPortraitImageView.top = (self.upperBKImageView.height - self.headPortraitImageView.height) / 2;
    self.headPortraitImageView.left = 20;
    
    [self.titleLabel x_sizeToFit];
    self.titleLabel.left = self.headPortraitImageView.right + 20;
    self.titleLabel.bottom = self.headPortraitImageView.centerY - 5;
    
    self.realNameImageView.size = CGSizeMake(SCALED(15), SCALED(15));
    self.realNameImageView.left = self.titleLabel.right + kPadding;
    self.realNameImageView.centerY = self.titleLabel.centerY;
    
    [self.subTitleLabel x_sizeToFit];
    self.subTitleLabel.left = self.titleLabel.left;
    self.subTitleLabel.top = self.headPortraitImageView.centerY + 5;

    self.accessoryImageView.width = SCALED(10);
    self.accessoryImageView.height = SCALED(20);
    self.accessoryImageView.centerY = self.upperBKImageView.centerY;
    self.accessoryImageView.right = self.upperBKImageView.width - 20;
    
    self.lowerBKView.frame = CGRectMake(0, self.upperBKImageView.bottom, self.contentView.width, self.contentView.height - self.upperBKImageView.height);
    
    self.locationImageView.size = CGSizeMake(SCALED(35), SCALED(35));
    self.locationImageView.left = SCALED(kPadding);
    self.locationImageView.centerY = self.lowerBKView.height / 2;
    
    [self.locationTitleLabel x_sizeToFit];
    self.locationTitleLabel.left = self.locationImageView.right + SCALED(kPadding);
    self.locationTitleLabel.bottom = self.locationImageView.centerY - 3;
    
    [self.locationSubTitleLabel x_sizeToFit];
    self.locationSubTitleLabel.left = self.locationTitleLabel.left;
    self.locationSubTitleLabel.top = self.locationImageView.centerY + 6;
    
    self.locationAccessoryImageView.size = CGSizeMake(SCALED(10), SCALED(20));
    self.locationAccessoryImageView.centerY = self.lowerBKView.height / 2;
    self.locationAccessoryImageView.right = self.lowerBKView.width - 15;
    
    self.abnormalView.size = CGSizeMake(SCALED(21), SCALED(21));
    self.abnormalView.centerY = self.lowerBKView.height / 2;
    self.abnormalView.right = self.accessoryImageView.left - SCALED(14);
}

- (void)setTableViewCellItem:(WPLoginedHeaderCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    self.titleLabel.text = tableViewCellItem.title;
    
    if (tableViewCellItem.subTitle.length == 11) {
        
        self.subTitleLabel.text = [tableViewCellItem.subTitle stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    self.realNameImageView.image = [UIImage imageNamed:tableViewCellItem.realNameImageName];
    self.realNameImageView.hidden = ![gUser.realNameIsauth boolValue];
    
    if (gUser.avatarImgData) {
        
        self.headPortraitImageView.image = [UIImage imageWithData:gUser.avatarImgData];
    } else {
        
        [self.headPortraitImageView sd_setImageWithURL:[NSURL URLWithString:gUser.avatarImg] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    }
    
    self.locationImageView.image = [UIImage imageNamed:tableViewCellItem.locationImageName];
    self.locationTitleLabel.text = tableViewCellItem.locationTitle;
    self.locationSubTitleLabel.text = tableViewCellItem.locationSubTitle;
    self.locationAccessoryImageView.image = [UIImage imageNamed:tableViewCellItem.locationAccessoryImageName];
    
    self.abnormalView.image = [UIImage imageNamed:tableViewCellItem.abnormalImageName];
    
    if (tableViewCellItem.showAbnormal) {
    
        self.abnormalView.hidden = NO;
        [self.locationSubTitleLabel setTextColor:RGBCOLOR_HEX(kLabelredColor)];
    } else {
        
        self.abnormalView.hidden = YES;
        [self.locationSubTitleLabel setTextColor:RGBCOLOR_HEX(KLabelGreenColor)];
    }
    
    [self.lowerBKView whenTapped:^{
       
        CallBlock(tableViewCellItem.lowerAction);
    }];
    
    [self.upperBKImageView whenTapped:^{
       
        CallBlock(tableViewCellItem.upperAction);
    }];
    
    [self setNeedsLayout];
}

@end

