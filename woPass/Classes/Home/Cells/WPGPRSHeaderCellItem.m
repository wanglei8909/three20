//
//  WPGPRSHeaderCellItem.m
//  woPass
//
//  Created by htz on 15/8/10.
//  Copyright (c) 2015年 unisk. All rights reserved.
//
#import "WPGPRSHeaderCellItem.h"
#import "NIAttributedLabel.h"
#import "WPGPRSUsageView.h"
#import "WPGPRSIndicatiorView.h"

@interface WPGPRSHeaderCellItem ()

@end

@implementation WPGPRSHeaderCellItem

- (Class)cellClass {
    return [WPGPRSHeaderCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return SCALED(175) + SCALED(70);
}

- (NSArray *)usageArray {
    WPGPRSUsageViewCellItem *item0 = [[WPGPRSUsageViewCellItem alloc] init];
    WPGPRSUsageViewCellItem *item1 = [[WPGPRSUsageViewCellItem alloc] init];
    WPGPRSUsageViewCellItem *item2 = [[WPGPRSUsageViewCellItem alloc] init];

    item0.title = [NSString stringWithFormat:@"%@M", self.unusedValue ? self.unusedValue : @""];
    item0.subtitle = @"本月套餐剩余";

    item1.title = [NSString stringWithFormat:@"%@M", self.usedValue ? self.usedValue : @""];
    item1.subtitle = @"本月套餐已用";

    item2.title = [NSString stringWithFormat:@"%@M", self.dayUnused ? self.dayUnused : @""];
    item2.subtitle = @"建议日均";


    return @[item0, item1, item2];
}

- (NSString *)dayUnused {
    
    return (_dayUnused.length > 4 ? [_dayUnused substringToIndex:4] : _dayUnused);
}

@end

@interface WPGPRSHeaderCell ()

@property (nonatomic, strong)UIImageView *bkImageView;
@property (nonatomic, strong)WPGPRSIndicatiorView *indicatorView;
@property (nonatomic, strong)WPGPRSUsageView *usageView;


@end

@implementation WPGPRSHeaderCell

- (WPGPRSIndicatiorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[WPGPRSIndicatiorView alloc] init];
        [self.bkImageView addSubview:_indicatorView];
    }
    return _indicatorView;
}

- (WPGPRSUsageView *)usageView {
    if (!_usageView) {
        _usageView = [[WPGPRSUsageView alloc] init];
        [self.contentView addSubview:_usageView];
    }
    return _usageView;
}

- (UIImageView *)bkImageView {
    if (!_bkImageView) {
        _bkImageView = [[UIImageView alloc] init];
        _bkImageView.image = [UIImage imageNamed:@"bg"];
        [self.contentView addSubview:_bkImageView];
    }
    return _bkImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.bkImageView.frame = CGRectMake(0, 0, self.contentView.width, SCALED(175));
    
    self.indicatorView.size = CGSizeMake(self.bkImageView.width, self.bkImageView.height);
    self.indicatorView.centerX = self.bkImageView.width / 2;
    self.indicatorView.centerY = self.bkImageView.height / 2;
    
    self.usageView.frame = CGRectMake(0, self.bkImageView.bottom, self.contentView.width, 70);
    
}

- (void)setTableViewCellItem:(WPGPRSHeaderCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    self.usageView.sudokuCellItemArray = tableViewCellItem.usageArray;
    
    if ([tableViewCellItem.total floatValue] > 0.1) {
        
        [self.indicatorView startAnimationFromValue:[tableViewCellItem.total floatValue] ToValue:[tableViewCellItem.unusedValue floatValue]];
    }
    [self setNeedsLayout];
}

@end
