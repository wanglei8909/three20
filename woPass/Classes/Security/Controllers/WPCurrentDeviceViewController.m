//
//  WPCurrentDeviceViewController.m
//  woPass
//
//  Created by htz on 15/7/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPCurrentDeviceViewController.h"
#import "WPCurrentDeviceCellItem.h"
#import "WPMineDeviceCellItem.h"
#import <objc/runtime.h>

@interface WPCurrentDeviceViewController () <UIAlertViewDelegate>

@property (nonatomic, strong)NSMutableArray *itemsArray;

@end

@implementation WPCurrentDeviceViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteDevice:) name:WPMineDeviceDeleteNotification object:nil];
    
    [self getPageContent];
    self.items = @[self.itemsArray];
}

- (void)getPageContent {
    
    [self.itemsArray removeAllObjects];
    
    weaklySelf();
    [self showLoading:YES];
    [RequestManeger POST:@"/u/devicesHistory" parameters:nil complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        [weakSelf hideLoading:YES];
        [weakSelf showHint:msg hide:1];
        if (!msg) {
            
            NSArray *currentDeciceDicArray = [[responseObject objectForKey:@"data"] objectForKey:@"currentDevices"];
            NSArray *currenDeviceCellItemsArray = [WPCurrentDeviceCellItem objectArrayWithKeyValuesArray:currentDeciceDicArray];
            [[currenDeviceCellItemsArray firstObject] setHeadTitle:@"当前设备"];
            [weakSelf.itemsArray addObjectsFromArray:currenDeviceCellItemsArray];
            
            NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            
            NSArray *mineDeviceDicArray = [[responseObject objectForKey:@"data"] objectForKey:@"devices"];
            NSArray *mineDeviceCellItemArray = [[WPMineDeviceCellItem objectArrayWithKeyValuesArray:mineDeviceDicArray] sortedArrayUsingComparator:^NSComparisonResult(WPMineDeviceCellItem *  _Nonnull obj1, WPMineDeviceCellItem *  _Nonnull obj2) {
                
                NSDate *date1 = [dateformatter dateFromString:obj1.subTitle];
                NSDate *date2 = [dateformatter dateFromString:obj2.subTitle];
                return [date2 compare:date1];
            }];
            [[mineDeviceCellItemArray firstObject] setHeadTitle:@"我的设备"];
            [[mineDeviceCellItemArray firstObject] setSubHeadTitle:@"以下设备曾登录过本帐号"];
            [weakSelf.itemsArray addObjectsFromArray:mineDeviceCellItemArray];
            
            
            [weakSelf.tableView reloadData];
        } else if([[responseObject objectForKey:@"code"] integerValue] == 99998) {
            
            [weakSelf ShowNoNetWithRelodAction:^{
                [weakSelf getPageContent];
            }];
        }
    })];
}

- (void)deleteDevice:(id)info {
    
    [BaiduMob logEvent:@"id_my_equipment" eventLabel:@"del"];
    
    WPMineDeviceCellItem *item = [info valueForKey:@"object"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定删除此记录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    objc_setAssociatedObject(alert, ALERTVIEWKEY, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    WPMineDeviceCellItem *item = objc_getAssociatedObject(alertView, ALERTVIEWKEY);

    if (buttonIndex == 1) {
        
        weaklySelf();
        [RequestManeger POST:@"/u/delAutoLogin" parameters:@{
                                                             @"deviceId" : @([item.deviceId integerValue])
                                                             } complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
            
            [weakSelf showHint:msg hide:1];
            if (!msg) {
                [weakSelf showHint:@"删除成功" hide:1];
                [weakSelf getPageContent];
            } else {
                
            }
        })];
    }
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    return @"当前设备";
}

@end
