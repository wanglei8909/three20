//
//  WPNearbyAllItemsCtrl.m
//  woPass
//
//  Created by 王蕾 on 15/8/27.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPNearbyAllItemsCtrl.h"
#import "WPNearbyAllItemCell.h"
#import "WPNearbyPOIViewController.h"

@interface WPNearbyAllItemsCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation WPNearbyAllItemsCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArray = @[@[@"美食",@"中餐",@"川菜",@"肯德基",@"西餐",@"小吃快餐",@"火锅"],@[@"酒店",@"快捷酒店",@"星级酒店",@"青年旅社",@"旅馆",@"招待所",@"特价酒店"],@[@"休闲娱乐",@"电影院",@"KTV",@"酒吧",@"咖啡厅",@"网吧",@"商场",@"景点",@"丽人",@"洗浴"],@[@"交通设施",@"公交站",@"加油站",@"火车票代售点",@"长途汽车站",@"停车场",@"火车站"],@[@"生活服务",@"超市",@"药店",@"ATM",@"银行",@"医院",@"厕所"]];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-50)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = _dataArray[indexPath.row];
    float h = ((array.count-2)/3+1)*40+35+10;
    return h;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"WPNearbyAllItemCell";
    WPNearbyAllItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[WPNearbyAllItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.searchBlock = ^(NSString *content){
            
            [@"WP://WPNearbyPOIViewController" openWithQuery:@{
                                                              @"searchKey" :content
                                                              }];
        };
    }
    cell.indexPath = (int)indexPath.row;
    cell.items = _dataArray[indexPath.row];
    return cell;
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
    return @"周边快查";
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
