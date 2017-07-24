//
//  WPHomeViewController.m
//  woPass
//
//  Created by htz on 15/7/6.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPHomeViewController.h"
#import "TZButton.h"
#import "WPLoginedHeaderCellItem.h"
#import "WPAdsCellItem.h"
#import "WPUtilityCellItem.h"
#import "WPAdsViewPagerCellItem.h"
#import "WPLifeServiceCellItem.h"
#import "WPLBSCellItem.h"
#import "WPPagerAdsModel.h"
#import "WPNoneLoginHeaderCellItem.h"
#import "WPRootViewController.h"
#import "WPNetworkManager.h"
#import "WPNearbyCellItem.h"
#import "Reachability.h"
#import "WPLoginRegisterViewController.h"
#import "WPLoginUtil.h"
#import "WPLoginHistoryUtil.h"
#import "WPLockManager.h"
#import "WPPoraitCellItem.h"

@interface WPHomeViewController ()

@property (nonatomic, strong) NSMutableArray *itemsArray;
@property (nonatomic, strong) NSDictionary   *homeCache;

@end

@implementation WPHomeViewController


#pragma mark - Constructors and Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    
    [self refreshHeader];
    [self setupPortrait];
    [self setupAds];
    [self setupUtility];
    [self setupPager];
    //    [self setupLifeService];
    //[self setupNearbySearch];
    
    [self getPageContent];
    [self fetchHistoryList];
    [self fetchPhoneNumberViaNet];
    
    [[WPLockManager sharedManager] conditionWithName:@"abnormalLogin"];
    
    self.items = @[self.itemsArray];
    
    weaklySelf();
    
    [self.KVOController observe:gUser keyPath:@"woToken" block:^(id observer, id object, id old, id new) {
        
        if (![old isEqualToString:new]) {
            [weakSelf refreshHeader];
            [weakSelf getPageContent];
            [weakSelf fetchHistoryList];
        }
    }];
    
    [self.KVOController observe:gUser keyPaths:@[@"avatarImg", @"nickname", @"mobile", @"avatarImgData", @"maskedMobile"] block:^(id observer, id object, id oldValue, id newVale) {
        
        if (![oldValue isEqual:newVale]) {
            
            [weakSelf refreshHeader];
        }
    }];
    
    [self.KVOController observe:gUser keyPath:@"showShowAbnormal" block:^(id observer, id object, id oldValue, id newVale) {
        
        if (![oldValue isEqualToString:newVale]) {
            [weakSelf.tableView reloadData];
        }
    }];
    
    Reachability *reachabiliy = [Reachability reachabilityForInternetConnection];
    [reachabiliy startNotifier];
    [reachabiliy setReachableBlock:^(Reachability *netReach) {
        
        [weakSelf getPageContent];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
       
        [weakSelf fetchPhoneNumberViaNet];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    [self refreshHeader];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private Method

#pragma mark -- 刷新首页内容

- (void)getPageContent {
    
    [self showLoading:YES];
    
    weaklySelf();
    [RequestManeger POST:@"/life/home" parameters:nil complete:processComplete(^(AFHTTPRequestOperation *operation, NSDictionary *responseObject, NSString *msg) {
        
        [weakSelf hideLoading:YES];
        [weakSelf showHint:msg hide:1];
        
        if (!msg) {
            
            [responseObject writeToFile:DocPath(@"home.data") atomically:YES];
            
            NSDictionary *userDic = [[responseObject objectForKey:@"data"] objectForKey:@"user"];
            if (userDic.count) {
                
                gUser.avatarImg = [NSString stringWithFormat:@"%@", [[[responseObject objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"avatarImg"]];
                gUser.maskedMobile = [NSString stringWithFormat:@"%@", [[[responseObject objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"mobile"]];
                gUser.nickname = [NSString stringWithFormat:@"%@", [[[responseObject objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"nickName"]];
                gUser.realNameIsauth = [NSString stringWithFormat:@"%@", [[[responseObject objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"realNameIsAuth"]];
                gUser.securityLevel = [NSString stringWithFormat:@"%@", [[[responseObject objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"securityLevel"]];
                gUser.lastLoginRegion = [NSString stringWithFormat:@"%@", [[[responseObject objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"lastLoginRegion"]];
            } else {
                
                [gUser QutiLogin:nil];
            }
            
            [self refreshHeader];
            
            [weakSelf.itemsArray enumerateObjectsUsingBlock:^(id cellItem, NSUInteger idx, BOOL *stop) {
                
                if ([cellItem isKindOfClass:[WPAdsCellItem class]]) {
                    
                    // 更新优惠卷活动等
                    WPAdsCellItem *adsCellItem = cellItem;
                    adsCellItem.adsViewItemsArray = [WPAdsViewCellItem objectArrayWithKeyValuesArray:[[responseObject objectForKey:@"data"] objectForKey:@"welfares"]];
                } else if ([cellItem isKindOfClass:[WPUtilityCellItem class]]) {
                    
                    // 更新联通能力等
                    WPUtilityCellItem *utilityCellItem = cellItem;
                    utilityCellItem.utilityViewItemsArray = [WPUtilityViewCellItem objectArrayWithKeyValuesArray:[[responseObject objectForKey:@"data"] objectForKey:@"functions"]];
                } else if ([cellItem isKindOfClass:[WPAdsViewPagerCellItem class]]) {
                    
                    // 更新广告页
                    WPAdsViewPagerCellItem *adsViewPagerCellItem = cellItem;
                    adsViewPagerCellItem.pagerAdsArray = [WPPagerAdsModel objectArrayWithKeyValuesArray:[[responseObject objectForKey:@"data"] objectForKey:@"ads"]];
                    [adsViewPagerCellItem applyImageReadyAction:^{
                        
                        [weakSelf.tableView reloadData];
                    }];
                    
                } else if ([cellItem isKindOfClass:[WPLifeServiceCellItem class]]) {
                    
                    // 更新生活服务
                    WPLifeServiceCellItem *lifeServiceCellItem = cellItem;
                    [lifeServiceCellItem applyActionBlock:^(UITableView *tableView, id info) {
                        [BaiduMob logEvent:@"id_life_serve" eventLabel:@"homemore"];
                        [@"WP://WPMoreServiceController" open];
                    }];
                    lifeServiceCellItem.lifeServiceViewItemArray = [WPLIfeServiceViewCellItem objectArrayWithKeyValuesArray:[[responseObject objectForKey:@"data"] objectForKey:@"apps"]];
                }
            }];
            
            [weakSelf.tableView reloadData];
        }
        
    })];
}

#pragma mark -- 页面缓存初始化

- (void)setupNoneLogedHeader {
    
    weaklySelf();
    
    if ([[self.itemsArray firstObject] isKindOfClass:[WPNoneLoginHeaderCellItem class]])
        return;
    
    if (self.itemsArray.count) {
        
        [self.itemsArray removeObjectAtIndex:0];
    }
    
    [self.itemsArray insertObject:[[[[WPNoneLoginHeaderCellItem alloc] init] applyLeftAction:^{
        
        [BaiduMob logEvent:@"id_login_click" eventLabel:@"id_login_click"];
        [UserAuthorManager authorizationLogin:weakSelf andSuccess:^{
            
        } andFaile:^{
            
        }];
    }] applyLowerAction:^{
        
        [UserAuthorManager authorizationLogin:weakSelf andSuccess:^{
            
            [BaiduMob logEvent:@"id_log_record" eventLabel:@"home"];
            [@"WP://loginHistory_vc" open];
        } andFaile:^{
            
        }];
    }] atIndex:0];
    
}

- (void)setupLogedHeader {
    
    if ([[self.itemsArray firstObject] isKindOfClass:[WPLoginedHeaderCellItem class]])
        return;
    
    if (self.itemsArray.count) {
        
        [self.itemsArray removeObjectAtIndex:0];
    }
    
    weaklySelf();
    WPLoginedHeaderCellItem *cellItem = [[WPLoginedHeaderCellItem alloc ] init];
    
    [cellItem applyUpperAction:^{
        
        [BaiduMob logEvent:@"id_user_data" eventLabel:@"home"];
        WPRootViewController *root = (WPRootViewController *)weakSelf.navigationController.parentViewController;
        [root setSelectedIndex:3];
    } lowerAction:^{
        
        [BaiduMob logEvent:@"id_log_record" eventLabel:@"home"];
        [@"WP://loginHistory_vc" open];
        gUser.showShowAbnormal = @"0";
        [[WPLoginHistoryUtil sharedUtil] refreshStatus];
        [weakSelf.tableView reloadData];
    }];
    
    [self.itemsArray insertObject:cellItem atIndex:0];
}

- (void)setupPortrait {
    
    WPPoraitCellItem *portraitCellItem = [[[WPPoraitCellItem alloc] init] applyActionBlock:^(UITableView *tableView, id info) {
        
        [UserAuthorManager authorizationLogin:self andSuccess:^{
            
            [@"WP://WPUserPortrayCtrl" open];
            [BaiduMob logEvent:@"user_data" eventLabel:@"click"];
        } andFaile:^{
            
        }];
    }];;
    [self.itemsArray addObject:portraitCellItem];
}


- (void)setupAds {
    
    WPAdsCellItem *adsCellItem = [[WPAdsCellItem alloc] init];
    if (self.homeCache) {
        
        adsCellItem.adsViewItemsArray = [WPAdsViewCellItem objectArrayWithKeyValuesArray:[[self.homeCache objectForKey:@"data"] objectForKey:@"welfares"]];
    } else {
        
        WPAdsViewCellItem *adsViewItem = [[WPAdsViewCellItem alloc] init];
        WPAdsViewCellItem *adsViewItem1 = [[WPAdsViewCellItem alloc] init];
        adsCellItem.adsViewItemsArray = adsCellItem.adsViewItemsArray = @[adsViewItem, adsViewItem1];
    }
    
    [self.itemsArray addObject:adsCellItem];
}

- (void)setupUtility {
    
    WPUtilityCellItem *utilityCellItem = [[WPUtilityCellItem alloc] init];
    if (self.homeCache) {
        
        utilityCellItem.utilityViewItemsArray = [WPUtilityViewCellItem objectArrayWithKeyValuesArray:[[self.homeCache objectForKey:@"data"] objectForKey:@"functions"]];
    } else {
        
        WPUtilityViewCellItem *utilityViewItem = [[WPUtilityViewCellItem alloc] init];
        utilityViewItem.title = @"免费wifi";
        utilityViewItem.imageName = @"wifi";
        
        WPUtilityViewCellItem *utilityViewItem1 = [[WPUtilityViewCellItem alloc] init];
        utilityViewItem1.title = @"归属地";
        utilityViewItem1.imageName = @"didian";
        
        WPUtilityViewCellItem *utilityViewItem2 = [[WPUtilityViewCellItem alloc] init];
        utilityViewItem2.title = @"流量查询";
        utilityViewItem2.imageName = @"liuliang";
        
        WPUtilityViewCellItem *utilityViewItem3 = [[WPUtilityViewCellItem alloc] init];
        utilityViewItem3.title = @"流量办理";
        utilityViewItem3.imageName = @"liuliang2";
        utilityCellItem.utilityViewItemsArray = @[utilityViewItem, utilityViewItem1, utilityViewItem2, utilityViewItem3];
    }
    [self.itemsArray addObject:utilityCellItem];
}

- (void)setupPager {
    
    WPAdsViewPagerCellItem *adsViewPagerCellItem = [[WPAdsViewPagerCellItem alloc] init];
    if (self.homeCache) {
        
        adsViewPagerCellItem.pagerAdsArray = [WPPagerAdsModel objectArrayWithKeyValuesArray:[[self.homeCache objectForKey:@"data"] objectForKey:@"ads"]];
    }
    [self.itemsArray addObject:adsViewPagerCellItem];
    
}

- (void)setupLifeService {
    WPLifeServiceCellItem *lifeServiceCellItem = [[WPLifeServiceCellItem alloc] init];
    
    if (self.homeCache) {
        
        lifeServiceCellItem.lifeServiceViewItemArray = [WPLIfeServiceViewCellItem objectArrayWithKeyValuesArray:[[self.homeCache objectForKey:@"data"] objectForKey:@"apps"]];
        
    } else {
        
        WPLIfeServiceViewCellItem *lifeServiceViewItem = [[WPLIfeServiceViewCellItem alloc] init];
        lifeServiceViewItem.title = @"打车";
        lifeServiceViewItem.imageName = @"dache-";
        
        WPLIfeServiceViewCellItem *lifeServiceViewItem1 = [[WPLIfeServiceViewCellItem alloc] init];
        lifeServiceViewItem1.title = @"甜品";
        lifeServiceViewItem1.imageName = @"dangao-";
        
        WPLIfeServiceViewCellItem *lifeServiceViewItem2 = [[WPLIfeServiceViewCellItem alloc] init];
        lifeServiceViewItem2.title = @"酒店";
        lifeServiceViewItem2.imageName = @"iconfont-jiudian-5";
        
        WPLIfeServiceViewCellItem *lifeServiceViewItem3 = [[WPLIfeServiceViewCellItem alloc] init];
        lifeServiceViewItem3.title = @"外卖";
        lifeServiceViewItem3.imageName = @"dianwaimai-";
        lifeServiceCellItem.lifeServiceViewItemArray = @[lifeServiceViewItem, lifeServiceViewItem1, lifeServiceViewItem2, lifeServiceViewItem3];
    }
    [self.itemsArray addObject:lifeServiceCellItem];
}
- (void)setupNearbySearch{
    [self.itemsArray addObject:[[WPNearbyCellItem alloc]init]];
}

- (void)setupLBS {
    WPLBSCellItem *lBSCellItem = [[WPLBSCellItem alloc] init];
    
    [self.itemsArray addObject:lBSCellItem];
}

#pragma mark -- 刷新头部

- (void)refreshHeader {
    if (ISLOGINED) {
        
        [self setupLogedHeader];
        [[[WPLockManager sharedManager] conditionWithName:@"abnormalLogin"] broadcast];
    } else if (!ISLOGINED) {
        
        [self setupNoneLogedHeader];
    }
    
    [self.tableView reloadData];
}

#pragma mark -- 获取登录历史列表

- (void)fetchHistoryList {
    if (ISLOGINED) {
        
        weaklySelf();
        [[WPLoginHistoryUtil sharedUtil] fetchLoginHistoryDicListComplete:^(id response, NSString *msg) {
            
            if (!msg) {
                
                dispatch_queue_t serialQueue = dispatch_queue_create("homeHistoryAbnormal", DISPATCH_QUEUE_SERIAL);
                dispatch_async(serialQueue, ^{
                    
                    if ([[weakSelf.itemsArray firstObject] isKindOfClass:[WPNoneLoginHeaderCellItem class]]) {
                        
                        [[[WPLockManager sharedManager] conditionWithName:@"abnormalLogin"] wait];
                    }
                    
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        
                        gUser.showShowAbnormal = [[WPLoginHistoryUtil sharedUtil] isCurrentLatestAbnormalDateNewerThanCache] ? @"1" : @"0";
                    });
                });
            }
        }];
    }
}

#pragma mark -- Net取号

- (void)fetchPhoneNumberViaNet {
    
    weaklySelf();
    NSLog(@"-------调用net取号，取号前为：%@---------", gUser.mobile);
    [RequestManeger GET:@"/c/netQueryMobile" parameters:@{@"unikey" : gUser.unikey} complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        if (!msg) {
            
            [BaiduMob logEvent:@"id_login_click" eventLabel:@"net"];
            if (!ISLOGINED) {
                
                WPNoneLoginHeaderCellItem *cellItem = [self.itemsArray firstObject];
                NSString *phoneNumber = [[responseObject objectForKey:@"data"] objectForKey:@"mobile"];
                NSString *key = [[responseObject objectForKey:@"data"] objectForKey:@"key"];
                cellItem.phoneNumber = phoneNumber;
                NSLog(@"-------调用net取号，取号前为：%@---------", gUser.mobile);
                [cellItem applyLeftAction:^{
                    
                    [weakSelf showLoading:YES];
                    [WPLoginUtil loginWithPhoneNumber:phoneNumber code:key type:WPLoginTypeOneKeyLogViaNet finishAction:^(id info) {
                        [weakSelf hideLoading:YES];
                        
                        if (info) {
                            
                            [weakSelf showHint:@"登录失败请重试" hide:2];
                            [weakSelf fetchPhoneNumberViaNet];
                        } else {
                            
                            [BaiduMob logEvent:@"id_login_success" eventLabel:@"net"];
                        }
                    }];
                }];
                
                [cellItem applyRightButtonAction:^{
                    
                    [BaiduMob logEvent:@"id_login_click" eventLabel:@"id_login_click"];
                    [UserAuthorManager authorizationLogin:weakSelf andSuccess:^{
                        
                    } andFaile:^{
                        
                    }];
                }];
                [self refreshHeader];
            }
        }
    })];

}


#pragma mark - Event Reponse







#pragma mark - Delegate









#pragma mark - Getter and Setter

- (NSDictionary *)homeCache {
    if (!_homeCache) {
        _homeCache  = [NSDictionary dictionaryWithContentsOfFile:DocPath(@"home.data")];
    }
    return _homeCache;
}
- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
        
    }
    return _itemsArray;
}

#pragma mark - Public

#pragma mark - Three20

- (NSString *)title {
    
//#ifdef DEBUG
//    NSString *url = RequestManeger.baseUrl;
//    if ([url containsString:@"test"]) {
//        
//        return @"测试环境";
//    } else if ([url containsString:@"dev"])  {
//        
//        return @"开发环境";
//    } else {
//        
//        return @"正式环境";
//    }
//    
//#endif
    return @"沃通行证";
}





@end
