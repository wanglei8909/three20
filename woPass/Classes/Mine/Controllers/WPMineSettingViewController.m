//
//  WPMineSettingViewController.m
//  woPass
//
//  Created by 王蕾 on 16/2/15.
//  Copyright © 2016年 unisk. All rights reserved.
//

#import "WPMineSettingViewController.h"
#import "WPSettingCellItem.h"
#import "WPMineEmptyCellHeaderItem.h"
#import "SDImageCache.h"
#import "WPMinePushCellItem.h"

@interface WPMineSettingViewController ()
@property (nonatomic, strong)NSMutableArray *itemArray;

@end

@implementation WPMineSettingViewController

#pragma mark - Getter and Setter

- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = [[NSMutableArray alloc] init];
        
    }
    return _itemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:80];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    
    [self setupPage];
    self.items = @[self.itemArray];
}

- (void)setupPage {
    
    
    [self.itemArray addObject:[[[WPSettingCellItem alloc] initWithDictionary:@{
                                                                               @"title" : @"关于",
                                                                               @"iconName" : @"gengduog",
                                                                               @"accessoryName" : @"youjiantou-"
                                                                               }] applyActionBlock:^(UITableView *tableView, id info) {
        [@"WP://WPAboutController" openWithQuery:nil animated:YES];
    }]];
    
    [self.itemArray addObject:[[[WPSettingCellItem alloc] initWithDictionary:@{
                                                                            @"title" : @"清除缓存",
                                                                            @"iconName" : @"huancun",
                                                                            @"accessoryName" : @"youjiantou-"
                                                                            }] applyActionBlock:^(UITableView *tableView, id info) {
        NSLog(@"--->%lu",(unsigned long)[[SDImageCache sharedImageCache] getSize]);
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定清除缓存？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        av.tag = 10000;
        [av show];
    }]];
    [self.itemArray addObject:[[WPMinePushCellItem alloc] init]];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }else if (buttonIndex == 1){
        [[SDImageCache sharedImageCache] clearDisk];
    }
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
    return @"设置";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
