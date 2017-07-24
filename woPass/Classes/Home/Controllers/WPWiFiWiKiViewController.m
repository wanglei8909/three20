//
//  WPWiFiWiKiViewController.m
//  woPass
//
//  Created by htz on 15/8/16.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPWiFiWiKiViewController.h"

@interface WPWiFiWiKiViewController ()

@property (nonatomic, strong)UIImageView *wikiImageView;

@end

@implementation WPWiFiWiKiViewController

- (UIImageView *)wikiImageView {
    if (!_wikiImageView) {
        _wikiImageView = [[UIImageView alloc] init];
        _wikiImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wifiWiKi@2x" ofType:@"png"]];
        [self.tableView addSubview:_wikiImageView];
    }
    return _wikiImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.navigationController.navigationBar.height + 22, 0, 0, 0))];
    
    self.wikiImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 2986 / 320);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tableView.contentSize = self.wikiImageView.size;
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
    return @"WiFi使用教程";
}


@end
