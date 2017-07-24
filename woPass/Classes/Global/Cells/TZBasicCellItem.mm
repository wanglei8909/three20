//
//  TZBasicCellItem.m
//  woPass
//
//  Created by htz on 15/7/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//


#import "TZBasicCellItem.h"
#import "NIAttributedLabel.h"

#define kBlankPadding 44

@interface TZBasicCellItem ()

@end

@implementation TZBasicCellItem

- (instancetype)init {
    if (self = [super init]) {
     
        self.marginType = TZBasicCellMiddleMargin;
    }
    return self;
}

- (Class)cellClass {
    return [TZBasicCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return self.headTitle ? 88 : 44;
}

@end

@interface TZBasicCell ()

@property (nonatomic, strong)UIView *topMarginView;
@property (nonatomic, strong)UIView *bottomMarginView;

@end

@implementation TZBasicCell

- (UIView *)topMarginView {
    if (!_topMarginView) {
        _topMarginView = [[UIView alloc] init];
        _topMarginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self.contentView addSubview:_topMarginView];
    }
    return _topMarginView;
}

- (UIView *)bottomMarginView {
    if (!_bottomMarginView) {
        _bottomMarginView = [[UIView alloc] init];
        _bottomMarginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:_bottomMarginView];
    }
    return _bottomMarginView;
}

- (NIAttributedLabel *)headTitleLabel {
    if (!_headTitleLabel) {
        _headTitleLabel = [NIAttributedLabel labelWithFontSize:kFontTiny color:RGBCOLOR_HEX(kLabelWeakColor)];
        [self addSubview:_headTitleLabel];
    }
    return _headTitleLabel;
}
- (NIAttributedLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}
- (UIImageView *)accessoryImageView {
    if (!_accessoryImageView) {
        _accessoryImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_accessoryImageView];
    }
    return _accessoryImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = RGBCOLOR_HEX(0xffffff);
        self.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.headTitleLabel x_sizeToFit];
    if (self.headTitleLabel.isHidden) {
        
        self.contentView.frame = self.bounds;
    } else {
        
        self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(kBlankPadding, 0, 0, 0));
    }
    self.headTitleLabel.top = 20;
    self.headTitleLabel.left = 10;
    
    [self.iconImageView x_sizeToFit];
    self.iconImageView.left = self.headTitleLabel.left;
    self.iconImageView.centerY = self.contentView.height / 2;
    
    [self.titleLabel x_sizeToFit];
    self.titleLabel.center = self.iconImageView.center;
    self.titleLabel.left = self.iconImageView.right + 10;
    
    [self.accessoryImageView x_sizeToFit];
    self.accessoryImageView.right = self.width - 10;
    self.accessoryImageView.centerY = self.contentView.height / 2;

    switch (((TZBasicCellItem *)self.tableViewCellItem).marginType) {
        case TZBasicCellMiddleMargin:
            self.topMarginView.frame = CGRectMake(self.iconImageView.right, 0, self.contentView.width - self.iconImageView.right , 1);
            self.bottomMarginView.frame = CGRectMake(0, 0, 0, 0);
            break;
        case TZBasicCellTopMargin:
            self.topMarginView.frame = CGRectMake(0, 0, self.contentView.width, 1);
            self.bottomMarginView.frame = CGRectMake(0, 0, 0, 0);            break;
        case TZBasicCellBottomMargin:
            self.topMarginView.frame = CGRectMake(self.iconImageView.right, 0, self.contentView.width - self.iconImageView.right , 1);
            self.bottomMarginView.frame = CGRectMake(0, self.height, self.contentView.width, 1);
            break;
        case TZBasicCellAllMargin:
            self.topMarginView.frame = CGRectMake(0, 0, self.contentView.width, 1);
            self.bottomMarginView.frame = CGRectMake(0, self.height, self.contentView.width, 1);
            break;
    }

}

- (void)setTableViewCellItem:(TZBasicCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    
    self.headTitleLabel.text = tableViewCellItem.headTitle;
    self.titleLabel.text = tableViewCellItem.title;
    self.iconImageView.image = [UIImage imageNamed:tableViewCellItem.iconName];
    self.accessoryImageView.image = [UIImage imageNamed:tableViewCellItem.accessoryName];
    
    if (!tableViewCellItem.headTitle) {
        self.headTitleLabel.hidden = YES;
    } else {
        self.headTitleLabel.hidden  = NO;
    }
    
    if (tableViewCellItem.accessoryName) {
        self.accessoryImageView.hidden = NO;
    } else {
        self.accessoryImageView.hidden = YES;
    }
    
    [self setNeedsLayout];
}

@end