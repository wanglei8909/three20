//
//  WPHotAppViewController.m
//  woPass
//
//  Created by htz on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPHotAppViewController.h"
#import "WPMIneAppCellItem.h"
#import <objc/runtime.h>
#import "MJRefresh.h"


@interface WPHotAppViewController () <UIAlertViewDelegate>

@property (nonatomic, strong)NSMutableArray *itemsArray;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)UIImageView *blankView;

@end

@implementation WPHotAppViewController

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

- (void)getPageContent {
    
    [self.tableView.header beginRefreshing];
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
    [RequestManeger POST:@"/u/hotAppList" parameters:@{
                                                       @"page" : @(1)
                                                       } complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {

        [[weakSelf.tableView header] endRefreshing];
        if (!msg) {
            
            NSArray *hotAppDicArray = [[responseObject objectForKey:@"data"] objectForKey:@"hotApps"];
            NSArray *hotAppsCellItemArray = [WPMIneAppCellItem objectArrayWithKeyValuesArray:hotAppDicArray];
            
            if (hotAppsCellItemArray.count < 10) {
                
                [weakSelf.tableView.footer noticeNoMoreData];
            } else {
                
                [weakSelf.tableView.footer resetNoMoreData];
            }
            
            weakSelf.blankView.hidden = hotAppsCellItemArray.count;
            
            weakSelf.page = 1;
            [weakSelf.itemsArray removeAllObjects];
            [weakSelf.itemsArray addObjectsFromArray:hotAppsCellItemArray];
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
    [RequestManeger POST:@"/u/hotAppList" parameters:@{
                                                       @"page" : @(++ weakSelf.page)
                                                       } complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        [weakSelf.tableView.footer endRefreshing];
        NSArray *hotAppDicArray = [[responseObject objectForKey:@"data"] objectForKey:@"hotApps"];
        NSArray *hotAppsCellItemArray = [WPMIneAppCellItem objectArrayWithKeyValuesArray:hotAppDicArray];
        
        if (hotAppsCellItemArray.count < 10) {
            
            [weakSelf.tableView.footer noticeNoMoreData];
        } else {
            
            [weakSelf.tableView.footer resetNoMoreData];
        }
        
        [weakSelf.itemsArray addObjectsFromArray:hotAppsCellItemArray];
        [weakSelf.tableView reloadData];
    })];
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    self.blankView.centerX = self.tableView.width / 2;
    self.blankView.centerY = self.tableView.height / 3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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


@end
