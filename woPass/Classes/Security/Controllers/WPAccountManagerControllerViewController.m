//
//  WPAccountManagerControllerViewController.m
//  woPass
//
//  Created by 王蕾 on 16/2/15.
//  Copyright © 2016年 unisk. All rights reserved.
//

#import "WPAccountManagerControllerViewController.h"
#import "WPSecurityBasicCellItem.h"
#import "WPAlertView.h"

@interface WPAccountManagerControllerViewController ()

@property (nonatomic, strong)NSMutableArray *itemArray;

@end

@implementation WPAccountManagerControllerViewController

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
    [self.tableView setTop:70];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    
    [self.itemArray addObject:[[[WPSecurityBasicCellItem alloc] initWithDictionary:@{
                                                                                     @"title" : [gUser.isSet integerValue] ? @"修改密码" : @"设置密码",
                                                                                     @"iconName" : @"iconfont_4",
                                                                                     @"marginType" : @(TZBasicCellTopMargin)
                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
        if ([gUser.isSet integerValue]) {
            
            if (ISLOGINED) {
                
                [@"WP://changPwd_vc" open];
            } else {
                
                [UserAuthorManager authorizationLogin:nil andSuccess:^{
                    
                } andFaile:^{
                    
                }];
            }
        } else {
            
            if (ISLOGINED) {
                
                [@"WP://setPwd_vc" open];
                [BaiduMob logEvent:@"id_password" eventLabel:@"set_safe"];
            } else {
                
                [UserAuthorManager authorizationLogin:nil andSuccess:^{
                    
                } andFaile:^{
                    
                }];
            }
        }
    }]];
    
    [self.itemArray addObject:[[[WPSecurityBasicCellItem alloc] initWithDictionary:@{
                                                                                     @"title" : @"绑定手机",
                                                                                     @"iconName" : @"bindingPhone",
                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
        [@"WP://WPShowPhoneViewController" openWithQuery:nil animated:YES];
    }]];
    
    [self.itemArray addObject:[[[WPSecurityBasicCellItem alloc] initWithDictionary:@{
                                                                                     @"title" : @"注销账号",
                                                                                     @"iconName" : @"iconfont-zhuxiaoxiantiao",
                                                                                     @"marginType" :                                                                                                                                                                                                                                                                                                                                    @(TZBasicCellBottomMargin)
                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
        WPAlertView *av = [[WPAlertView alloc]initWithTitle:@"提示" message:@"为了您的账号安全，需要进行实名认证才能完成账号注销操作。" buttonTitles:@[@"取消",@"确定"] andCancleClick:^{
            
        }andOKClick:^{
            [@"WP://WPLogoffAuthenticationViewController"  openWithQuery:@{@"completeAction": ^(id vc){
                [vc dismiss];
                [@"WP://WPDetermineLogoffViewController" open];
            }}];
        }];
        [av show];
    }]];
    
    self.items = @[self.itemArray];
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
    return @"账号管理";
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
