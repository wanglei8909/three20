//
//  WPUserPortrayCtrl.h
//  woPass
//
//  Created by 王蕾 on 15/12/1.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "XViewController.h"

@interface WPUserPortrayCtrl : XViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableString *portrayString;

@property (nonatomic, strong) NSMutableArray *loginAppArray;

@property (nonatomic, strong) NSMutableArray *loginDeviceArray;

@property (nonatomic, strong) NSMutableArray *cityArray;

@property (nonatomic, strong) NSMutableArray *timeArray;

@end
