//
//  WPLifeServiceCellItem.m
//  woPass
//
//  Created by htz on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLifeServiceCellItem.h"
#import "NIAttributedLabel.h"

@interface WPLifeServiceCellItem ()

@end

@implementation WPLifeServiceCellItem

- (Class)cellClass {
    return [WPLifeServiceCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return self.lifeServiceViewItemArray.count ? (130 * ((self.lifeServiceViewItemArray.count - 1) / self.numCol + 1) + kPadding) : 0;
}

- (NSString *)title {
    return @"生活服务";
}

- (NSInteger)numCol {
    
    return 4;
}

- (void)setLifeServiceViewItemArray:(NSArray *)lifeServiceViewItemArray {
    
    NSInteger showLength = 8;
    NSMutableArray *array = [lifeServiceViewItemArray mutableCopy];
    if (array.count > showLength) {
        
        [array removeObjectsInRange:NSMakeRange(showLength, array.count - showLength)];
    }
    _lifeServiceViewItemArray = [array copy];
}

@end

@interface WPLifeServiceCell ()

@property (nonatomic, strong)UIView *topMarginView;
@property (nonatomic, strong)UIView *bottomMarginView;
@property (nonatomic, strong)UIView *middleMarginView;

@end

@implementation WPLifeServiceCell

- (UIButton *)accessoryButton {
    if (!_accessoryButton) {
        _accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_accessoryButton setImage:[UIImage imageNamed:@"youjiantou-"] forState:UIControlStateNormal];
        [self.contentView addSubview:_accessoryButton];
    }
    return _accessoryButton;
}

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
        [self.contentView addSubview:_bottomMarginView];
    }
    return _bottomMarginView;
}

- (UIView *)middleMarginView {
    if (!_middleMarginView) {
        _middleMarginView = [[UIView alloc] init];
        _middleMarginView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
        [self.contentView addSubview:_middleMarginView];
    }
    return _middleMarginView;
}

- (NIAttributedLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [NIAttributedLabel labelWithFontSize:kFontLarge color:RGBCOLOR_HEX(kLabelDarkColor)];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (WPLIfeServiceView *)lifeServiceView {
    if (!_lifeServiceView) {
        _lifeServiceView = [[WPLIfeServiceView alloc] init];
        [self.contentView addSubview:_lifeServiceView];
    }
    return _lifeServiceView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(kPadding, 0, 0, 0));
    
    [self.titleLabel x_sizeToFit];
    self.titleLabel.left = kPadding;
    self.titleLabel.top = kPadding;
    
    self.topMarginView.frame  =CGRectMake(0, 0, self.contentView.width, 1);
    self.middleMarginView.frame = CGRectMake(self.titleLabel.left, self.titleLabel.bottom + kPadding, self.contentView.width - 2 * self.titleLabel.left, 1);

    self.lifeServiceView.frame = CGRectMake(0, self.middleMarginView.bottom , self.contentView.width, self.contentView.height - self.middleMarginView.bottom);
    
    self.bottomMarginView.frame = CGRectMake(0, self.contentView.height, self.contentView.width, 1);
    
    [self.accessoryButton x_sizeToFit];
    self.accessoryButton.right = self.contentView.width - kPadding;
    self.accessoryButton.centerY = self.titleLabel.centerY;
    
}

- (void)setTableViewCellItem:(WPLifeServiceCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    self.titleLabel.text = tableViewCellItem.title;
    self.lifeServiceView.sudokuCellItemArray = tableViewCellItem.lifeServiceViewItemArray;
    self.lifeServiceView.numCol = tableViewCellItem.numCol;
    
    if (![tableViewCellItem heightForTableView:nil]) {
        
        self.hidden = YES;
    } else {
        
        self.hidden = NO;
    }
}

@end
