//
//  WPMyOrderCell.h
//  woPass
//
//  Created by 王蕾 on 15/7/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIAttributedLabel.h"
#import "WPMyOrderListModel.h"
@class WPMyOrderCell;

typedef void(^DeleteBlock)(WPMyOrderCell *cell);
typedef void(^PayBlock)(WPMyOrderCell *cell);

@interface WPMyOrderCell : UITableViewCell

@property (nonatomic, strong) WPMyOrderListModel *model;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) NIAttributedLabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *payBtn;

@property (nonatomic, copy) PayBlock payBlock;
@property (nonatomic, copy) DeleteBlock deleteBlock;

@end
