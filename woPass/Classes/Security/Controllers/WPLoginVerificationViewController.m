//
//  WPLoginVerificationViewController.m
//  woPass
//
//  Created by htz on 15/7/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLoginVerificationViewController.h"
#import "WPLoginVerificationComCellItem.h"
#import "WPLoginVerificationHeadCellItem.h"

@interface WPLoginVerificationViewController ()

@property (nonatomic, strong)NSMutableArray *itemsArray;


@end

@implementation WPLoginVerificationViewController

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
    
    [self.itemsArray addObject:[[WPLoginVerificationHeadCellItem alloc] init]];
    [self.itemsArray addObject:[[WPLoginVerificationComCellItem alloc] init]];
    
    self.items = @[self.itemsArray];
    
    [self getPageContent];
    
    weaklySelf();
    [[NSNotificationCenter defaultCenter] addObserverForName:WPSwitchChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        [weakSelf settingChange:note withSuccess:^{
            
            [weakSelf showHint:@"设置成功" hide:1];
        }];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:WPSelectCityNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        [weakSelf settingChange:note withSuccess:nil];
    }];
    
    [self.KVOControllerNonRetaining observe:gUser keyPath:@"commonLoginPlace" block:^(id observer, id object, id oldValue, id newVale) {
        
        [weakSelf.tableView reloadData];
    }];
}

- (void)getPageContent {
    
    weaklySelf();
    [self showLoading:YES];
    [RequestManeger POST:@"/u/loginProtect" parameters:nil complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        [weakSelf hideLoading:YES];
        [weakSelf showHint:msg hide:1];
        if (!msg) {
            
            gUser.isLoginProtect = [[[[responseObject objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"loginProtect"] stringValue];
            gUser.commonLoginPlace = [[[responseObject objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"commonLoginPlace"];
        }
    })];
}

- (void)settingChange:(id)info withSuccess:(void (^)(void)) action{
    id obj = [info valueForKey:@"object"];
    
    if (ISLOGINED) {
        
        if (![obj isKindOfClass:[NSString class]]) {
            
            gUser.isLoginProtect = [gUser.isLoginProtect boolValue] ? @"0" : @"1";
        }
        
        // 完全保护
        if ([gUser.isLoginProtect boolValue]) {
            
            [BaiduMob logEvent:@"id_log_protect" eventLabel:@"all"];
        } else {
            
            [BaiduMob logEvent:@"id_log_protect" eventLabel:@"diy"];
        }
        [self.tableView reloadData];
    }
    
    weaklySelf();
    [RequestManeger POST:@"/u/modifyLoginProtect" parameters:@{
                                                               @"commonLoginPlace" : gUser.commonLoginPlace,
                                                               @"loginProtect" : gUser.isLoginProtect
                                                               } complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        [weakSelf showHint:msg hide:1];
        
        if (!msg) {
            
            if (action) {
                
                action();
            }
        }
    })];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50 - 55)];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    return @"登录验证";
}

@end
