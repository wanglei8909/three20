//
//  WPFreeWiFiHeaderCellIItem.m
//  woPass
//
//  Created by htz on 15/8/2.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPFreeWiFiHeaderCellIItem.h"

@interface WPFreeWiFiHeaderCellIItem ()

@end

@implementation WPFreeWiFiHeaderCellIItem

- (Class)cellClass {
    return [WPFreeWiFiHeaderCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return SCREEN_WIDTH * 100 / 320;
}

- (NSString *)bkImageName {
    
//    if ([gUser.freeWifiIsAvaliable integerValue]) {
//        
//        return @"freeWifiAvailable";
//    } else {
//        
//        return @"freeWiFiNotAvailable";
//    }
    
    return @"freeWifiAvailable";
}

@end

@interface WPFreeWiFiHeaderCell ()

@property (nonatomic, strong)UIImageView *bkImageView;

@end

@implementation WPFreeWiFiHeaderCell

- (UIImageView *)bkImageView {
    if (!_bkImageView) {
        _bkImageView = [[UIImageView alloc] init];
        
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
    
    self.bkImageView.backgroundColor = [UIColor redColor];
    self.bkImageView.frame = self.contentView.bounds;
}

- (void)setTableViewCellItem:(WPFreeWiFiHeaderCellIItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    
    self.bkImageView.image = [UIImage imageNamed:tableViewCellItem.bkImageName];
}

@end
