//
//  WPLoginHistoryDetailViewController.m
//  woPass
//
//  Created by htz on 15/10/29.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPLoginHistoryDetailViewController.h"
#import "WPLoginDetailProtocol.h"
#import "Masonry.h"
#import "NIAttributedLabel.h"
#import "JMWhenTapped.h"

#define kHeaderMargin 42
#define kContaintHeight 200

typedef NS_ENUM(NSUInteger, WPLoginDetailViewType) {
    EBkView = 0xff,
    EAppHeaderView,
};

@interface WPLoginHistoryDetailViewController ()

@property (nonatomic, weak)id<WPLoginDetailProtocol> model;

@end

@implementation WPLoginHistoryDetailViewController

#pragma mark - Constructors and Life cycle

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query {
    
    if (self = [super initWithNavigatorURL:URL query:query]) {
        
        self.model = query[@"model"];
    }
    return self;
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
    
    [self setupBkView];
    [self setupAppView];
    [self setupMargins];
    [self setupButton];
}





#pragma mark - Private Method

- (void)setupBkView  {
    
    UIView *bkView = [[UIView alloc] init];
    bkView.tag = EBkView;
    bkView.backgroundColor = [UIColor whiteColor];
    bkView.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
    bkView.layer.borderWidth = 1;
    [self.tableView addSubview:bkView];
    
    weaklySelf();
    [bkView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCALED(kContaintHeight)));
        make.top.equalTo(weakSelf.tableView).with.offset(SCALED(10));
    }];
}

- (void)setupAppView {
    
    UIView *bkView = [self.tableView viewWithTag:EBkView];
    
    UIImageView *imagView = [[UIImageView alloc] init];
    if ([self.model.deviceType isEqualToString:@"pc"]) {
        
        imagView.image = [UIImage imageNamed:@"computer-detail"];
    } else {
        
        imagView.image = [UIImage imageNamed:@"iphone-detail"];
    }
    [imagView x_sizeToFit];
    imagView.size = CGSizeMake(SCALED(imagView.width), SCALED(imagView.height));
    [bkView addSubview:imagView];
    
    NIAttributedLabel *appNameLabel = [NIAttributedLabel labelWithFontSize:kFontLarge color:RGBCOLOR_HEX(kLabelDarkColor)];
    appNameLabel.text = self.model.loginAppName;
    [appNameLabel x_sizeToFit];
    [bkView addSubview:appNameLabel];
    
    CGFloat width = imagView.width + SCALED(10) + appNameLabel.width;
    
    [imagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bkView.mas_centerX).with.offset(-width / 2);
        make.centerY.equalTo(bkView.mas_top).with.offset(SCALED(kHeaderMargin));
    }];
    
    [appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(bkView.mas_top).with.offset(SCALED(kHeaderMargin));
        make.right.equalTo(bkView.mas_centerX).with.offset(width / 2);
    }];
}

- (void)setupMargins {
    UIView *bkView = [self.tableView viewWithTag:EBkView];

    CGFloat headerHeight = SCALED(2 * kHeaderMargin);
    CGFloat padding = (SCALED(kContaintHeight) - headerHeight) / 3;
    
    NSArray *title = @[@"地点: ", @"时间: ", @"状态: "];
    
    NSString *status = [self.model.remoteLogin integerValue] ? @"异常登录" : @"正常登录";
    NSString *timeStamp = [[self.model.detailLoginTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"] substringToIndex:self.model.detailLoginTime.length - 3];
    NSString *location = [NSString stringWithFormat:@"%@ ( IP: %@ ) ", self.model.loginCity, self.model.loginIP];
    
    NSArray *content = @[location, timeStamp, status];
    
    for (NSInteger i = 0; i < 3; i ++) {
        
        UIView *marginView = [[UIView alloc] init];
        marginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [bkView addSubview:marginView];
        
        NIAttributedLabel *label = [NIAttributedLabel labelWithFontSize:kFontLarge color:RGBCOLOR_HEX(kLabelDarkColor)];
        label.text = [NSString stringWithFormat:@"%@   %@", title[i], content[i]];
        if ([content[i] isEqualToString:@"异常登录"]) {
            
            [label setTextColor:RGBCOLOR_HEX(kLabelredColor) range:NSMakeRange(label.text.length - 4, 4)];
        }
        [label setTextColor:RGBCOLOR_HEX(kLabelWeakColor) range:NSMakeRange(0, 2)];
        [bkView addSubview:label];
        
        [marginView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(bkView).with.offset(SCALED(12));
            make.right.equalTo(bkView);
            make.height.mas_equalTo(@(1));
            make.top.equalTo(bkView.mas_bottom).with.offset(- (i + 1) * padding);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(marginView).with.offset(SCALED(3));
            make.centerY.equalTo(bkView.mas_bottom).with.offset(- ((padding / 2) + padding * i ));
        }];
        
    }
}

- (void)setupButton {
    
    UIView *bkView = [self.tableView viewWithTag:EBkView];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"不是我操作" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:kFontLarge];
    [button setTitleColor:RGBCOLOR_HEX(kLabelredColor) forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.layer.cornerRadius = 4;
    button.layer.borderColor = RGBCOLOR_HEX(kLabelredColor).CGColor;
    button.layer.borderWidth = 1;
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(290 / 2, 75 / 2));
        make.centerX.equalTo(bkView);
        make.top.equalTo(bkView.mas_bottom).with.offset(100);
    }];

}



#pragma mark - Event Reponse

- (void)buttonClick {
    
    [@"WP://WPConfirmOperationViewController" open];
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
    return @"历史详情";
}

@end
