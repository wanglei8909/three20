//
//  WPGPRSUsageViewController.m
//  woPass
//
//  Created by htz on 15/8/10.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPGPRSUsageViewController.h"
#import "WPGPRSHeaderCellItem.h"
#import "WPGPRSCellItem.h"

@interface WPGPRSUsageViewController ()

@property (nonatomic, strong)NSMutableArray *ItemsArray;

@end

@implementation WPGPRSUsageViewController

- (NSMutableArray *)ItemsArray {
    if (!_ItemsArray) {
        _ItemsArray = [[NSMutableArray alloc] init];
        
    }
    return _ItemsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BaiduMob logEvent:@"id_unicom_ability" eventLabel:@"trafficsearch"];
    
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.navigationController.navigationBar.height + 22, 0, 0, 0))];
    
    [self getPageContent];
    
    [self.ItemsArray addObject:[[WPGPRSHeaderCellItem alloc] init]];
    [self.ItemsArray addObject:[[WPGPRSCellItem alloc] init]];
    
    self.items = @[self.ItemsArray];
    
    self.tableView.scrollEnabled = NO;
}

- (void)getPageContent {
    
    
    [self showLoading:YES];
    weaklySelf();
    [RequestManeger POST:@"/u/flowQuery" parameters:nil complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        [weakSelf hideLoading:YES];
        
        int code = [responseObject[@"code"] intValue];
        if (code == 0) {
            WPGPRSHeaderCellItem *headerItem = [weakSelf.ItemsArray objectAtIndex:0];
            [headerItem setKeyValues:[[responseObject objectForKey:@"data"] objectForKey:@"user"]];
            
            WPGPRSCell *item = [weakSelf.ItemsArray objectAtIndex:1];
            [item setKeyValues:[[responseObject objectForKey:@"data"] objectForKey:@"user"]];
            [weakSelf.tableView reloadData];
        }else if (code == 99998){
            //没网
            [weakSelf ShowNoNetWithRelodAction:^{
                [weakSelf getPageContent];
            }];
        }
        else if (code == 1024){
            [weakSelf ShowNoData];
        }
        else{
            [weakSelf showHint:msg hide:1];
        }
    })];
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50 - 55)];
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
    return @"流量查询";
}

@end
