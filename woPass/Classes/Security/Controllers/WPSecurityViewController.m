//
//  WPSecurityViewController.m
//  woPass
//
//  Created by htz on 15/7/6.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "NSArray+YDTableSectionView.h"
#import "WPSecurityViewController.h"
#import "WPSecurityLevelCellItem.h"
#import "WPSecurityBasicCellItem.h"
#import "WPMineApplicationViewController.h"

@interface WPSecurityViewController ()

@property (nonatomic, strong)NSMutableArray *itemArray;

@end

@implementation WPSecurityViewController

#pragma mark - Constructors and Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    
    [self setupPage];
    self.items = @[self.itemArray];
    [self autoRefreshHeaader];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    if (ISLOGINED) {
        
        [self getHeadContent];
    }
}

#pragma mark - Private Method

- (void)autoRefreshHeaader {
    
    weaklySelf();
    [self.KVOControllerNonRetaining observe:gUser keyPaths:@[@"emailIsavalible", @"passStrength", @"realNameIsauth", @"showShowAbnormal"] options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        
        [weakSelf.tableView reloadData];
    }];
    
    [self.KVOControllerNonRetaining observe:gUser keyPath:@"isSet" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        
        [weakSelf.itemArray[4] setTitle:[gUser.isSet integerValue] ? @"修改密码" : @"设置密码"];
        [weakSelf.tableView reloadData];
    }];
}


- (void)getHeadContent {
    
    weaklySelf();
    [RequestManeger POST:@"/u/safe" parameters:nil complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        [weakSelf showHint:msg hide:1];
        if (!msg) {
            
            gUser.emailIsavalible = [NSString stringWithFormat:@"%@", [[[responseObject objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"emailIsAvalible"]];
            gUser.isSet = [NSString stringWithFormat:@"%@", [[[responseObject objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"isSetPass"]];
            gUser.passStrength = [NSString stringWithFormat:@"%@", [[[responseObject objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"passStrength"]];
            gUser.realNameIsauth = [NSString stringWithFormat:@"%@", [[[responseObject objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"realNameIsAuth"]];
        }
    })];
}

- (void)setupPage {
    
    [self.itemArray addObject:[[WPSecurityLevelCellItem alloc] initWithDictionary:@{
                                                                                    }]];
    
    [self.itemArray addObject:[[[WPSecurityBasicCellItem alloc] initWithDictionary:@{
                                                                                     
                                                                                     @"headTitle" : @"应用管理",
                                                                                     @"title" : @"我的应用",
                                                                                     @"iconName" : @"iconfont_1",
                                                                                     @"marginType" : @(TZBasicCellAllMargin)
                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
        if (ISLOGINED) {
            [BaiduMob logEvent:@"id_app" eventLabel:@"mine"];
            [@"WP://mineApplication_vc" open];
        } else {
            
            [UserAuthorManager authorizationLogin:nil andSuccess:^{
                
            } andFaile:^{
                
            }];
        }
    }]];
    [self.itemArray addObject:[[[WPSecurityBasicCellItem alloc] initWithDictionary:@{
                                                                                     @"headTitle" : @"帐号安全",
                                                                                     @"title" : @"当前设备",
                                                                                     @"iconName" : @"iconfont_2",
                                                                                     @"marginType" : @(TZBasicCellTopMargin)
                                                                                     
                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
        if (ISLOGINED) {
            [BaiduMob logEvent:@"id_my_equipment" eventLabel:@"list"];
            [@"WP://currentDevice_vc" open];
        } else {
            
            [UserAuthorManager authorizationLogin:nil andSuccess:^{
                
            } andFaile:^{
                
            }];
        }
        
    }]];
    [self.itemArray addObject:[[[WPSecurityBasicCellItem alloc] initWithDictionary:@{
                                                                                     @"title" : @"登录历史",
                                                                                     @"iconName" : @"iconfont_3",
                                                                                     @"hasRightView" : @"YES"
                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
        gUser.showShowAbnormal = @"0";
        if (ISLOGINED) {
            
            [BaiduMob logEvent:@"id_log_record" eventLabel:@"safe"];
            [@"WP://loginHistory_vc" open];
        } else {
            
            [UserAuthorManager authorizationLogin:nil andSuccess:^{
                
            } andFaile:^{
                
            }];
        }
        
    }]];
    [self.itemArray addObject:[[[WPSecurityBasicCellItem alloc] initWithDictionary:@{
                                                                                     @"title" : [gUser.isSet integerValue] ? @"修改密码" : @"设置密码",
                                                                                     @"iconName" : @"iconfont_4",
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
                                                                                     @"marginType" :                                                                                                                                                                                                                                                                                                                                    @(TZBasicCellBottomMargin)
                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
        [@"WP://WPPhoneNumController" openWithQuery:nil animated:YES];
    }]];
    
    [self.itemArray addObject:[[[WPSecurityBasicCellItem alloc] initWithDictionary:@{
                                                                                     @"headTitle" : @"登录保护",
                                                                                     @"title" : @"锁定帐号",
                                                                                     @"iconName" : @"iconfont_5",
                                                                                     @"marginType" : @(TZBasicCellTopMargin)
                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
        if (ISLOGINED) {
            
            [@"WP://lockingAccount_vc" open];
        } else {
            
            [UserAuthorManager authorizationLogin:nil andSuccess:^{
                
            } andFaile:^{
                
            }];
        }
    }]];
    [self.itemArray addObject:[[[WPSecurityBasicCellItem alloc] initWithDictionary:@{
                                                                                     @"title" : @"登录验证",
                                                                                     @"subTitle" : @"任何地方都需要手机验证",                                                                                    @"iconName" : @"iconfont_6",
                                                                                     @"marginType" : @(TZBasicCellBottomMargin)
                                                                                     }] applyActionBlock:^(UITableView *tableView, id info) {
        if (ISLOGINED) {
            
            [@"WP://loginVerification_vc" open];
        } else {
            
            [UserAuthorManager authorizationLogin:nil andSuccess:^{
                
            } andFaile:^{
                
            }];
        }
    }]];
}

#pragma mark - Event Reponse



#pragma mark - Delegate


#pragma mark - Getter and Setter

- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = [[NSMutableArray alloc] init];
        
    }
    return _itemArray;
}


#pragma mark - Public

#pragma mark - Three20

- (NSString *)title {
    return @"安全";
}


@end
