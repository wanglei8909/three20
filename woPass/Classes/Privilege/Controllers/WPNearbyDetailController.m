//
//  WPNearbyDetailController.m
//  woPass
//
//  Created by 王蕾 on 15/8/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPNearbyDetailController.h"
#import <BaiduMapAPI/BMKPoiSearch.h>
#import <BaiduMapAPI/BMKPoiSearchOption.h>

@interface WPNearbyDetailController ()<BMKPoiSearchDelegate>

@property (nonatomic, strong) BMKPoiSearch *poisearch;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation WPNearbyDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114)];
    _textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_textView];
    
    //初始化检索服务
    _poisearch = [[BMKPoiSearch alloc] init];
    _poisearch.delegate = self;
    //POI详情检索
    BMKPoiDetailSearchOption* option = [[BMKPoiDetailSearchOption alloc] init];
    option.poiUid = self.uid;//POI搜索结果中获取的uid
    BOOL flag = [_poisearch poiDetailSearch:option];
    if(flag)
    {
        //详情检索发起成功
    }
    else
    {
        //详情检索发送失败
    }
    
    
}

-(void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPoiDetailResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode
{
    if(errorCode == BMK_SEARCH_NO_ERROR){
        /*
        tag
        detailUrl
        type
        price
        overallRating
        tasteRating
        serviceRating
        environmentRating
        facilityRating
        hygieneRating
        technologyRating
        imageNum
        grouponNum
        commentNum
        favoriteNum
        checkInNum
        shopHours*/
        //在此处理正常结果
        _textView.text = [NSString stringWithFormat:@"标签：%@，详情网址：%@，分类：%@，价格：%f，综合评分：%f,口味评分：%f,服务评分：%f,环境评分：%f,设施评分：%f,卫生评分：%f,技术评分：%f,图片数目：%d,团购数目：%d,评论数目：%d,收藏数目：%d,签到数目：%d,营业时间：%@",poiDetailResult.tag,poiDetailResult.detailUrl,poiDetailResult.type,poiDetailResult.price,poiDetailResult.overallRating,poiDetailResult.tasteRating,poiDetailResult.serviceRating,poiDetailResult.environmentRating,poiDetailResult.facilityRating,poiDetailResult.hygieneRating,poiDetailResult.technologyRating,poiDetailResult.imageNum,poiDetailResult.grouponNum,poiDetailResult.commentNum,poiDetailResult.favoriteNum,poiDetailResult.checkInNum,poiDetailResult.shopHours];
        
    }
}


- (BOOL)hideNavigationBar
{
    return YES;
}

- (BOOL)hasYDNavigationBar
{
    return NO;
}

- (BOOL)autoGenerateBackBarButtonItem
{
    return YES;
}

- (NSString *)title {
    return @"详情";
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
