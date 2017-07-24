//
//  AppDelegate.m
//  woPass
//
//  Created by htz on 15/7/6.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+URLMap.h"
#import "BaiduMobStat.h"
#import <BaiduMapAPI/BMapKit.h>
#import <BaiduMapAPI/BMKMapView.h>
#import "UMFeedback.h"
#import "UMSocial.h"
#import <AlipaySDK/AlipaySDK.h>
#import "UMSocialSinaHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "WPUpdateManager.h"
#import "WPSSOManager.h"
#import "APService.h"
#import "WPLoginHistoryCellItem.h"
#import <objc/runtime.h>
#import "WPLoginDetailProtocol.h"
#import "WPLoginHistoryUtil.h"

static const void *PUSH_KEY = "pushKey";

@interface AppDelegate () <TTNavigatorRootContainer,BMKGeneralDelegate> {
    BMKMapManager *_mapManager;
}

//@property (nonatomic, strong)WPUpdateManager *updateManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#ifdef DEBUG
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *logPath = [documentsDirectory stringByAppendingPathComponent:@"console.log"];
//    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
#endif
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //友盟分享
    [UMSocialData setAppKey:UMKey];
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [UMSocialQQHandler setQQWithAppId:QQID appKey:QQKEY url:@"http://www.umeng.com/social"];
    [UMSocialWechatHandler setWXAppId:WeiChatID appSecret:WeiChatSecret url:@"http://www.umeng.com/social"];
    
    //友盟反馈
    [UMFeedback setAppkey:UMKey];
    
    [self setUpBaiduMob];
    [self setUpBaiduMap];
    [self setURLMap];
    [self setUpJPUSH:launchOptions];
    [self setUpAppearance];
    [XNavigator navigator].window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.window = [XNavigator navigator].window;
    [self.window makeKeyAndVisible];
    [@"WP://root_vc" openWithQuery:nil animated:NO];
    
    return YES;
}
- (void)setUpJPUSH:(NSDictionary *)launchOptions{
    NSLog(@"---->%@",gUser.userId);
    
    // Required
    #if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            //categories
            [APService
             registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                 UIUserNotificationTypeSound |
                                                 UIUserNotificationTypeAlert)
             categories:nil];
        } else {
            //categories nil
            [APService
             registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)
    #else
    //categories nil
categories:nil];
    [APService
     registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                         UIRemoteNotificationTypeSound |
                                         UIRemoteNotificationTypeAlert)
    #endif
        // Required
        categories:nil];
        }
    [APService setupWithOption:launchOptions];
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    [APService registerDeviceToken:deviceToken];
    if ([UserAuthorManager gainCurrentStateForUserLoginAndBind] != 0) {
        [APService setAlias:gUser.userId callbackSelector:nil object:nil];
    }
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required
    [APService handleRemoteNotification:userInfo];
    [self processAbnormalNotificationWithUserInfo:userInfo];
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void(^)(UIBackgroundFetchResult))completionHandler {
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    [self processAbnormalNotificationWithUserInfo:userInfo];
}

- (void)processAbnormalNotificationWithUserInfo:(id)userInfo {
    
    NSString *messageString = userInfo[@"message"];
    NSRange range = [messageString rangeOfString:@"loginAppName"];
    if (range.location != NSNotFound) {
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:nil message:userInfo[@"aps"][@"alert"]  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"去看看", nil];
        WPLoginHistoryCellItem *cellItem = [WPLoginHistoryCellItem objectWithKeyValues:userInfo[@"message"]];
        [[WPLoginHistoryUtil sharedUtil] clearCache];
        [[WPLoginHistoryUtil sharedUtil] refreshStatusWithAbnormalDate:cellItem.detailLoginTime];
        objc_setAssociatedObject(av, PUSH_KEY, cellItem, OBJC_ASSOCIATION_RETAIN);
        [av show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
        id<WPLoginDetailProtocol> model = objc_getAssociatedObject(alertView, PUSH_KEY);
        [@"WP://WPLoginHistoryDetailViewController" openWithQuery:@{@"model" : model}];
        [[WPLoginHistoryUtil sharedUtil] refreshStatus];
    }
}
- (void)setUpBaiduMob{
    BaiduMobStat *statTracker = [BaiduMobStat defaultStat];
    statTracker.enableExceptionLog = YES;
    //statTracker.channelId = @"";//默认为appStore
    statTracker.logStrategy = BaiduMobStatLogStrategyAppLaunch;
    //statTracker.logSendInterval = 1;//默认30s
    statTracker.logSendWifiOnly = NO;
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    statTracker.shortAppVersion = version;
    statTracker.enableDebugOn = YES;
    [statTracker startWithAppId:BaiDuMobKey];
}

- (void)setUpBaiduMap {
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"tswiQ7Q8bwgWE3T5fyGTbhaX"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}
//- (void)onGetNetworkState:(int)iError{
//    
//}
//- (void)onGetPermissionState:(int)iError{
//    /*E_PERMISSIONCHECK_CONNECT_ERROR = -300,//链接服务器错误
//     E_PERMISSIONCHECK_DATA_ERROR = -200,//服务返回数据异常
//     E_PERMISSIONCHECK_OK = 0,	// 授权验证通过
//     E_PERMISSIONCHECK_KEY_ERROR = 101,	//ak不存在
//     E_PERMISSIONCHECK_MCODE_ERROR = 102,	//mcode签名值不正确
//     E_PERMISSIONCHECK_UID_KEY_ERROR = 200,	// APP不存在，AK有误请检查再重试
//     E_PERMISSIONCHECK_KEY_FORBIDEN= 201,	// APP被用户自己禁用，请在控制台解禁
//     */
//}

- (void)setUpAppearance
{
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageWithColor:RGBCOLOR_HEX(0xf8f8f8)] stretchableImageByCenter] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:RGBCOLOR_HEX(0xcacaca)]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: RGBCOLOR_HEX(0x333333), NSFontAttributeName: XFont(kFontLarge)}];
    
    [[UILabel appearance] setBackgroundColor:[UIColor clearColor]];
}

- (void)navigator:(TTBaseNavigator *)navigator setRootViewController:(UIViewController *)controller {
    
    self.window.rootViewController = controller;
}

- (TTBaseNavigator *)getNavigatorForController:(UIViewController *)controller {
    
    return [XNavigator navigator];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    [[WPSSOManager sharedManager] openSsoPageWithUrl:url];
    
    if ([url.description hasPrefix:@"wopass://safepay/"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        return YES;
    }
    else {
        return [UMSocialSnsService handleOpenURL:url];
    }
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    [[WPSSOManager sharedManager] openSsoPageWithUrl:url];
    
    if ([url.host isEqualToString:@"safepay"]) {
        //你的处理逻辑
        //跳转支付宝钱包进行支付，处理支结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            /*
             9000 	订单支付成功
             8000 	正在处理中
             4000 	订单支付失败
             6001 	用户中途取消
             6002 	网络连接出错*/
        }];
        return YES;
    }
    else {
        return [UMSocialSnsService handleOpenURL:url];
    }
    
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    [[WPSSOManager sharedManager] openSsoPageWithUrl:url];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    [[WPSSOManager sharedManager] dismissSsoPage];
}



//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    
//    WPUpdateManager *manager = [WPUpdateManager manager];
//    self.updateManager = manager;
//    [manager checkUpdate];
//}


@end
