//
//  WPMineDeviceCellItem.m
//  woPass
//
//  Created by htz on 15/7/28.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMineDeviceCellItem.h"
#import "JMWhenTapped.h"

@interface WPMineDeviceCellItem ()

@end

@implementation WPMineDeviceCellItem

- (Class)cellClass {
    return [WPMineDeviceCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (NSString *)accessoryName {
    return @"shanchu";
}

@end

@interface WPMineDeviceCell ()

@end

@implementation WPMineDeviceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.accessoryImageView.centerY = self.contentView.height / 2;
}

- (void)setTableViewCellItem:(WPMineDeviceCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    
    [self.accessoryImageView whenTapped:^{
       
        [[NSNotificationCenter defaultCenter] postNotificationName:WPMineDeviceDeleteNotification object:self.tableViewCellItem];
    }];
}

@end
