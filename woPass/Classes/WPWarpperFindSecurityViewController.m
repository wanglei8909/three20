//
//  WPWarpperFindSecurityViewController.m
//  woPass
//
//  Created by htz on 15/7/25.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPWarpperFindSecurityViewController.h"
#import "WPFindSecurityController.h"

@interface WPWarpperFindSecurityViewController ()

@property (nonatomic, weak)WPFindSecurityController *findSecurityViewController;

@end

@implementation WPWarpperFindSecurityViewController

- (WPFindSecurityController *)findSecurityViewController {
    if (!_findSecurityViewController) {
        
        WPFindSecurityController *vc = [[WPFindSecurityController alloc] init];
        [self addChildViewController:vc];
        _findSecurityViewController = vc;
        
    }
    return _findSecurityViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.navigationController.navigationBar.height + 22, 0, 0, 0))];
    
    [self.tableView addSubview:self.findSecurityViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    return @"密码找回";
}

@end
