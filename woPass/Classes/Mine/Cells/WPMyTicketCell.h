//
//  WPMyTicketCell.h
//  woPass
//
//  Created by 王蕾 on 15/7/22.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIAttributedLabel.h"
#import "WPMyTicketListModel.h"

@interface WPMyTicketCell : UITableViewCell


@property (nonatomic, strong) WPMyTicketListModel *model;
@property (nonatomic, strong) UIImageView *topVivew;
@property (nonatomic, strong) UILabel *storeNameLabel;
@property (nonatomic, strong) UILabel *ticketNameLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UITextView *numLabel;
@property (nonatomic, strong) UIImageView *smallIcon;
@property (nonatomic, strong) NIAttributedLabel *priceLabel;

@end
