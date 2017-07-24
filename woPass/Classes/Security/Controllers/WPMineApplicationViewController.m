//
//  WPMineApplicationViewController.m
//  woPass
//
//  Created by htz on 15/7/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMineApplicationViewController.h"
#import "WPMineAPPViewController.h"
#import "WPSegementController.h"
#import "WPHotAppViewController.h"

@interface WPMineApplicationViewController () <WPSegementControllerDelegate>

@property (nonatomic, strong)WPSegementController *appSwitchView;
@property (nonatomic, weak)WPMineAPPViewController *mineAppViewController;
@property (nonatomic, weak)WPHotAppViewController *hotAppViewController;
@property (nonatomic, assign)BOOL shoudLoad;


@end

@implementation WPMineApplicationViewController

- (WPSegementController *)appSwitchView {
    if (!_appSwitchView) {
        _appSwitchView = [[WPSegementController alloc] init];
        _appSwitchView.delegate = self;
        [self.tableView addSubview:_appSwitchView];
    }
    return _appSwitchView;
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
    self.tableView.scrollEnabled = NO;
    
    [self setupMineAppViewController];
    [self setupHotAppViewController];
    self.shoudLoad = YES;
    
    [self.mineAppViewController generateContent];

}

- (void)setupMineAppViewController {
    WPMineAPPViewController *mineAppViewController = [[WPMineAPPViewController alloc] init];
    mineAppViewController.view.frame = UIEdgeInsetsInsetRect(self.tableView.bounds, UIEdgeInsetsMake(58, 0, 0, 0));
    self.mineAppViewController = mineAppViewController;
    [self addChildViewController:mineAppViewController];
    [self.tableView addSubview:mineAppViewController.view];
    mineAppViewController.view.left = 0;
}

- (void)setupHotAppViewController {
    WPHotAppViewController *hotAPPViweControler = [[WPHotAppViewController alloc] init];
    hotAPPViweControler.view.frame = UIEdgeInsetsInsetRect(self.tableView.bounds, UIEdgeInsetsMake(58, 0, 0, 0));
    [self addChildViewController:hotAPPViweControler];
    self.hotAppViewController = hotAPPViweControler;
    [self.tableView addSubview:hotAPPViweControler.view];
    hotAPPViweControler.view.right = 0;
}
- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50 - 55)];
}

- (void)WPSegementController:(WPSegementController *)segementController FirstButtonDidClicked:(UIButton *)button {
    
    weaklySelf();
//    [self.mineAppViewController generateContent];
    [UIView animateWithDuration:0.3 animations:^{
        
        weakSelf.mineAppViewController.view.left -= SCREEN_WIDTH;
        weakSelf.hotAppViewController.view.left -= SCREEN_WIDTH;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)WPSegementController:(WPSegementController *)segementController secondButtonDidClicked:(UIButton *)button {
    
    weaklySelf();
    
    if (self.shoudLoad) {
        
        [BaiduMob logEvent:@"id_app" eventLabel:@"hot"];
        [self.hotAppViewController getPageContent];
        self.shoudLoad = NO;
    }
    [UIView animateWithDuration:0.3 animations:^{
        
        weakSelf.mineAppViewController.view.left += SCREEN_WIDTH;
        weakSelf.hotAppViewController.view.left += SCREEN_WIDTH;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.appSwitchView.frame = CGRectMake(20, 10, (self.tableView.width - 40), 37);
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
    return @"我的应用";
}
@end
