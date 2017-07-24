//
//  WPAdsCellItem.m
//  woPass
//
//  Created by htz on 15/7/14.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPAdsCellItem.h"

@interface WPAdsCellItem ()

@end

@implementation WPAdsCellItem

- (Class)cellClass {
    return [WPAdsCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return self.adsViewItemsArray.count ? SCALED(80) * (1 + (self.adsViewItemsArray.count - 1) / self.numCol) + kPadding : 0;
}

- (NSInteger)numCol {
    return self.adsViewItemsArray.count > 1 ? 2 : 1;
}


@end

@interface WPAdsCell ()

@property (nonatomic, strong)UIView *bottomMarginView;
@property (nonatomic, strong)UIView *topMarginView;

@end

@implementation WPAdsCell

- (UIView *)bottomMarginView {
    if (!_bottomMarginView) {
        _bottomMarginView = [[UIView alloc] init];
        _bottomMarginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self.contentView addSubview:_bottomMarginView];
    }
    return _bottomMarginView;
}

- (UIView *)topMarginView {
    if (!_topMarginView) {
        _topMarginView = [[UIView alloc] init];
        _topMarginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self.contentView addSubview:_topMarginView];
    }
    return _topMarginView;
}

- (WPAdsView *)adsView {
    if (!_adsView) {
        _adsView = [[WPAdsView alloc] init];
        [self.contentView addSubview:_adsView];
    }
    return _adsView;
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
    
    self.adsView.frame = self.contentView.bounds;
    self.bottomMarginView.frame = CGRectMake(0, self.contentView.height, self.contentView.width, 1);
    self.topMarginView.frame = CGRectMake(0, 0, self.contentView.width, 1);
}

- (void)setTableViewCellItem:(WPAdsCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    self.adsView.numCol = tableViewCellItem.numCol;
    self.adsView.layoutType = (tableViewCellItem.adsViewItemsArray.count > 1) ? WPAdsLayoutDouble : WPAdsLayoutSingle;
    self.adsView.sudokuCellItemArray = tableViewCellItem.adsViewItemsArray;
    
    if (![tableViewCellItem heightForTableView:nil]) {
        
        self.hidden = YES;
    } else {
        
        self.hidden = NO;
    }
    
    [self setNeedsLayout];
}

@end
