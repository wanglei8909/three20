//
//  WPSecurityBasicCellItem.m
//  woPass
//
//  Created by htz on 15/7/8.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPSecurityBasicCellItem.h"


@interface WPSecurityBasicCellItem ()

@property (nonatomic, assign)BOOL shouldShowRightView;
@property (nonatomic, assign)BOOL hasRightView;
@property (nonatomic, assign)NSString *rightImageName;

@end

@implementation WPSecurityBasicCellItem

- (NSString *)accessoryName {
    return @"youjiantou-";
}

- (NSString *)rightImageName {
    
    return @"baocuo-loginHistory";
}

- (BOOL)shouldShowRightView {
    
    return [gUser.showShowAbnormal integerValue];
}

- (Class)cellClass {
    
    return [WPSecurityBasicCell class];
}

@end

@interface WPSecurityBasicCell ()

@property (nonatomic, strong)UIImageView *rightImageView;

@end

@implementation WPSecurityBasicCell

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_rightImageView];
    }
    return _rightImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.rightImageView x_sizeToFit];
    self.rightImageView.centerY = self.contentView.height / 2;
    self.rightImageView.right = self.accessoryImageView.left - 8;
}

- (void)setTableViewCellItem:(WPSecurityBasicCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    self.rightImageView.image = [UIImage imageNamed:tableViewCellItem.rightImageName];
    self.rightImageView.hidden = !(tableViewCellItem.shouldShowRightView && tableViewCellItem.hasRightView);
    [self setNeedsLayout];
}



@end
