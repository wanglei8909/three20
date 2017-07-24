//
//  WPTicketCell.h
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIAttributedLabel.h"
#import "WPTicketModel.h"

@interface WPTicketCell : UITableViewCell

@property (nonatomic, copy) void(^getClick)(); //getClick;

@property (nonatomic, strong) WPTicketModel *model;
@property (nonatomic, strong) UIImageView *topVivew;
@property (nonatomic, strong) UILabel *storeNameLabel;
@property (nonatomic, strong) UILabel *ticketNameLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) NIAttributedLabel *priceLabel;
@property (nonatomic, strong) UIImageView *hasGot;
@property (nonatomic, strong) UIButton *getBtn;

@end
