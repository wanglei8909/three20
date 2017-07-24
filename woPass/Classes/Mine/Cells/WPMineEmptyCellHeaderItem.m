//
//  WPMineEmptyCellHeaderItem.m
//  woPass
//
//  Created by 王蕾 on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMineEmptyCellHeaderItem.h"

@implementation WPMineEmptyCellHeaderItem


- (Class)cellClass {
    return [WPMineEmptyCellHeader class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return 15;
}

@end

@implementation WPMineEmptyCellHeader



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)setTableViewCellItem:(WPMineEmptyCellHeaderItem *)tableViewCellItem {
    
}

@end


