//
//  WPMyCityController.h
//  woPass
//
//  Created by 王蕾 on 15/7/28.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XViewController.h"

typedef void (^FinishBlock)(NSDictionary *cityDict);
@interface WPMyCityController : XViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate>


@property (nonatomic, copy)FinishBlock finishBlock;

@property (nonatomic, strong) UITableView *cityTable;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchCtrl;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *filterArray;
@property (nonatomic, strong) NSMutableArray *indexArray;

@end
