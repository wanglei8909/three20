//
//  WPSSOViewController.m
//  woPass
//
//  Created by htz on 15/10/10.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPSSOViewController.h"
#import "WPSSOManager.h"
#import "WPSsoViewAdapter.h"
#import "WPSsoView.h"
#import "WPButton.h"
#import "NIAttributedLabel.h"

typedef NS_ENUM(NSUInteger, WPSSOFetchInfoStatus) {
    WPSSOInfoSuccess,
    WPSSOInfoFailure,
};

@interface WPSSOViewController ()

@property (nonatomic, strong)WPSSOManager *ssoManager;
@property (nonatomic, strong)WPSsoView *ssoView;
@property (nonatomic, strong)WPSsoViewAdapter *ssoViewAdapter;
@property (nonatomic, strong)WPButton *loginButton;
@property (nonatomic, strong)NIAttributedLabel *stateLabel;

@end

@implementation WPSSOViewController


#pragma mark - private

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.navigationController.navigationBar.height + 22, 0, 0, 0))];
    
    weaklySelf();
    [self setupItemButton];
    [self showPage:NO status:WPSSOInfoFailure];
    [self fetchPageContent];
    [self.ssoViewAdapter applyValueChangedAction:^{
        
        [weakSelf.ssoView setContentWithModel:weakSelf.ssoViewAdapter];
    }];
}

- (void)setupItemButton {

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitleColor:RGBCOLOR_HEX(KTextOrangeColor) forState:UIControlStateNormal];
    backButton.titleLabel.font = XFont(kFontLarge);
    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backButton x_sizeToFit];
    self.xNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.xNavigationItem.leftBarButtonItem.customView.hidden = YES;
    
    UIButton *retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [retryButton setTitleColor:RGBCOLOR_HEX(KTextOrangeColor) forState:UIControlStateNormal];
    retryButton.titleLabel.font = XFont(kFontLarge);
    [retryButton setTitle:@"重试" forState:UIControlStateNormal];
    [retryButton addTarget:self action:@selector(retryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [retryButton x_sizeToFit];
    self.xNavigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:retryButton];
}

- (void)fetchPageContent {
    
    weaklySelf();
    [self showLoading:YES];
    [self checkLoginStatusAndTryLogin:^(BOOL isLogin, NSString *msg) {
        
        [weakSelf hideLoading:YES];
        if (isLogin) {
            
            [weakSelf showLoading:YES];
            [weakSelf.ssoManager fetchThirdPartyAppInfoWithComplete:^(id info, NSString *msg) {
                
                [weakSelf hideLoading:YES];
                [weakSelf showHint:msg hide:1];
                if (!msg) {
                    
                    [weakSelf showPage:YES status:WPSSOInfoSuccess];
                    [weakSelf.ssoViewAdapter setWithDic:info];
                    weakSelf.xNavigationItem.leftBarButtonItem.customView.hidden = NO;
                } else {
                    
                    [weakSelf showPage:YES status:WPSSOInfoFailure];
                }
            }];
        } else {
            
            [weakSelf showHint:msg hide:1];
        }
    }];
}

- (void)checkLoginStatusAndTryLogin:(void (^)(BOOL isLogin, NSString *msg))complete {
    
    //随便进行一个请求，是否登录
    if (ISLOGINED) {
        
        [RequestManeger POST:@"/u/bindEmailInfo" parameters:nil complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
            
            if (!msg) {
                
                complete(YES, nil);
            } else {
                
                complete(NO, msg);
            }
        })];
    } else {
        
        [UserAuthorManager authorizationLogin:self andSuccess:^{
            
            complete(YES, nil);
        } andFaile:^{
            
            complete(NO, @"登录失败");
        } alwaysShowLogin:NO animation:NO enableBack:NO];
    }
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    self.ssoView.size = CGSizeMake(SCREEN_WIDTH, SCALED(170));
    self.ssoView.top = SCALED(kPadding);
    
    self.loginButton.size = CGSizeMake(SCALED(290), SCALED(40));
    self.loginButton.centerX = SCREEN_WIDTH / 2;
    self.loginButton.top = self.ssoView.bottom + SCALED(15);
    
    [self.stateLabel x_sizeToFit];
    self.stateLabel.centerX = SCREEN_WIDTH / 2;
    self.stateLabel.centerY = SCREEN_HEIGHT / 3;
}

- (void)backButtonClick:(UIButton *)button {
    
    [self.ssoManager backToThirdPartyAppWithStatus:WPSSOStatusFailure location:nil];
}

- (void)retryButtonClick:(UIButton *)button {
    
    [self fetchPageContent];
}

- (void)loginButtonClick:(UIButton *)button {
    
    weaklySelf();
    [self.ssoManager obtainAuthForUser:gUser.userId scopes:@"user_info,user_mobile" WithComplete:^(id info, NSString *msg) {
       
        if (!msg) {
            
            [weakSelf.ssoManager backToThirdPartyAppWithStatus:WPSSOStatusSucess location:info];
        } else {
            
            [weakSelf.ssoManager backToThirdPartyAppWithStatus:WPSSOStatusFailure location:nil];
        }
    }];
}

- (void)showPage:(BOOL)isShowPage status:(WPSSOFetchInfoStatus)status {
    
    if (isShowPage) {
        
        self.tableView.hidden = NO;
    } else {
        
        self.tableView.hidden = YES;
    }
    if (status == WPSSOInfoSuccess) {
        
        self.loginButton.hidden = NO;
        self.ssoView.hidden = NO;
        self.stateLabel.hidden = YES;
    } else if (status == WPSSOInfoFailure) {
        
        self.loginButton.hidden = YES;
        self.ssoView.hidden = YES;
        self.stateLabel.hidden = NO;
    }
}

#pragma mark -- setter&getter

- (NIAttributedLabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [NIAttributedLabel labelWithFontSize:kFontLarge color:RGBCOLOR_HEX(kLabelDarkColor)];
        _stateLabel.hidden = YES;
        _stateLabel.text = @"系统繁忙，登录失败";
        [self.tableView addSubview:_stateLabel];
    }
    return _stateLabel;
}

- (WPSSOManager *)ssoManager {
    if (!_ssoManager) {
        _ssoManager = [[WPSSOManager alloc] init];
        
    }
    return _ssoManager;
}

- (WPButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[WPButton alloc] initWithTitle:@"登录"];
        [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView addSubview:_loginButton];
    }
    return _loginButton;
}

- (WPSsoView *)ssoView {
    if (!_ssoView) {
        _ssoView = [[WPSsoView alloc] initWithContentModel:self.ssoViewAdapter];
        weaklySelf();
        [_ssoView applyChangeAccountLabelCick:^{
           
            [UserAuthorManager authorizationLogin:nil andSuccess:^{
                
                [weakSelf fetchPageContent];
            } andFaile:^{
                
            } alwaysShowLogin:YES];
        }];
        [self.tableView addSubview:_ssoView];
    }
    return _ssoView;
}

- (WPSsoViewAdapter *)ssoViewAdapter {
    if (!_ssoViewAdapter) {
        _ssoViewAdapter = [[WPSsoViewAdapter alloc] init];
    }
    return _ssoViewAdapter;
}

#pragma mark -- Three20

- (BOOL)hideNavigationBar
{
    return YES;
}

- (BOOL)hasYDNavigationBar
{
    return YES;
}

- (NSString *)title {
    return @"沃通行证登录";
}

@end
