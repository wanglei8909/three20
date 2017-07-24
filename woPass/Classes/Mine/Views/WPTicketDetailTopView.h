//
//  WPTicketDetailTopView.h
//  woPass
//
//  Created by 王蕾 on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPMyTicketListModel.h"
#import "NIAttributedLabel.h"

@interface WPTicketDetailTopView : UIView


@property (nonatomic, strong) WPMyTicketListModel *model;
@property (nonatomic, strong) UIImageView *topVivew;
@property (nonatomic, strong) UILabel *storeNameLabel;
@property (nonatomic, strong) UILabel *ticketNameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIImageView *smallIcon;
@property (nonatomic, strong) NIAttributedLabel *priceLabel;

@end
