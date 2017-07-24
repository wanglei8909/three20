//
//  WPSaoRaoChengJiuViewController.m
//  woPass
//
//  Created by 王蕾 on 16/2/26.
//  Copyright © 2016年 unisk. All rights reserved.
//

#import "WPSaoRaoChengJiuViewController.h"
#import "WPFangSaoRaoNavigation.h"
#import "SaoRaoChengjiuCell.h"

@interface WPSaoRaoChengJiuViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *mTableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UILabel *totalLabel;

@end

@implementation WPSaoRaoChengJiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArray = [[NSMutableArray alloc]initWithArray:@[@{
                                                            @"num":@"0280-asdasdasd",
                                                            @"type":@"房产中介"
                                                            },
                                                        @{
                                                            @"num":@"0280-asdasdasd",
                                                            @"type":@"房产中介"
                                                            },
                                                        @{
                                                            @"num":@"0280-asdasdasd",
                                                            @"type":@"房产中介"},
                                                        @{
                                                            @"num":@"0280-asdasdasd",
                                                            @"type":@"房产中介"
                                                            }]];
    
    
    weaklySelf();
    WPFangSaoRaoNavigation *navigation = [[WPFangSaoRaoNavigation alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 254)];
    navigation.iTitle = @"我的成就";
    navigation.backBlock = ^{
        [weakSelf dismiss];
    };
    [self.view addSubview:navigation];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 95, 95)];
    image.image = [UIImage imageNamed:@"saoraochengjiu"];
    image.center = CGPointMake(SCREEN_WIDTH*0.5, 64+90);
    [navigation addSubview:image];
    
    _totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, image.bottom+10, SCREEN_WIDTH, 30)];
    _totalLabel.textAlignment = NSTextAlignmentCenter;
    _totalLabel.textColor = [UIColor whiteColor];
    _totalLabel.text = @"已标记号码3个";
    [navigation addSubview:_totalLabel];
    
    _mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 254, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _mTableView.backgroundColor = [UIColor clearColor];
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    [self.view addSubview:_mTableView];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"SaoRaoChengjiuCell";
    SaoRaoChengjiuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[SaoRaoChengjiuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    [cell loadContent:_dataArray[indexPath.row]];
    
    return cell;
}



- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)hideNavigationBar
{
    return YES;
}

- (BOOL)hasYDNavigationBar
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
