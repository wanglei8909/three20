//
//  WPLLCell.h
//  woPass
//
//  Created by 王蕾 on 15/8/12.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIAttributedLabel.h"
#import "WPLLProductModel.h"

@interface WPLLCell : UITableViewCell

@property (nonatomic, strong) WPLLProductModel *model;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *desLabel;
@property (nonatomic, strong)NIAttributedLabel *priceLabel;
@property (nonatomic, strong)UIImageView *selectedView;
//@property (nonatomic, strong)

@end
