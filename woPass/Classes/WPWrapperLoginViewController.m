//
//  WPWrapperLoginViewController.m
//  woPass
//
//  Created by htz on 15/7/25.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPWrapperLoginViewController.h"
#import "WPLoginRegisterViewController.h"

@interface WPWrapperLoginViewController ()

@property (nonatomic, weak)WPLoginRegisterViewController *loginViewController;
@property (nonatomic, assign)BOOL enableBack;

@end

@implementation WPWrapperLoginViewController

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query {
    
    if (self = [super initWithNavigatorURL:URL query:query]) {
        
        self.loginViewController.loginFinish = query[@"loginFinish"];
        self.enableBack = [query[@"enableBack"] boolValue];
    }
    return self;
}

- (WPLoginRegisterViewController *)loginViewController {
    if (!_loginViewController) {
        
        WPLoginRegisterViewController *vc = [[WPLoginRegisterViewController alloc] init];
        [self addChildViewController:vc];
        self.loginViewController = vc;
    }
    return _loginViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.navigationController.navigationBar.height + 22, 0, 0, 0))];
    
    [self.tableView addSubview:self.loginViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50 - 55)];
}

- (void)dismiss {
    if (self.enableBack) {
        
        [super dismiss];
    } else {
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    self.loginViewController.loginFinish(@{});
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
    return @"登录";
}


@end
