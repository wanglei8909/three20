//
//  WPNearbyPOIViewController.m
//  woPass
//
//  Created by 王蕾 on 15/8/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPNearbyPOIViewController.h"
#import <BaiduMapAPI/BMKPoiSearch.h>
#import <BaiduMapAPI/BMKPoiSearchOption.h>
#import "WPNearListCell.h"
#import "WPNearbyDetailController.h"
#import "MJRefresh.h"
#import "WPNearbyInfo.h"
#import "Reachability.h"

@interface WPNearbyPOIViewController ()<BMKPoiSearchDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) BMKPoiSearch *searcher;
@property (nonatomic, assign) int curPage;
@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) NSString *searchKey;

@end

@implementation WPNearbyPOIViewController

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query{
    self = [super initWithNavigatorURL:URL query:query];
    if (self) {
        _searchKey = query[@"searchKey"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [BaiduMob logEvent:@"id_local_search" eventLabel:_searchKey];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    _dataArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    _curPage = 0;
    
    _mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
    _mTableView.backgroundColor = [UIColor clearColor];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mTableView];
    
    _searcher =[[BMKPoiSearch alloc]init];
    _searcher.delegate = self;
    
    NSLog(@"%@.........%@", gUser.lat, gUser.lng);
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        //未打开定位
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在设置里打开位置服务" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }else{
        [self GoSearch];
        
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self dismiss];
    }
}
- (void)GoSearch{
    Reachability *r = [Reachability reachabilityForInternetConnection];
    if ([r currentReachabilityStatus]==0) {
        [self ShowNoNetWithRelodAction:^{
            [self GoSearch];
        }];
        return;
    }
    __block BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = _curPage;
    option.sortType = BMK_POI_SORT_BY_DISTANCE;
    option.pageCapacity = 10;
    double lat = [gUser.lat doubleValue];
    double lng = [gUser.lng doubleValue];
    NSLog(@"**************获取位置*********\n%f\n%f",lat,lng);
    option.location = CLLocationCoordinate2DMake(lat, lng);
    option.keyword = _searchKey;
    option.radius = 3000;
    BOOL flag = [_searcher poiSearchNearBy:option];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
    weaklySelf();
    _mTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.curPage++;
        option.pageIndex = weakSelf.curPage;
        BOOL flag = [weakSelf.searcher poiSearchNearBy:option];
        if(flag)
        {
            NSLog(@"周边检索发送成功");
        }
        else
        {
            NSLog(@"周边检索发送失败");
        }
    }];
}


//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        for (BMKPoiInfo *info in poiResultList.poiInfoList) {
            NSLog(@"----->%@",info.name);
            WPNearbyInfo *mInfo = [[WPNearbyInfo alloc]init];
            mInfo.name = info.name;
            mInfo.uid = info.uid;
            mInfo.address = info.address;
            mInfo.phone = info.phone;
            mInfo.pt = info.pt;
            
            [_dataArray addObject:mInfo];
            //初始化检索服务
            weaklySelf();
            BMKPoiSearch *poisearch = [[BMKPoiSearch alloc] init];
            poisearch.delegate = weakSelf;
            //POI详情检索
            BMKPoiDetailSearchOption* option = [[BMKPoiDetailSearchOption alloc] init];
            option.poiUid = info.uid;//POI搜索结果中获取的uid
            BOOL flag = [poisearch poiDetailSearch:option];
            if(flag)
            {
                //详情检索发起成功
            }
            else
            {
                //详情检索发送失败
            }
            
        }
        
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
        if (_curPage == 0) {
            [self showHint:@"抱歉，未找到结果" hide:1];
        }
    }
    
    if (poiResultList.poiInfoList.count<10) {
        [_mTableView.footer noticeNoMoreData];
    }else{
        [_mTableView.footer resetNoMoreData];
    }
}
-(void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPoiDetailResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode
{
    if(errorCode == BMK_SEARCH_NO_ERROR){
        for (WPNearbyInfo *mInfo in _dataArray) {
            if ([mInfo.uid isEqualToString:poiDetailResult.uid]) {
                mInfo.price = poiDetailResult.price;
                mInfo.overallRating = poiDetailResult.overallRating;
                mInfo.detailUrl = poiDetailResult.detailUrl;
                break;
            }
        }
    }
    [_mTableView reloadData];
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _searcher.delegate = self;
}
//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _searcher.delegate = nil;
}
- (void)dealloc{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WPNearbyInfo *info = _dataArray[indexPath.row];
    if (info.overallRating==0) {
        return 105;
    }
    return 125;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"WPNearListCell";
    WPNearListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[WPNearListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.indexPath = (int)indexPath.row+1;
    WPNearbyInfo *info = _dataArray[indexPath.row];
    cell.info = info;
    
    return cell;
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
    return _searchKey;
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
