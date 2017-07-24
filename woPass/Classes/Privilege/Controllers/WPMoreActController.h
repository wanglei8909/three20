//
//  WPMoreActController.h
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XViewController.h"
#import "WPActTable.h"

@interface WPMoreActController : XViewController


@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)int mPage;
@property (nonatomic, strong)WPActTable *tTable;

@end
