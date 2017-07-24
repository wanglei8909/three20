//
//  WPRootViewController.m
//  woPass
//
//  Created by htz on 15/7/6.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPRootViewController.h"
#import "WPMineViewController.h"
#import "WPPrivilegeViewController.h"
#import "WPSecurityViewController.h"
#import "WPHomeViewController.h"
#import "RDVTabBarItem.h"
#import "TZButton.h"
#import <BaiduMapAPI/BMapKit.h>
#import <BaiduMapAPI/BMKMapView.h>
#import "WPCityController.h"
#import "WPSSOManager.h"

@interface WPRootViewController () <BMKLocationServiceDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong)TZButton *cityButton;
@property (nonatomic, strong)XViewController *currentViewController;
@property (nonatomic, strong) UIBarButtonItem *sharedLeftBarButtonItem;
@property (nonatomic, strong)BMKLocationService *locService;
@property (nonatomic, strong) WPCityController *cityController;

@end

@implementation WPRootViewController

- (TZButton *)cityButton {
    if (!_cityButton) {
        _cityButton = [TZButton buttonWithType:UIButtonTypeCustom];
        [_cityButton setTitle:gUser.locationCityDict[@"name"] forState:UIControlStateNormal];
        [_cityButton setTitleColor:RGBCOLOR_HEX(0xff6600) forState:UIControlStateNormal];
        _cityButton.titleLabel.font = XFont(kFontLarge);
        [_cityButton setImage:[UIImage imageNamed:@"icon_address"] forState:UIControlStateNormal];
        [_cityButton addTarget:self action:@selector(cityButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _cityButton.isImageOnRight = YES;
        _cityButton.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 0, 0);
        [_cityButton x_sizeToFit];
    }
    return _cityButton;
}

- (UIBarButtonItem *)sharedLeftBarButtonItem {
    if (!_sharedLeftBarButtonItem) {
        _sharedLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.cityButton];
    }
    return _sharedLeftBarButtonItem;
}

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query {
    
    if (self = [super initWithNavigatorURL:URL query:query]) {
        
        WPMineViewController *mineVC = [[WPMineViewController alloc] init];
        WPSecurityViewController *securityVC = [[WPSecurityViewController alloc] init];
        WPPrivilegeViewController *privilegeVC = [[WPPrivilegeViewController alloc] init];
        WPHomeViewController *homeVC = [[WPHomeViewController alloc] init];
        NSArray *vcArray = @[homeVC, securityVC, privilegeVC, mineVC];
        NSMutableArray *vcArrayM = [NSMutableArray array];
        
        weaklySelf();
        [vcArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            [vcArrayM addObject:[weakSelf wrappingController:obj]];
        }];
        
        [self setViewControllers:vcArrayM];
        [self customizedTabbar];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
    [BMKLocationService setLocationDistanceFilter:1.f];
    
    //初始化BMKLocationService
    self.locService = [[BMKLocationService alloc] init];
    self.locService.delegate = self;
    [self.locService startUserLocationService];
    [self setHidesBottomBarWhenPushed:YES];
    
    CLLocationManager *locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
}

- (void)interviewUnikey:(NSString *)unikey {
    
    NSString *baseUlr = [[NSUserDefaults standardUserDefaults] objectForKey:BASEURLKEY];
    baseUlr = baseUlr ? baseUlr : BASEURLONLINE;
    
    NSString *urlString = [NSString stringWithFormat:@"%@/txzApp/c/queryMobile?unikey=%@", baseUlr, unikey];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
       
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:NULL];
        [[NSNotificationCenter defaultCenter] postNotificationName:WPInterviewUnikeyDidFinishNotification object:nil];
    }];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    [self.locService startUserLocationService];
}
//实现相关delegate 处理位置信息更新
//处理方向变更信息

#warning 目前没有使用这个的需求
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
//{
//    NSLog(@"heading is %@",userLocation.heading);
//}
//处理位置坐标更新

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"**************位置改变*********\n%f\n%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    gUser.lat = [NSString stringWithFormat:@"%f", userLocation.location.coordinate.latitude];
    gUser.lng = [NSString stringWithFormat:@"%f", userLocation.location.coordinate.longitude];
    
    
}

- (void)customizedTabbar {
    
    UIImage *unselectedBackgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
    UIImage *selectedBackgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
    RDVTabBar *tabbar = [self tabBar];
    tabbar.backgroundColor = [UIColor whiteColor];
    tabbar.height = 50;
    
    NSArray *selectedName = @[@"home_2", @"anquan", @"v--3", @"wodefanbai"];
    NSArray *unSelectedName = @[@"home", @"anquan-2", @"v--2", @"wodefanbai11"];
    NSArray *titleArray = @[@"首页", @"安全", @"特权", @"我的"];
    
    [tabbar.items enumerateObjectsUsingBlock:^(RDVTabBarItem *item, NSUInteger idx, BOOL *stop) {
        
        [item setBackgroundSelectedImage:selectedBackgroundImage withUnselectedImage:unselectedBackgroundImage];
        UIImage *selectedImage = [UIImage imageNamed:selectedName[idx]];
        UIImage *unselectedImage = [UIImage imageNamed:unSelectedName[idx]];
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedImage];
        
        [item setSelectedTitleAttributes:@{
                                           NSFontAttributeName : XFont(11),
                                           NSForegroundColorAttributeName : RGBCOLOR_HEX(KTextOrangeColor)
                                           }];
        [item setUnselectedTitleAttributes:@{
                                             NSFontAttributeName : XFont(11),
                                             NSForegroundColorAttributeName : RGBCOLOR_HEX(kLabelWeakColor)
                                             }];
        [item setTitle:titleArray[idx]];
    }];
    
    UIView *marginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    marginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
    [tabbar addSubview:marginView];
}

- (UIViewController *)wrappingController:(UIViewController *)viewController {

    UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    if (viewController.hideNavigationBar) {
        
        [vc setNavigationBarHidden:YES animated:NO];
    }
    return vc;
}

- (void)setSelectedViewController:(UINavigationController *)selectedViewController {
    
    UINavigationController *navController = (id)self.selectedViewController;
    XViewController *oldViewController = navController.viewControllers[0];
    
    if (oldViewController.hasYDNavigationBar)
    {
        oldViewController.xNavigationItem.leftBarButtonItem = nil;
    }
    else
    {
        oldViewController.navigationItem.leftBarButtonItem = nil;
    }
    
    [super setSelectedViewController:selectedViewController];
    
    XViewController *newViewController = selectedViewController.viewControllers[0];
    
    if ([newViewController hasYDNavigationBar])
    {
        newViewController.xNavigationItem.leftBarButtonItem = self.sharedLeftBarButtonItem;
    }
    else
    {
        newViewController.navigationItem.leftBarButtonItem = self.sharedLeftBarButtonItem;
    }
    self.currentViewController = newViewController;
}

- (BOOL)hideNavigationBar
{
    return YES;
}

- (BOOL)hasYDNavigationBar
{
    return YES;
}

- (CGFloat)ydNavigationBarHeight
{
    return 48;
}

- (BOOL)enableDragBack {
    
    return NO;
}

- (void)cityButtonClicked:(TZButton *) button{
    
    if (!_cityController) {
        _cityController = [[WPCityController alloc]init];
        weaklySelf();
        _cityController.finishBlock = ^(NSDictionary *cityDict){
            [weakSelf.cityButton setTitle:cityDict[@"name"] forState:UIControlStateNormal];
            [weakSelf.cityButton x_sizeToFit];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:10];
            for (NSString *key in cityDict) {
                [dict setObject:[NSString stringWithFormat:@"%@",cityDict[key]] forKey:key];
            }
            gUser.locationCityDict = dict;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:WPSelectCityNotification object:nil userInfo:@{
                                                                                                                      @"ClassName" : @"WPCityController"
                                                                                                                      }];
        };
    }
    
    [self presentViewController:_cityController animated:YES completion:nil];
}

@end
