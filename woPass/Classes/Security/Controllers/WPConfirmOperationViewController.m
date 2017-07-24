//
//  WPConfirmOperationViewController.m
//  woPass
//
//  Created by htz on 15/11/2.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPConfirmOperationViewController.h"
#import "Masonry.h"
#import "NIAttributedLabel.h"

@interface WPConfirmOperationViewController ()

@end

@implementation WPConfirmOperationViewController

#pragma mark - Constructors and Life cycle


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.navigationController.navigationBar.height + 22, 0, 0, 0))];
    
    [self setupLogoView];
    [self setupLabel];
    [self setupButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - Private Method

- (void)setupLogoView {
    
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.image = [UIImage imageNamed:@"confirm_operatoin"];
    [self.tableView addSubview:logoView];
    [logoView x_sizeToFit];
    
    weaklySelf();
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(weakSelf.view.mas_centerX).with.offset(10);
        make.top.equalTo(weakSelf.tableView.mas_top).with.offset(35);
    }];
    
}

- (void)setupLabel {
    
    NIAttributedLabel *label0 = [NIAttributedLabel labelWithFontSize:kFontLarge color:RGBCOLOR_HEX(kLabelDarkColor)];
    label0.text = @"帐号存在盗号风险？";
    [self.tableView addSubview:label0];
    
    weaklySelf();
    [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.tableView);
        make.top.equalTo(weakSelf.tableView).with.offset(190);
    }];
    
    NIAttributedLabel *label1 = [NIAttributedLabel labelWithFontSize:kFontLarge color:RGBCOLOR_HEX(kLabelDarkColor)];
    label1.text = @"定期修改登录密码可以保证帐号安全";
    [self.tableView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(label0.mas_bottom).with.offset(5);
    }];

}

- (void)setupButton {
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftButton setTitle:@"锁定帐号" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:kFontLarge];
    [leftButton setTitleColor:RGBCOLOR_HEX(kLabelredColor) forState:UIControlStateNormal];
    [leftButton setBackgroundColor:[UIColor whiteColor]];
    leftButton.layer.cornerRadius = 4;
    leftButton.layer.borderColor = RGBCOLOR_HEX(kLabelredColor).CGColor;
    leftButton.layer.borderWidth = 1;
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView addSubview:leftButton];
    
    weaklySelf();
    
    CGFloat margin = (SCREEN_WIDTH - 290) / 3;
    
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(290 / 2, 75 / 2));
        make.top.equalTo(weakSelf.tableView.mas_top).with.offset(250);
        make.left.mas_equalTo(@(margin));
    }];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightButton setTitle:@"修改密码" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:kFontLarge];
    [rightButton setTitleColor:RGBCOLOR_HEX(kLabelredColor) forState:UIControlStateNormal];
    [rightButton setBackgroundColor:[UIColor whiteColor]];
    rightButton.layer.cornerRadius = 4;
    rightButton.layer.borderColor = RGBCOLOR_HEX(kLabelredColor).CGColor;
    rightButton.layer.borderWidth = 1;
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView addSubview:rightButton];
    
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(290 / 2, 75 / 2));
        make.top.equalTo(leftButton);
        make.left.equalTo(leftButton.mas_right).with.offset(margin);
    }];
}



#pragma mark - Event Reponse

- (void)leftButtonClick {
    
    [@"WP://lockingAccount_vc" open];
}


- (void)rightButtonClick {
    
    [@"WP://changPwd_vc" open];
}




#pragma mark - Delegate









#pragma mark - Getter and Setter







#pragma mark - Public


#pragma mark - Three20

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
    return @"验证操作";
}



@end
