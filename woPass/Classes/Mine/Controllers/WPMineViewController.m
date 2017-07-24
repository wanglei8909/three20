//
//  WPMineViewController.m
//  woPass
//
//  Created by htz on 15/7/6.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "NSArray+YDTableSectionView.h"
#import "WPMineViewController.h"
#import "AFNetworking.h"
#import "WPMineCellItem.h"
#import "WPMineEmptyCellHeaderItem.h"
#import "WPMineCellButtonItem.h"
#import "WPPersonalInformationController.h"
#import "WPRootViewController.h"
#import "WPMyOrderListController.h"
#import "WPMyTicketController.h"
#import "UMFeedback.h"
#import "WPQRCodeController.h"
#import "SDImageCache.h"
#import "XNavigator.h"
#import "XNavigationController.h"
#import "WPRootViewController.h"
#import "WPMinePushCellItem.h"
#import "WPMinePushLabelCellItem.h"

@interface WPMineViewController ()

@property (nonatomic, strong)NSMutableArray *itemSection1;//个人信息
@property (nonatomic, strong)NSMutableArray *itemSection2;
@property (nonatomic, strong)NSMutableArray *itemSection3;
@property (nonatomic, strong)NSMutableArray *itemSection4;
@property (nonatomic, strong)NSMutableArray *itemSection5;//退出登录

@end

@implementation WPMineViewController


- (NSMutableArray *)itemSection1 {
    if (!_itemSection1) {
        _itemSection1 = [[NSMutableArray alloc] init];
    }
    return _itemSection1;
}
- (NSMutableArray *)itemSection2 {
    if (!_itemSection2) {
        _itemSection2 = [[NSMutableArray alloc] init];
    }
    return _itemSection2;
}
- (NSMutableArray *)itemSection3 {
    if (!_itemSection3) {
        _itemSection3 = [[NSMutableArray alloc] init];
    }
    return _itemSection3;
}
- (NSMutableArray *)itemSection4 {
    if (!_itemSection4) {
        _itemSection4 = [[NSMutableArray alloc] init];
        
    }
    return _itemSection4;
}
- (NSMutableArray *)itemSection5{
    if (!_itemSection5) {
        _itemSection5 = [[NSMutableArray alloc] init];
    }
    return _itemSection5;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    [self.itemSection3 replaceObjectAtIndex:2 withObject:[[[WPMineCellItem alloc] initWithDictionary:@{
                                                                                                       @"title" : @"清除缓存",
                                                                                                       @"iconName" : @"huancun",
                                                                                                       }] applyActionBlock:^(UITableView *tableView, id info) {
        NSLog(@"--->%lu",(unsigned long)[[SDImageCache sharedImageCache] getSize]);
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定清除缓存？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        av.tag = 10000;
        [av show];
    }]];
    self.items = @[self.itemSection1,self.itemSection2,self.itemSection3, self.itemSection4,self.itemSection5];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
        
    [self.itemSection1 addObject:[[[WPMineCellItem alloc] initWithDictionary:@{
                                                                                     @"title" : @"个人信息",
                                                                                     @"iconName" : @"geren",
                                                                                     @"accessoryName" : @"youjiantou-"
                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
        
        [@"WP://personalInformation" open];
        [BaiduMob logEvent:@"id_user_data" eventLabel:@"usercenter"];
        
    }]];
    [self.itemSection1 setSectionHeaderItem:[[[WPMineEmptyCellHeaderItem alloc] initWithDictionary:@{
                                                                                                     
                                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
        
    }]];

    [self.itemSection2 addObject:[[[WPMineCellItem alloc] initWithDictionary:@{
                                                                               @"title" : @"我的卡券包",
                                                                               @"iconName" : @"coupons",
                                                                               @"accessoryName" : @"youjiantou-"
                                                                               }] applyActionBlock:^(UITableView *tableView, id info) {
        //点我的要拦截判断登录状态
        if ([UserAuthorManager gainCurrentStateForUserLoginAndBind] == 0) {
            [self GoLogin:^{
                
            }];
            return;
        }
        [@"WP://WPMyTickettViewController" open];
        [BaiduMob logEvent:@"id_coupons" eventLabel:@"usercenter"];
    }]];
    [self.itemSection2 setSectionHeaderItem:[[[WPMineEmptyCellHeaderItem alloc] initWithDictionary:@{
                                                                                                     
                                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
    }]];
    
    [self.itemSection3 addObject:[[[WPMineCellItem alloc] initWithDictionary:@{
                                                                               @"title" : @"反馈",
                                                                               @"iconName" : @"jianfankui",
                                                                               @"accessoryName" : @"youjiantou-"
                                                                               }] applyActionBlock:^(UITableView *tableView, id info) {
        //点我的要拦截判断登录状态
        if ([UserAuthorManager gainCurrentStateForUserLoginAndBind] == 0) {
            [self GoLogin:^{
                
            }];
            return;
        }
        [self presentModalViewController:[UMFeedback feedbackModalViewController]
                                animated:YES];
        
    }]];
    [self.itemSection3 addObject:[[[WPMineCellItem alloc] initWithDictionary:@{
                                                                               @"title" : @"关于",
                                                                               @"iconName" : @"gengduog",
                                                                               @"accessoryName" : @"youjiantou-"
                                                                               }] applyActionBlock:^(UITableView *tableView, id info) {
        [@"WP://WPAboutController" openWithQuery:nil animated:YES];
    }]];
    [self.itemSection3 addObject:[[[WPMineCellItem alloc] initWithDictionary:@{
                                                                               @"title" : @"清除缓存",
                                                                               @"iconName" : @"huancun",
                                                                               }] applyActionBlock:^(UITableView *tableView, id info) {
        NSLog(@"--->%lu",(unsigned long)[[SDImageCache sharedImageCache] getSize]);
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定清除缓存？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        av.tag = 10000;
        [av show];
    }]];
    [self.itemSection3 setSectionHeaderItem:[[[WPMineEmptyCellHeaderItem alloc] initWithDictionary:@{
                                                                                                     
                                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
    }]];
    
    [self.itemSection4 setSectionHeaderItem:[[[WPMineEmptyCellHeaderItem alloc] initWithDictionary:@{
                                                                                                     
                                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
    }]];
    [self.itemSection4 addObject:[[WPMinePushCellItem alloc] init]];
    [self.itemSection4 setSectionFooterItem:[[[WPMinePushLabelCellItem alloc] initWithDictionary:@{
                                                                                                     
                                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
    }]];
    NSString *btnTitle = @"";
    if ([UserAuthorManager gainCurrentStateForUserLoginAndBind] == 0) {
        btnTitle = @"登录";
    }else{
        btnTitle = @"退出登录";
    }
    
    
    [self.itemSection5 addObject:[[[WPMineCellButtonItem alloc] initWithDictionary:@{
                                                                                     @"btnTitle" : btnTitle,
                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
        
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定退出登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            av.tag = 1000;
            [av show];
            
        
    }]];
    
    [self.itemSection5 setSectionHeaderItem:[[[WPMineEmptyCellHeaderItem alloc] initWithDictionary:@{
                                                                                                     
                                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
    }]];
    
    self.items = @[self.itemSection1,self.itemSection2,self.itemSection3, self.itemSection4, self.itemSection5];
    
    self.tableView.scrollEnabled = NO;
    
    [gUser addObserver:self forKeyPath:@"userId" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10000) {
        if (buttonIndex == 0) {
            
        }else if (buttonIndex == 1){
            [[SDImageCache sharedImageCache] clearDisk];
            [self.itemSection3 replaceObjectAtIndex:2 withObject:[[[WPMineCellItem alloc] initWithDictionary:@{
                                                                                                              @"title" : @"清除缓存",
                                                                                                              @"iconName" : @"huancun",
                                                                                                              }] applyActionBlock:^(UITableView *tableView, id info) {
                NSLog(@"--->%lu",(unsigned long)[[SDImageCache sharedImageCache] getSize]);
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定清除缓存？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                av.tag = 10000;
                [av show];
            }]];
            self.items = @[self.itemSection1,self.itemSection2,self.itemSection3,self.itemSection4,self.itemSection5];
        }
    }else if (alertView.tag == 1000){
        if (buttonIndex == 0) {
            
        }else if (buttonIndex == 1){
            //点我的要拦截判断登录状态
            if ([UserAuthorManager gainCurrentStateForUserLoginAndBind] == 0) {
                [self GoLogin:^{
                    
                }];
            }else{
                [gUser QutiLogin:^{
                    XNavigationController *nCtrl = (XNavigationController *)[XNavigator navigator].window.rootViewController;
                    for (UIViewController *ctrl in nCtrl.viewControllers) {
                        if ([ctrl isKindOfClass:[RDVTabBarController class]] && ctrl) {
                            RDVTabBarController *rCtrl = (RDVTabBarController *)ctrl;
                            [rCtrl setSelectedIndex:0];
                        }
                    }
                }];
            }
        }
    }
}
- (void)RefreshLoginBtnStatu{
    [self.itemSection5 removeAllObjects];
    
    NSString *btnTitle = @"";
    if ([UserAuthorManager gainCurrentStateForUserLoginAndBind] == 0) {
        btnTitle = @"登录";
    }else{
        btnTitle = @"退出登录";
    }
    
    [self.itemSection5 addObject:[[[WPMineCellButtonItem alloc] initWithDictionary:@{
                                                                                     @"btnTitle" : btnTitle,
                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
        //点我的要拦截判断登录状态
        if ([UserAuthorManager gainCurrentStateForUserLoginAndBind] == 0) {
            [self GoLogin:^{
                
            }];
        }else{
            [gUser QutiLogin:^{
                
            }];
        }
    }]];
    
    [self.itemSection5 setSectionHeaderItem:[[[WPMineEmptyCellHeaderItem alloc] initWithDictionary:@{
                                                                                                     
                                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
    }]];
    self.items = @[self.itemSection1,self.itemSection2,self.itemSection3, self.itemSection4,self.itemSection5];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"userId"]){//这里只处理balance属性
        [self RefreshLoginBtnStatu];
    }
}

- (void)GoLogin:(void(^)()) Succeed{
    
    [UserAuthorManager authorizationLogin:self andSuccess:^{
        
        
        Succeed();
    }andFaile:^{
        //
        NSLog(@"登录失败");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)title {
    return @"我的";
}



@end
