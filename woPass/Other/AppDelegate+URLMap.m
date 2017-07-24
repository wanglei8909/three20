//
//  AppDelegate+URLMap.m
//  woPass
//
//  Created by htz on 15/7/6.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "AppDelegate+URLMap.h"

@implementation AppDelegate (URLMap)

- (void)setURLMap {
    
    TTURLMap *map = [XNavigator navigator].URLMap;
    
    [map from:@"WP://web_vc" toModalViewController:NSClassFromString(@"TZWebViewController")];
    [map from:@"WP://selectCity_vc" toModalViewController:NSClassFromString(@"WPWrapperCityViewController")];
    [map from:@"WP://WPSSOViewController" toModalViewController:NSClassFromString(@"WPSSOViewController")];
    
    
    [map from:@"WP://root_vc" toViewController:NSClassFromString(@"WPRootViewController")];
    [map from:@"WP://currentDevice_vc" toViewController:NSClassFromString(@"WPCurrentDeviceViewController")];
    [map from:@"WP://bindingEmail_vc" toViewController:NSClassFromString(@"WPBindingEmailViewController")];
    [map from:@"WP://loginHistory_vc" toViewController:NSClassFromString(@"WPLoginHistoryViewController")];
    [map from:@"WP://mineApplication_vc" toViewController:NSClassFromString(@"WPMineApplicationViewController")];
    [map from:@"WP://realNameAuthentication_vc" toViewController:NSClassFromString(@"WPRealNameAuthenticationViewController")];
    [map from:@"WP://WPRealNameVerificationViewController" toViewController:NSClassFromString(@"WPRealNameVerificationViewController")];
    [map from:@"WP://loginVerification_vc" toViewController:NSClassFromString(@"WPLoginVerificationViewController")];
    [map from:@"WP://lockingAccount_vc" toViewController:NSClassFromString(@"WPLockingAccountViewController")];
    [map from:@"WP://changPwd_vc" toViewController:NSClassFromString(@"WPChangPwdViewController")];
    [map from:@"WP://setPwd_vc" toViewController:NSClassFromString(@"WPRegisterController")];
    [map from:@"WP://findPwd_vc" toViewController:NSClassFromString(@"WPWarpperFindSecurityViewController")];
    [map from:@"WP://login_vc" toViewController:NSClassFromString(@"WPWrapperLoginViewController")];
    
    [map from:@"WP://personalInformation" toViewController:NSClassFromString(@"WPPersonalInformationController")];
    [map from:@"WP://WPSignController" toViewController:NSClassFromString(@"WPSignController")];
    [map from:@"WP://WPNikeController" toViewController:NSClassFromString(@"WPNikeController")];
    [map from:@"WP://WPPhoneNumController" toViewController:NSClassFromString(@"WPPhoneNumController")];
    [map from:@"WP://WPSexController" toViewController:NSClassFromString(@"WPSexController")];
    [map from:@"WP://WPMyTickettViewController" toViewController:NSClassFromString(@"WPMyTickettViewController")];
    
    [map from:@"WP://WPAboutController" toViewController:NSClassFromString(@"WPAboutController")];
    
    [map from:@"WP://WPMoreServiceController" toViewController:NSClassFromString(@"WPMoreServiceController")];
    [map from:@"WP://WPTiketController" toViewController:NSClassFromString(@"WPTiketController")];
    
    [map from:@"WP://WPMoreActController" toViewController:NSClassFromString(@"WPMoreActController")];
    [map from:@"WP://WPMyOrderListController" toViewController:NSClassFromString(@"WPMyOrderListController")];
//    [map from:@"WP://WPCheckPackageCtrl" toViewController:NSClassFromString(@"WPCheckPackageCtrl")];
    [map from:@"WP://WPBuyLLController" toViewController:NSClassFromString(@"WPBuyLLController")];
    //WPNearbyPOIViewController
    [map from:@"WP://WPLLSucceedCtrl" toViewController:NSClassFromString(@"WPLLSucceedCtrl")];
    [map from:@"WP://WPNearbyAllItemsCtrl" toViewController:NSClassFromString(@"WPNearbyAllItemsCtrl")];
    [map from:@"WP://WPNearbyPOIViewController" toViewController:NSClassFromString(@"WPNearbyPOIViewController")];
    
    [map from:@"WP://WPCommitOrderCtrl" toViewController:NSClassFromString(@"WPCommitOrderCtrl")];
    [map from:@"WP://affilication_vc" toViewController:NSClassFromString(@"WPAffiliationViewController")];
    [map from:@"WP://freeWiFi_vc" toViewController:NSClassFromString(@"WPFreeWiFiViewController")];
    [map from:@"WP://GPRSUsage_vc" toViewController:NSClassFromString(@"WPGPRSUsageViewController")];
    [map from:@"WP://WiFiWiKi_vc" toViewController:NSClassFromString(@"WPWiFiWiKiViewController")];
    [map from:@"WP://WPSUserPhoneInfoViewController" toViewController:NSClassFromString(@"WPSUserPhoneInfoViewController")];
    [map from:@"WP://WPLoginHistoryDetailViewController" toViewController:NSClassFromString(@"WPLoginHistoryDetailViewController")];
    [map from:@"WP://WPFindSecurityTypeCtrl" toViewController:NSClassFromString(@"WPFindSecurityTypeCtrl")];
    [map from:@"WP://WPConfirmOperationViewController" toViewController:NSClassFromString(@"WPConfirmOperationViewController")];
    [map from:@"WP://WPUserPortrayCtrl" toViewController:NSClassFromString(@"WPUserPortrayCtrl")];
    [map from:@"WP://WPAccountManagerControllerViewController" toViewController:NSClassFromString(@"WPAccountManagerControllerViewController")];
    [map from:@"WP://WPMineSettingViewController" toViewController:NSClassFromString(@"WPMineSettingViewController")];
    [map from:@"WP://WPShowPhoneViewController" toViewController:NSClassFromString(@"WPShowPhoneViewController")];
    [map from:@"WP://WPDetermineLogoffViewController" toViewController:NSClassFromString(@"WPDetermineLogoffViewController")];

    [map from:@"WP://WPLogoffAuthenticationViewController" toViewController:NSClassFromString(@"WPLogoffAuthenticationViewController")];
    
    [map from:@"WP://WPFangSaoRaoViewController" toViewController:NSClassFromString(@"WPFangSaoRaoViewController")];
    
    [map from:@"WP://WPSaoRaoChengJiuViewController" toViewController:NSClassFromString(@"WPSaoRaoChengJiuViewController")];
    
    [map from:@"WP://WPSaoraoSettingViewController" toViewController:NSClassFromString(@"WPSaoraoSettingViewController")];

    [map from:@"WP://WPSaoRaoResultViewController" toViewController:NSClassFromString(@"WPSaoRaoResultViewController")];


}

@end
