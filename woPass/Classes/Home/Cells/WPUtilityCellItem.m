//
//  WPUtilityCellItem.m
//  woPass
//
//  Created by htz on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//


#import "WPUtilityCellItem.h"

@interface WPUtilityCellItem ()

@end

@implementation WPUtilityCellItem

- (Class)cellClass {
    return [WPUtilityCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return self.utilityViewItemsArray.count ? SCALED(63) * (1 + (self.utilityViewItemsArray.count - 1) / self.numCol) : 0;
}

- (NSInteger)numCol {
    
    return 4;
}

@end

@interface WPUtilityCell ()

@property (nonatomic, strong)UIView *marginView;


@end

@implementation WPUtilityCell

- (UIView *)marginView {
    if (!_marginView) {
        _marginView = [[UIView alloc] init];
        _marginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self.contentView addSubview:_marginView];
    }
    return _marginView;
}

- (WPUtilityView *)utilityView {
    if (!_utilityView) {
        _utilityView = [[WPUtilityView alloc] init];
        [self.contentView addSubview:_utilityView];
    }
    return _utilityView;
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
    self.utilityView.frame = self.contentView.bounds;
    
    self.marginView.frame = CGRectMake(0, self.contentView.height, self.contentView.width, 1);
}

- (void)setTableViewCellItem:(WPUtilityCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    self.utilityView.sudokuCellItemArray = tableViewCellItem.utilityViewItemsArray;
    self.utilityView.numCol = tableViewCellItem.numCol;
    
    if (![tableViewCellItem heightForTableView:nil]) {
        
        self.hidden = YES;
    } else {
        
        self.hidden = NO;
    }
}

@end