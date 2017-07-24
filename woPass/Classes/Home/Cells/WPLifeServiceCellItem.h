//
//  WPLifeServiceCellItem.h
//  woPass
//
//  Created by htz on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//


#import "XTableViewCellItem.h"
#import "XTableViewCell.h"
#import "WPLIfeServiceView.h"

@interface WPLifeServiceCellItem : XTableViewCellItem

@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)NSArray *lifeServiceViewItemArray;
@property (nonatomic, assign)NSInteger numCol;


@end

@interface WPLifeServiceCell : XTableViewCell

@property (nonatomic, strong)WPLIfeServiceView *lifeServiceView;
@property (nonatomic, strong)NIAttributedLabel *titleLabel;
@property (nonatomic, strong)UIButton *accessoryButton;

@end