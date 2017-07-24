//
//  WPLBSCellItem.m
//  woPass
//
//  Created by htz on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//


#import "WPLBSCellItem.h"
#import "NIAttributedLabel.h"

@interface WPLBSCellItem ()

@end

@implementation WPLBSCellItem

- (Class)cellClass {
    return [WPLBSCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return 135 + kPadding;
}

- (NSString *)title {
    return @"周边快查";
}

@end

@interface WPLBSCell ()

@property (nonatomic, strong)UIView *marginView;


@end

@implementation WPLBSCell

- (UIView *)marginView {
    if (!_marginView) {
        _marginView = [[UIView alloc] init];
        _marginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self.contentView addSubview:_marginView];
    }
    return _marginView;
}

- (NIAttributedLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [NIAttributedLabel labelWithFontSize:kFontLarge color:RGBCOLOR_HEX(kLabelDarkColor)];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
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
    
    self.marginView.frame = CGRectMake(0, self.titleLabel.bottom + kPadding, self.contentView.width, 1);
}

- (void)setTableViewCellItem:(WPLBSCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    
    self.titleLabel.text = tableViewCellItem.title;
    self.TripView.sudokuCellItemArray = tableViewCellItem.tripViewItemArray;
    self.lifeView.sudokuCellItemArray = tableViewCellItem.lifeViewItemArray;
    self.food.sudokuCellItemArray = tableViewCellItem.foodViewItemArray;
}

@end
