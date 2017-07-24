//
//  WPActCell.h
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPPriActListModel.h"

@interface WPActCell : UITableViewCell

@property (nonatomic, strong)WPPriActListModel *model;
@property (nonatomic, strong)UIImageView *image;
@property (nonatomic, strong)UILabel *time;
@property (nonatomic, strong)UILabel *title;

@end
