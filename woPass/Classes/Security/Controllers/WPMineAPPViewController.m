//
//  WPMineAPPSubViewController.m
//  woPass
//
//  Created by htz on 15/7/12.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMineAPPViewController.h"
#import "WPMIneAppCellItem.h"
#import "WPAppAlertView.h"
#import <objc/runtime.h>
#import "MJRefresh.h"


@interface WPMineAPPViewController () <UIAlertViewDelegate>

@property (nonatomic, strong)NSMutableArray *itemsArray;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)UIImageView *blankView;

@end

@implementation WPMineAPPViewController

- (UIImageView *)blankView {
    if (!_blankView) {
        _blankView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-wangzhanneirong"]];
        [self.tableView addSubview:_blankView];
    }
    return _blankView;
}

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
        
    }
    return _itemsArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setFrame:self.view.bounds];
    
    [self setupRefresh];
    self.items = @[self.itemsArray];
}

- (void)setupRefresh {
    
    NSArray *idleImages = @[[UIImage imageNamed:@"s1"]];
    NSArray *refreshingImages = @[[UIImage imageNamed:@"s1"],[UIImage imageNamed:@"s2"],[UIImage imageNamed:@"s3"],[UIImage imageNamed:@"s4"],[UIImage imageNamed:@"s5"],[UIImage imageNamed:@"s6"],[UIImage imageNamed:@"s7"],[UIImage imageNamed:@"s8"]];
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [header setImages:idleImages forState:MJRefreshStateIdle];
    [header setImages:idleImages forState:MJRefreshStatePulling];
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView.footer = footer;
    [self.tableView.footer noticeNoMoreData];

}

- (void)loadNewData {
    
    weaklySelf();
    [RequestManeger POST:@"/u/myAppList" parameters:@{
                                                      @"page" : @1
                                                      } complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        [self showHint:msg hide:1];
        [weakSelf.tableView.header endRefreshing];

        if (!msg) {
            
            NSArray *mineAppDicArray = [[responseObject objectForKey:@"data"] objectForKey:@"myApps"];
            NSArray *mineAppCellItemArray = [WPMIneAppCellItem objectArrayWithKeyValuesArray:mineAppDicArray];
            
            if (mineAppCellItemArray.count < 10) {
                
                [weakSelf.tableView.footer noticeNoMoreData];
            } else {
                
                [weakSelf.tableView.footer resetNoMoreData];
            }
            
            weakSelf.blankView.hidden = mineAppCellItemArray.count;
            
            [weakSelf.itemsArray removeAllObjects];
            weakSelf.page = 1;
            [weakSelf.itemsArray addObjectsFromArray:mineAppCellItemArray];
            [weakSelf.tableView reloadData];
        } else if ([[responseObject objectForKey:@"code"] integerValue] == 99998) {
            
            [weakSelf ShowNoNetWithRelodAction:^{
                
                [weakSelf loadNewData];
            } adapt:-20];
        }
    })];
}

- (void)loadMore {
    
    weaklySelf();
    [RequestManeger POST:@"/u/myAppList" parameters:@{
                                                      @"page" : @(++ weakSelf.page)
                                                      } complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        [weakSelf.tableView.header endRefreshing];
        NSArray *mineAppDicArray = [[responseObject objectForKey:@"data"] objectForKey:@"myApps"];
        NSArray *mineAppCellItemArray = [WPMIneAppCellItem objectArrayWithKeyValuesArray:mineAppDicArray];
        
        if (mineAppCellItemArray.count < 10) {
            
            [weakSelf.tableView.footer noticeNoMoreData];
        } else {
            
            [weakSelf.tableView.footer resetNoMoreData];
        }
        
        [weakSelf.itemsArray removeAllObjects];
        [weakSelf.itemsArray addObjectsFromArray:mineAppCellItemArray];
        [weakSelf.tableView reloadData];
    })];
}


- (void)generateContent {
    
    [self.tableView.header beginRefreshing];
}

#pragma mark - 解绑应用 
- (void)debindingApp:(id)info {
    
    WPMIneAppCellItem *item = [[info valueForKey:@"object"] valueForKey:@"tableViewCellItem"];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定解绑此应用?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    objc_setAssociatedObject(alertView, ALERTVIEWKEY, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        [BaiduMob logEvent:@"id_app" eventLabel:@"unbundlingsure"];
        
        WPMIneAppCellItem *item = objc_getAssociatedObject(alertView, ALERTVIEWKEY);
        
        NSInteger itemId = [item.itemId integerValue];
        
        weaklySelf();
        [RequestManeger POST:@"/u/delUserAppToken" parameters:@{
                                                                @"itemIds" : @[@(itemId)]
                                                                } complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
            [weakSelf.itemsArray removeObject:item];
            [weakSelf.tableView reloadData];
        })];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.blankView.centerX = self.tableView.width / 2;
    self.blankView.centerY = self.tableView.height / 3;
}

- (BOOL)hideNavigationBar
{
    return YES;
}

- (BOOL)hasYDNavigationBar
{
    return NO;
}

- (BOOL)autoGenerateBackBarButtonItem
{
    return YES;
}

- (NSString *)title {
    return @"";

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(debindingApp:) name:WPMineAppDebindingNotification object:nil];

}




@end
