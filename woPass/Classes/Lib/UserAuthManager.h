//
//  UserAuthManager.h
//  userauthSdk
//
//  Created by 吕东阳 on 15/7/23.
//  Copyright (c) 2015年 吕东阳. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef enum {
    ENV_NOT_LOGIN = 0,      //需要认证
    ENV_HAVE_LANDED = 1,    //已经可以访问外网
    ENV_ERROR = 2,          //检测异常
}ENV_STATUS;


@interface UserAuthManager : NSObject


+ (instancetype)manager;


/**配置SSID和认证平台
 @param ssid      -- WiFi SSID
 @param wurl      -- 认证平台Url
 @param appSecret -- 加密秘钥
 @return void
 */
- (void)initEnv:(NSString *)ssid WithURl:(NSString*)wurl WithAppSecret:(NSString *)appSecret;


/**网络环境检测
 @param _block -- 检测成功，失败后执行，包含一个状态值，详细见枚举
 @return void
 */
- (void)checkEnvironmentBlock:(void (^)(ENV_STATUS status))_block;


/**用户鉴定
 @param appId    -- 平台为app生成的id
 @param userName -- APP用户名
 @param passWord -- APP密码
 @param timeOut  -- 请求超时时间
 @param _block   -- Auth成功，失败或异常时执行。block包含两个参数，responseStr--服务器响应，error--网络错误
 @return void
 */
- (void)doAuth:(NSString *)appId withUserName:(NSString *)userName withPassWord:(NSString *)passWord andTimeOut:(NSTimeInterval)timeOut block:(void (^)(NSString *responseStr, NSError *error))_block;


/**用户登录
 @param mobileNo   -- 用户登录手机号码（平台返回）
 @param tokenCode  -- 用户登录动态密码（平台返回）
 @param timeOut    -- 请求超时时间
 @param _block     -- 登录成功，失败或异常时执行。block包含两个参数，responseStr--服务器响                      应，error--网络错误
 @return void
 */
- (void)doLogon:(NSString *)mobileNo withTokenCode:(NSString *)tokenCode andTimeOut:(NSTimeInterval)timeOut block:(void (^)(NSString *responseStr, NSError *error))_block;


/**用户登出
 @param timeOut   -- 请求超时时间
 @param _block    -- 登出成功，失败或异常时执行。block包含两个参数，responseStr--服务器响应，error--网络错误
 @return void
 */
- (void)doLogoutWithTimeOut:(NSTimeInterval)timeOut block:(void (^)(NSString *responseStr, NSError *error))_block;





/** 设置是否打印sdk的log信息,默认不开启
 @param value 设置为YES, 会输出log信息,记得release产品时要设置回NO.
 @return void
 */
- (void)logEnable:(BOOL)value;

@end
