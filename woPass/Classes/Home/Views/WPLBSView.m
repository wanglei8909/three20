//
//  WPLBSView.m
//  woPass
//
//  Created by htz on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLBSView.h"

@implementation WPLBSViewCellItem


@end

@implementation WPLBSViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end

@implementation WPLBSView

- (Class)viewCellClass {
    return [WPLBSViewCell class];
}
@end
