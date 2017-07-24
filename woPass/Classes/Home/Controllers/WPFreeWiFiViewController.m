//
//  WPFreeWiFiViewController.m
//  woPass
//
//  Created by htz on 15/8/2.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPFreeWiFiViewController.h"
#import "WPFreeWiFiHeaderCellIItem.h"
#import "WPFreeWiFiSwitchCellItem.h"
#import "WPFreeWiFiLabelCellItem.h"
#import "UserAuthManager.h"

@interface WPFreeWiFiViewController () <UIAlertViewDelegate>

@property (nonatomic, strong)NSMutableArray *itemsArray;


@end

@implementation WPFreeWiFiViewController

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
        
    }
    return _itemsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BaiduMob logEvent:@"id_unicom_ability" eventLabel:@"wifi"];
    
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.navigationController.navigationBar.height + 22, 0, 0, 0))];
    
    weaklySelf();
    [self.itemsArray addObject:[[WPFreeWiFiHeaderCellIItem alloc] init]];
    
    [self.itemsArray addObject:[[[WPFreeWiFiSwitchCellItem alloc] init] applySwitchChangeAction:^(UISwitch *sw, BOOL isOn) {
        
        if (isOn) {
            
            [BaiduMob logEvent:@"id_unicom_ability" eventLabel:@"wifion"];
            [weakSelf login];
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定断开连接?" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }]];
    
    [self.itemsArray addObject:[[WPFreeWiFiLabelCellItem alloc] init]];
    
    self.items = @[self.itemsArray];
    [self autoRefresh];
    
}

- (void)autoRefresh {
    
    [gUser addObserver:self forKeyPath:@"freeWifiIsAvaliable" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    [self.tableView reloadData];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ([alertView.message isEqualToString:@"确定断开连接?"] && buttonIndex == 1) {
        
        [self logout];
    }
}

- (void)logout {
    
    gUser.freeWifiIsAvaliable = @"0";
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"useronline_id"] && [[NSUserDefaults standardUserDefaults]objectForKey:@"LogoffURL"])
    {
        [[UserAuthManager manager]doLogoutWithTimeOut:20.0f block:^(NSString *responseStr, NSError *error) {
            if (responseStr)
            {
                NSData *jsonData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                NSString * ResponseCode = [dic objectForKey:@"ResponseCode"];
                if ([ResponseCode isEqualToString:@"150"])
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"注销成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"useronline_id"];
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"LogoffURL"];
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"注销失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"注销失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            
        }];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您并未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }

}

- (void)login {
    
    WPFreeWiFiSwitchCellItem *item = self.itemsArray[1];
    WPFreeWiFiSwitchCell *cell =  (WPFreeWiFiSwitchCell *)item.tableViewCell;
    
    [[UserAuthManager manager]initEnv:@"ChinaUnicom" WithURl:@"http://103.224.234.164:8080/wsmp/authenticate" WithAppSecret:@"I3hEaIoak1r5OLlkFdAfYT8F"];
    
    weaklySelf();
    [self showLoading:YES];
    [[UserAuthManager manager] checkEnvironmentBlock:^(ENV_STATUS status) {
       
        if (status == ENV_ERROR) {
            
            [weakSelf hideLoading:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误，请重新连接ChinaUnicom后再试" delegate:weakSelf cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [cell.wifiSwitch setOn:NO animated:YES];
            [alert show];
            return;
            
        } else if (status == ENV_HAVE_LANDED) {
            
            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"LogoffURL"])
            {
                [weakSelf hideLoading:YES];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您已登录成功！可以访问外网" delegate:weakSelf cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                [alert show];
                [cell.wifiSwitch setOn:YES animated:YES];
                gUser.freeWifiIsAvaliable = @"1";
                
                [BaiduMob logEvent:@"id_unicom_ability" eventLabel:@"wifion_success"];
                return;
            }
            else
            {
                [weakSelf hideLoading:YES];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请按照使用说明，链接chinaunicom热点后继续操作。" delegate:weakSelf cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                [alert show];
                [cell.wifiSwitch setOn:NO animated:YES];
                return;
            }
        } else if (status == ENV_NOT_LOGIN) {
            
            [[UserAuthManager manager]doAuth:@"1001" withUserName:gUser.userId withPassWord:gUser.freeWifiCode andTimeOut:20.0f block:^(NSString *responseStr, NSError *error)
             {
                 NSLog(@"responseStr___%@_____error___%@",responseStr,error);
                 
                 if (responseStr)
                 {
                     
                     NSData *jsonData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
                     NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                     NSString *codeStr = [dic objectForKey:@"code"];
                     if ([codeStr isEqualToString:@"0000"])
                     {
                         NSDictionary *userInfoDict = [dic objectForKey:@"data"];
                         NSString *phoneStr = [userInfoDict objectForKey:@"mobileNum"];
                         NSString *pswStr = [userInfoDict objectForKey:@"password"];
                         [[UserAuthManager manager]doLogon:phoneStr withTokenCode:pswStr andTimeOut:20.0f block:^(NSString *responseStr, NSError *error)
                          {
                              if (responseStr)
                              {
                                  NSData *jsonData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
                                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                                  NSString * ResponseCode = [dic objectForKey:@"ResponseCode"];
                                  if ([ResponseCode isEqualToString:@"200"])
                                  {
                                      [weakSelf hideLoading:YES];
                                      NSString * useronline_id = [dic objectForKey:@"useronline_id"];
                                      NSString * LogoffURL = [dic objectForKey:@"LogoffURL"];
                                      [[NSUserDefaults standardUserDefaults]setObject:useronline_id forKey:@"useronline_id"];
                                      [[NSUserDefaults standardUserDefaults]setObject:LogoffURL forKey:@"LogoffURL"];
                                      [[NSUserDefaults standardUserDefaults]synchronize];
                                      
                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功！" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                      [alert show];
                                      gUser.freeWifiIsAvaliable = @"1";
                                      return ;
                                      
                                  }
                                  else
                                  {
                                      [weakSelf hideLoading:YES];
                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常，请重新登录后再试" delegate:weakSelf cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                                      [alert show];
                                      [cell.wifiSwitch setOn:NO animated:YES];
                                      return ;
                                      
                                  }
                                  
                              }
                              else
                              {
                                  [weakSelf hideLoading:YES];
                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常，请重新登录后再试" delegate:weakSelf cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                                  [alert show];
                                  [cell.wifiSwitch setOn:NO animated:YES];
                                  return ;
                              }
                              
                              
                          }];
                         
                     }
                     else
                     {
                         [weakSelf hideLoading:YES];
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常，请重新登录后再试" delegate:weakSelf cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                         [alert show];
                         [cell.wifiSwitch setOn:NO animated:YES];
                         return ;
                     }
                 }
                 else
                 {
                     [weakSelf hideLoading:YES];
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常，请重新登录后再试" delegate:weakSelf cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                     [alert show];
                     [cell.wifiSwitch setOn:NO animated:YES];
                     return ;
                 }
             }];
        }
        
    }];
}

- (void)dealloc {
    
    [gUser removeObserver:self forKeyPath:@"freeWifiIsAvaliable"];
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50 - 55)];
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
    return @"免费WiFi";
}

@end
