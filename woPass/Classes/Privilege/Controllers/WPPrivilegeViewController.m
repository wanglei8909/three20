//
//  WPPrivilegeViewController.m
//  woPass
//
//  Created by htz on 15/7/6.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPPrivilegeViewController.h"
#import "GCPagingView.h"
#import "BannerView.h"
#import "WPPriAdModel.h"
#import "WPPriActListModel.h"
#import "WPPriWelfaresModel.h"
#import "WPAppListModel.h"
#import "UIImageView+WebCache.h"
#import "WPTiketController.h"
#import "WPMoreServiceController.h"
#import "WPURLManager.h"
#import "WPAliPayManager.h"
#import "WPUMShareManeger.h"
#import "MJRefresh.h"
#import "WPWelfaresBtn.h"
#import "WPNearbyPOIViewController.h"
#import "WPNearbyAllItemsCtrl.h"
#import "WPAliPayManager.h"
#import "WPUserPortrayCtrl.h"

#define scale SCREEN_WIDTH/320

@interface WPPrivilegeViewController ()<GCPagingViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) GCPagingView *mPageView;
@property (nonatomic, strong) UIView *welfaresView;
@property (nonatomic, strong) UIView *appView;
@property (nonatomic, strong) UIView *actView;
@property (nonatomic, strong) NSMutableArray *adList;
@property (nonatomic, strong) NSMutableArray *welfaresList;
@property (nonatomic, strong) NSMutableArray *appList;
@property (nonatomic, strong) NSMutableArray *actList;

@end

@implementation WPPrivilegeViewController

- (void)initArray{
    _adList = [[NSMutableArray alloc]initWithCapacity:10];
    _welfaresList  = [[NSMutableArray alloc]initWithCapacity:10];
    _appList = [[NSMutableArray alloc]initWithCapacity:10];
    _actList = [[NSMutableArray alloc]initWithCapacity:10];
}
- (void)CityChange:(NSNotification *)not{
    [_scrollerView.header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CityChange:) name:WPSelectCityNotification object:nil];
    
    [self initArray];
    
    _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114)];
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollerView];
    
    NSArray *idleImages = @[[UIImage imageNamed:@"s1"]];
    NSArray *refreshingImages = @[[UIImage imageNamed:@"s1"],[UIImage imageNamed:@"s2"],[UIImage imageNamed:@"s3"],[UIImage imageNamed:@"s4"],[UIImage imageNamed:@"s5"],[UIImage imageNamed:@"s6"],[UIImage imageNamed:@"s7"],[UIImage imageNamed:@"s8"]];
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [header setImages:idleImages forState:MJRefreshStateIdle];
    [header setImages:idleImages forState:MJRefreshStatePulling];
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    _scrollerView.header = header;
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(-1, 0, SCREEN_WIDTH+2, 215 * scale)];
    _topView.backgroundColor =[UIColor whiteColor];
    _topView.layer.borderWidth = 1;
    _topView.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
    [_scrollerView addSubview:_topView];
    
    _mPageView = [[GCPagingView alloc]initWithFrame:CGRectMake(1, 0, _topView.width-2, 137 * scale)];
    _mPageView.delegate = self;
    [_topView addSubview:_mPageView];
    
    _welfaresView = [[UIView alloc]initWithFrame:CGRectMake(0, _mPageView.bottom, _mPageView.width, (215-137)*scale)];
    [_topView addSubview:_welfaresView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _mPageView.width, 1)];
    line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
    [_welfaresView addSubview:line];
    
    _appView = [[UIView alloc]initWithFrame:CGRectMake(-1, _topView.bottom+10, SCREEN_WIDTH+2, 170)];
    _appView.backgroundColor =[UIColor whiteColor];
    _appView.layer.borderWidth = 1;
    _appView.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
    [_scrollerView addSubview:_appView];
    
    _actView = [[UIView alloc]initWithFrame:CGRectMake(-1, _appView.bottom+10, SCREEN_WIDTH+2, 150*5*scale)];
    _actView.backgroundColor =[UIColor whiteColor];
    _actView.layer.borderWidth = 1;
    _actView.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
    [_scrollerView addSubview:_actView];
    //274
    [_scrollerView.header beginRefreshing];
}
- (void)loadNewData{
    [self RequestToHttps];
}

- (void)ReloadUI{
    [self ReloadPageView];
    [self ReloadWelfaresView];
    [self ReloadAppView];
    [self ReloadActView];
    _scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, _actView.bottom+50);
}
- (void)ReloadPageView{
    [_mPageView reloadData];
    if (_adList.count == 0) {
        _mPageView.height = 0;
    }else{
        _mPageView.height = 137 * scale;
    }
}
- (void)ReloadWelfaresView{
    [_welfaresView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _welfaresView.frame = CGRectMake(0, _mPageView.bottom, _mPageView.width, (215-137)*scale);
    _topView.height = _welfaresView.bottom;
    if (_welfaresList.count == 1) {
        WPPriWelfaresModel *model = _welfaresList[0];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, SCREEN_WIDTH, (215-137)*scale);
        btn.tag = 100;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_welfaresView addSubview:btn];
        
        UIImageView *tImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5-100, 20, 50, 50)];
        [tImage sd_setImageWithURL:[NSURL URLWithString:model.img]];
        [btn addSubview:tImage];
        
        UILabel *tLabel = [[UILabel alloc]initWithFrame:CGRectMake(tImage.right+10, tImage.top, 200, 20)];
        //tLabel.textColor = RGBCOLOR_HEX(0xb44aea);
        tLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        tLabel.font = [UIFont systemFontOfSize:14];
        tLabel.text = model.mainTitle;
        [btn addSubview:tLabel];
        
        UILabel *bLabel = [[UILabel alloc]initWithFrame:CGRectMake(tImage.right+10, tLabel.bottom , 200, 20)];
        bLabel.textColor = RGBCOLOR_HEX(0x999999);
        bLabel.text = model.subTitle;
        bLabel.font = [UIFont systemFontOfSize:12];
        [btn addSubview:bLabel];
        
    }else{
        for (int i = 0; i<(_welfaresList.count>2?2:_welfaresList.count); i++) {
            WPWelfaresBtn *btn = [WPWelfaresBtn buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*SCREEN_WIDTH*0.5, 0, SCREEN_WIDTH*0.5, (215-137)*scale);
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn LoadContentUI:_welfaresList[i]];
            [_welfaresView addSubview:btn];
        }
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5, 15, 1, (215-137)*scale-30)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [_welfaresView addSubview:line];
    }
}
- (void)ReloadActView{
    [_actView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [[_scrollerView viewWithTag:3000] removeFromSuperview];
    
    if (_appList.count == 0) {
        _actView.top = _topView.bottom + 10;
    }else{
        _actView.top = _appView.bottom + 10;
    }
    
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 30)];
    title.backgroundColor =[UIColor clearColor];
    title.textColor = RGBCOLOR_HEX(kLabelDarkColor);
    title.font = [UIFont systemFontOfSize:16];
    title.text = @"精彩活动";
    [_actView addSubview:title];
    
    UIImageView *acc = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"youjiantou-"]];
    acc.center = title.center;
    acc.left = SCREEN_WIDTH-20;
    acc.image = [UIImage imageNamed:@"youjiantou-"];
    [_actView addSubview:acc];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.backgroundColor = [UIColor clearColor];
    moreBtn.frame = title.bounds;
    [moreBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.tag = 3001;
    [title addSubview:moreBtn];
    title.userInteractionEnabled = YES;
    
    float height = 112 * scale + 30;
    float top = 30;
    for (int i = 0; i<(_actList.count > 5?5:_actList.count); i++) {
        WPPriActListModel *model = _actList[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, top, SCREEN_WIDTH-20, height);
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        btn.tag = 2000+i;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_actView addSubview:btn];
        
        UIImageView *holder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 180, 34)];
        holder.center = CGPointMake(btn.width*0.5, (height-50)*0.5);
        holder.image = [UIImage imageNamed:@"placeholder-2"];
        [btn addSubview:holder];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, btn.width, height-30)];
        [btn addSubview:image];
        [image sd_setImageWithURL:[NSURL URLWithString:model.img]];
        
        UIView *timebg = [[UIView alloc]initWithFrame:CGRectMake(0, image.bottom-20, btn.width, 20)];
        timebg.backgroundColor = [UIColor blackColor];
        timebg.alpha = 0.2;
        [btn addSubview:timebg];
        
        UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(10, timebg.top, timebg.width-20, 20)];
        time.backgroundColor =[UIColor clearColor];
        time.textColor = [UIColor whiteColor];
        time.font = [UIFont systemFontOfSize:14];
        time.text = model.timeText;
        [btn addSubview:time];
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, image.bottom, SCREEN_WIDTH-20, 30)];
        name.backgroundColor =[UIColor clearColor];
        name.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        name.font = [UIFont systemFontOfSize:16];
        name.text = model.mainTitle;
        [btn addSubview:name];
        
        if (i==_actList.count-1) {
            _actView.height = btn.bottom+20;
            
        }
        top += (height+10);
    }
    
    UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
    more.frame = CGRectMake(0, _actView.bottom+10, 90, 30);
    more.center = CGPointMake(SCREEN_WIDTH*0.5, _actView.bottom+20);
    [more setTitle:@"查看更多" forState:UIControlStateNormal];
    [more setTitleColor:RGBCOLOR_HEX(kLabelWeakColor) forState:UIControlStateNormal];
    more.titleLabel.font = [UIFont systemFontOfSize:14];
    more.tag = 3000;
    more.layer.masksToBounds = YES;
    more.layer.cornerRadius = 3;
    more.layer.borderWidth = 0.8;
    more.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
    more.backgroundColor = [UIColor whiteColor];
    [more addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollerView addSubview:more];
}
- (void)ReloadAppView{
    [_appView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _appView.height*0.5, _appView.width, 1)];
    line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
    [_appView addSubview:line];

    float left = 20;
    float top = 10;
    float width = 45;
    float gap = (SCREEN_WIDTH - 2*left - 4*width)/3;
    for (int i = 0; i < (_appList.count > 7?7:_appList.count); i++) {
        WPAppListModel *model = _appList[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(left, top, width, width+20);
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_appView addSubview:btn];
        
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width)];
        [btn addSubview:icon];
        [icon sd_setImageWithURL:[NSURL URLWithString:model.appHomeIcon] placeholderImage:[UIImage imageNamed:@"APP-2"]];
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(-10, icon.bottom, width+20, 20)];
        name.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        name.backgroundColor = [UIColor clearColor];
        name.font = [UIFont systemFontOfSize:14];
        name.textAlignment = NSTextAlignmentCenter;
        name.text = model.appName;
        [btn addSubview:name];
        
        left += (width+gap);
        if (i==3) {
            left = 20;
            top = top + _appView.height*0.5;
        }
        
        if (i==6) {
            UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
            more.frame = CGRectMake(left, top, width, width+20);
            more.backgroundColor = [UIColor clearColor];
            more.tag = 4000;
            [more addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_appView addSubview:more];
            
            UIImageView *moreicon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width)];
            moreicon.image = [UIImage imageNamed:@"appmore-8"];
            [more addSubview:moreicon];
            
            UILabel *morename = [[UILabel alloc]initWithFrame:CGRectMake(-10, icon.bottom, width+20, 20)];
            morename.textColor = RGBCOLOR_HEX(kLabelDarkColor);
            morename.backgroundColor = [UIColor clearColor];
            morename.font = [UIFont systemFontOfSize:12];
            morename.textAlignment = NSTextAlignmentCenter;
            morename.text = @"更多";
            [more addSubview:morename];
        }
    }
}


#pragma -mark GCPagingViewDelegate
- (NSInteger)numberOfPagesInPagingView:(GCPagingView*)pagingView{
    return _adList.count;
}
- (UIView*)GCPagingView:(GCPagingView*)pagingView viewAtIndex:(NSInteger)index{
    
    BannerView *view = (BannerView *)[pagingView dequeueReusablePage];
    if (view == nil) {
        view = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, _topView.width-2, 137 * scale)];
        view.delegate = self;
        view.OnClick = @selector(OnBannerClick:);
    }
    
    [view LoadContent:_adList[index]];
    return view;
}
- (void)OnBannerClick:(BannerView *)sender{
    NSLog(@"---->%@",sender.mInfo.adLink);
    [WPURLManager openURLWithMainTitle:sender.mInfo.title urlString:sender.mInfo.adLink];
    [BaiduMob logEvent:@"id_lifetop_ad" eventLabel:@"id_lifetop_ad"];
}

- (void)LogBaiduMob:(NSString *)event :(NSString *)sub :(NSInteger)tag{
    NSString *label = [sub stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)tag]];
    [BaiduMob logEvent:event eventLabel:label];
}

- (void)BtnClick:(UIButton *)sender{
    //1000+ app
    //2000+ act
    //3000 more act
    
    NSInteger section = sender.tag/1000;
    if (section == 0) {
        WPPriWelfaresModel *model = _welfaresList[sender.tag - 100];
        if (sender.tag == 100) {
            [WPURLManager openURLWithMainTitle:model.mainTitle urlString:model.url];
            [BaiduMob logEvent:@"id_coupons" eventLabel:@"life"];
        }else if (sender.tag == 101){
            [WPURLManager openURLWithMainTitle:model.mainTitle urlString:model.url];
        }
    }
    else if (section == 1) {
        NSInteger tag = sender.tag-1000;
        WPAppListModel *model = _appList[tag];
        NSLog(@"---->%@",model.appUrl);
        [WPURLManager openURLWithMainTitle:model.appName urlString:model.appUrl];
        if (tag<7) {
            [self LogBaiduMob:@"id_life_serve" :@"life" :tag+1];
        }else{
            [BaiduMob logEvent:@"id_life_serve" eventLabel:@"lifemore"];
        }
        
    }else if (section == 2){
        WPPriActListModel *model = _actList[sender.tag-2000];
        NSLog(@"---->%@",model.detailUrl);
        //[WPURLManager openURLWithMainTitle:model.mainTitle urlString:model.detailUrl];
        [@"WP://web_vc" openWithQuery:@{
                                        @"urlString" : model.detailUrl,
                                        @"mainTitle" : @"活动详情",
                                        @"shareUrl"  : model.detailUrl,
                                        @"shareImage"   : model.img,
                                        @"shareContent"     : model.mainTitle
                                        }];
        [BaiduMob logEvent:@"id_activity" eventLabel:@"lifelistclick"];
    }else if (section == 3){
        //查看更多活动
        [@"WP://WPMoreActController" openWithQuery:nil animated:YES];
        NSInteger tag = sender.tag - 3000;
        if (tag == 0) {
            [BaiduMob logEvent:@"id_activity" eventLabel:@"lifemore2"];
        }else{
            [BaiduMob logEvent:@"id_activity" eventLabel:@"lifemore1"];
        }
        
    }else if (section == 4){
        //更多服务
        [@"WP://WPMoreServiceController" openWithQuery:nil animated:YES];
    }
}


- (void)RequestToHttps{
    [_mPageView stopAutoScroll];
    [_adList removeAllObjects];
    [_welfaresList removeAllObjects];
    [_appList removeAllObjects];
    [_actList removeAllObjects];
    [self ReloadUI];
    NSString *url = @"/life/privilege";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    //
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            int code = [responseObject[@"code"] intValue];
            if (code == 0 ) {
                NSDictionary *dataDict = responseObject[@"data"];
                NSArray *adArray = dataDict[@"adList"];
                for (NSDictionary *adDict in adArray) {
                    WPPriAdModel *adModel = [WPPriAdModel objectWithKeyValues:adDict];
                    [_adList addObject:adModel];
                }
                NSArray *welArray = dataDict[@"welfares"];
                for (NSDictionary *weDict in welArray) {
                    WPPriWelfaresModel *weModel = [WPPriWelfaresModel objectWithKeyValues:weDict];
                    [_welfaresList addObject:weModel];
                }
                NSArray *appArray = dataDict[@"appList"];
                for (NSDictionary *appDict in appArray) {
                    WPAppListModel *appModel = [WPAppListModel objectWithKeyValues:appDict];
                    [_appList addObject:appModel];
                }
                NSArray *actArray = dataDict[@"actList"];
                for (NSDictionary *actDict in actArray) {
                    WPPriActListModel *actModel = [WPPriActListModel objectWithKeyValues:actDict];
                    [_actList addObject:actModel];
                }
                [self ReloadUI];
            }
            else{
                [self showHint:msg hide:2];
            }
        }
        else{
            [self showHint:msg hide:2];
        }
        
        [_scrollerView.header endRefreshing];
    })];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem.customView.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title {
    return @"特权";
}


@end
