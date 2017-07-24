//
//  WPAffiliationViewController.m
//  woPass
//
//  Created by htz on 15/7/31.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPAffiliationViewController.h"
#import "NIAttributedLabel.h"
#import "WPTextField.h"
#import "WPButton.h"

@interface WPAffiliationViewController ()

@property (nonatomic, strong)NIAttributedLabel *titleLabel;
@property (nonatomic, strong)WPTextField *phoneNumberField;
@property (nonatomic, strong)WPButton *searchButton;

@end

@implementation WPAffiliationViewController

- (NIAttributedLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [NIAttributedLabel labelWithFontSize:kFontTiny color:RGBCOLOR_HEX(kLabelDarkColor)];
        _titleLabel.text = @"手机号码归属地查询是中国联通为用户提供的一项特殊服务，可根据输入的手机号码查询出此号码所属的省份";
        _titleLabel.numberOfLines = 0;
        [self.tableView addSubview:_titleLabel];
        
        CGSize labelSize = [_titleLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : XFont(kFontTiny)                                                                          } context:NULL].size;
        
        _titleLabel.size = labelSize;
        _titleLabel.top = 20;
        _titleLabel.left = 20;
    }
    return _titleLabel;
}
- (WPTextField *)phoneNumberField {
    if (!_phoneNumberField) {
        _phoneNumberField = [[WPTextField alloc] initWithPlaceholder:@"请输入手机号码" placeholderColor:RGBCOLOR_HEX(kPlaceHolderColor)];
        [self.tableView addSubview:_phoneNumberField];
    }
    return _phoneNumberField;
}
- (WPButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [[WPButton alloc] initWithTitle:@"查询"];
        [_searchButton addTarget:self action:@selector(clickSearchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView addSubview:_searchButton];
    }
    return _searchButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.navigationController.navigationBar.height + 22, 0, 0, 0))];
    
    [self titleLabel];
    [self phoneNumberField];
    [self searchButton];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.searchButton.width = 88;
    self.searchButton.height = 44;
    self.searchButton.top = self.titleLabel.bottom + 20;
    self.searchButton.right = SCREEN_WIDTH - 20;
    
    self.phoneNumberField.height = 44;
    self.phoneNumberField.width = SCREEN_WIDTH - self.searchButton.width - 15 - 20 - 20;
    self.phoneNumberField.top = self.titleLabel.bottom + 20;
    self.phoneNumberField.left = 15;
}


- (void)clickSearchButton:(UIButton *)button {
    
    [self showHint:@"咱不提供服务" hide:1];
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
    
    return @"归属地查询";
}

@end
