//
//  WPMyOrderTableView.h
//  woPass
//
//  Created by 王蕾 on 15/7/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPtableView.h"
#import "WPMyOrderCell.h"



@interface WPMyOrderTableView : WPtableView

@property (nonatomic, weak) id mDelegate;
@property (nonatomic, assign) SEL payOrder;

@end
