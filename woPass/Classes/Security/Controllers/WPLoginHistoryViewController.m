//
//  WPLoginHistoryViewController.m
//  woPass
//
//  Created by htz on 15/7/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLoginHistoryViewController.h"
#import "WPLoginHistoryCellItem.h"
#import "WPLoginHistoryHeadCellItem.h"
#import "WPLoginHistoryUtil.h"

@interface WPLoginHistoryViewController ()

@property (nonatomic, strong)NSMutableArray *itemsArray;

@end

@implementation WPLoginHistoryViewController

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
        
    }
    return _itemsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.navigationController.navigationBar.height + 22, 0, 0, 0))];
    
    [self getPageContent];
    self.items = @[self.itemsArray];
}

- (void)getPageContent {
    
    weaklySelf();
    [self showLoading:YES];
    
    [[WPLoginHistoryUtil sharedUtil] fetchLoginHistoryDicListComplete:^(id response, NSString *msg) {
        
        if (!msg) {
            
            [self hideLoading:YES];
            NSArray *logsArray = [[response objectForKey:@"data"] objectForKey:@"logs"];
            
            [weakSelf.itemsArray addObject:[[WPLoginHistoryHeadCellItem alloc] init]];
            
            [logsArray enumerateObjectsUsingBlock:^(NSDictionary *log, NSUInteger idx, BOOL *stop) {
                
                NSArray *loginHistoryCellItemsArray = [WPLoginHistoryCellItem objectArrayWithKeyValuesArray:[log objectForKey:@"history"]];
                [loginHistoryCellItemsArray enumerateObjectsUsingBlock:^(WPLoginHistoryCellItem * cellItem, NSUInteger idx, BOOL * _Nonnull stop) {
                   
                    [cellItem applyActionBlock:^(UITableView *tableView, id info) {
                        
                        [@"WP://WPLoginHistoryDetailViewController" openWithQuery:@{@"model" : cellItem}];
                    }];
                }];
                [[loginHistoryCellItemsArray firstObject] setIsFirst:YES];
                [[loginHistoryCellItemsArray firstObject] setLoginDate:[log objectForKey:@"date"]];
                [weakSelf.itemsArray addObjectsFromArray:loginHistoryCellItemsArray];
            }];
            [weakSelf.tableView reloadData];
            
        } else if([[response objectForKey:@"code"] integerValue] == 99998) {
            
            [weakSelf ShowNoNetWithRelodAction:^{
                [weakSelf getPageContent];
            }];
        }

    }];
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50 - 55)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)hideNavigationBar
{
    return YES;
}

- (BOOL)hasYDNavigationBar
{
    return YES;
}

- (BOOL)autoGenerateBackBarButtonItem
{
    return YES;
}

- (NSString *)title {
    return @"登录历史";
}

@end
