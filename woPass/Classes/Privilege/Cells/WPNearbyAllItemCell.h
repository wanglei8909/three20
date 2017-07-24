//
//  WPNearbyAllItemCell.h
//  woPass
//
//  Created by 王蕾 on 15/8/27.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SearchItem)(NSString *content);

@interface WPNearbyAllItemCell : UITableViewCell


@property (nonatomic, strong)NSArray *items;
@property (nonatomic, copy)SearchItem searchBlock;
@property (nonatomic, assign) int indexPath;

@end
