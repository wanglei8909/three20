//
//  WPModifyUserInfoViewModel.m
//  woPass
//
//  Created by 王蕾 on 15/7/22.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPModifyUserInfoViewModel.h"
#import "SDImageCache.h"

@implementation WPModifyUserInfoViewModel

+ (void)ChangeUserInfoWithType:(NSString *)key AndValue:(NSString *)value AndSecceed:(void(^)())succeed{
    NSArray *keyArray = [gUser getAllProperties];
    for (NSString *propertiesKey in keyArray) {
        if ([key isEqualToString:propertiesKey]) {
            [gUser setValue:value forKey:key];
            
            NSString *url = @"/u/modifyUserBaseInfo";
            NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
            [parametersDict setObject:value forKey:key];
            [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
                
                int code = [responseObject[@"code"] intValue];
                if (code == 0 && responseObject) {
                    succeed();
                }
                else{
                    [WPModifyUserInfoViewModel ChangeUserInfoWithType:key AndValue:value AndSecceed:succeed];
                }
            })];
            return;
        }
    }
}
+ (void)ChangeUserHeaderImage:(UIImage *)image AndSecceed:(void (^)(NSString *imageUrl))succeed{
    NSString *url = @"/u/modifyUserBaseInfo";
    
    float scale = 0.7;
    NSData *newdata = UIImageJPEGRepresentation(image, scale);
    UIImage *newImage = [UIImage imageWithData:newdata];
    NSData *data = UIImagePNGRepresentation(newImage);
    
    NSString *dataStr = [data base64Encoding];
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:dataStr forKey:@"avatarImg"];
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        int code = [responseObject[@"code"] intValue];
        if (code == 0 && responseObject) {
            succeed([NSString stringWithFormat:@"%@",responseObject[@"data"][@"avatarImg"]]);
            gUser.avatarImg = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"avatarImg"]];
            //清除本地缓存
            [[SDImageCache sharedImageCache] removeImageForKey:gUser.avatarImg];
        }
        else{
            [WPModifyUserInfoViewModel ChangeUserHeaderImage:image AndSecceed:succeed];
        }
    })];
}


@end
