//
//  WPPoraitCellItem.m
//  woPass
//
//  Created by htz on 15/12/3.
//  Copyright © 2015年 unisk. All rights reserved.
//


#import "WPPoraitCellItem.h"

@interface WPPoraitCellItem ()

@end

@implementation WPPoraitCellItem

- (Class)cellClass {
    return [WPPoraitCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return SCALED(90);
}

@end

@interface WPPoraitCell ()

@property (nonatomic, strong)UIImageView *bkImageView;

@end

@implementation WPPoraitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.layer.borderWidth = 1;
        self.contentView.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
    }
    return self;
}

- (UIImageView *)bkImageView {
    if (!_bkImageView) {
        _bkImageView = [[UIImageView alloc] init];
        _bkImageView.image = [UIImage imageNamed:@"portrait"];
        [self.contentView addSubview:_bkImageView];
    }
    return _bkImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(SCALED(10), 0, 0, 0));
    self.bkImageView.frame = self.contentView.bounds;
}

- (void)setTableViewCellItem:(WPPoraitCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
}

@end