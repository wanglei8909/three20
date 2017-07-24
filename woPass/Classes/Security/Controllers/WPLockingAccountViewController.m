//
//  WPLockingAccountViewController.m
//  woPass
//
//  Created by htz on 15/7/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLockingAccountViewController.h"
#import "WPLockingAccountCellItem.h"

@interface WPLockingAccountViewController ()

@property (nonatomic, strong)NSMutableArray *itemsArray;

@end

@implementation WPLockingAccountViewController

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
    
    [self.itemsArray addObject:[[WPLockingAccountCellItem alloc] initWithDictionary:@{
                                                                                      @"headTitle" : @"锁定帐号后，一切与通行证绑定的帐号将被冻结，无法使用本通行证进行登录",
                                                                                      @"iconName" : @"back",
                                                                                      @"title" : @"锁定帐号",
                                                                                      @"marginType" : @(TZBasicCellAllMargin)
                                                                                      }]];
    
    self.items = @[self.itemsArray];
}

- (void)getPageContent {
    
    weaklySelf();
    [self showLoading:YES];
    [RequestManeger POST:@"/u/lockPartner" parameters:nil complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        [weakSelf hideLoading:YES];
        [weakSelf showHint:msg hide:1];
        
        if (!msg) {
            gUser.thirdLogin = [NSString stringWithFormat:@"%@", [[[responseObject objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"thirdLogin"]];
            [weakSelf.tableView reloadData];
        }
    })];
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50 - 55)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getPageContent];
    [self.tableView reloadData];
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
    return @"锁定帐号";
}

@end
