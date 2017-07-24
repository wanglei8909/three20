//
//  WPUMShareManeger.m
//  woPass
//
//  Created by 王蕾 on 15/8/11.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPUMShareManeger.h"
#import "NSObject+TZExtension.h"

#define LL(x) x

@implementation WPUMShareManeger

- (void)shareWithmShareUrl:(NSString *)shareUrl andContent:(NSString *)content andImage:(NSString *)imageUrl{
    self.mShareUrl = @"https://i.wo.cn";
    self.mContent = content;
    self.mImageUrl = imageUrl;
    [self share];
}
- (void)share{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_backView];
    [self MoveIn];
    self.mRootCtrl = [self getCurrentViewController];
}
+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    static WPUMShareManeger *manager;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initRegisterManager];
    });
    return manager;
}
- (instancetype)init
{
    return nil;
}

- (instancetype)initRegisterManager
{
    self = [super init];
    if (self) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        
        _mPlatforms = @[UMShareToWechatSession, UMShareToWechatTimeline];
        
        [self initShareView];
    }
    return self;
}
- (void)OnThirdClick:(UIButton *)sender
{
    [self MoveOut];
    NSString *content = self.mContent;
    if (!content) {
        content = @"";
    }
    content = [content stringByAppendingString:@"下载“沃通行证”，精彩活动，不容错过！"];
//    if (self.mShareUrl) {
//        content = [content stringByAppendingFormat:@" %@", self.mShareUrl];
//    }
    
    
    NSInteger index = sender.tag-1300;
    NSString *platform = [self.mPlatforms objectAtIndex:index];

    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.mShareUrl;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = self.mContent;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.mShareUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.mContent;
    
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[platform] content:content image:nil location:nil urlResource:[[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeImage url:self.mImageUrl] presentedController:self.mRootCtrl completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        } else if(response.responseCode != UMSResponseCodeCancel) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        }
    }];
    
}

- (void)initShareView{
    _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, _backView.frame.size.width, 275)];
    _shareView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _shareView.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
    [_backView addSubview:_shareView];
    
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, _backView.frame.size.width, 30)];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:17];
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.text = @"分享";
    [_shareView addSubview:lbTitle];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 230, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
    [_shareView addSubview:lineView];
    
    UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    cancle.backgroundColor = [UIColor clearColor];
    cancle.frame = CGRectMake(0, 230, SCREEN_WIDTH, 45);
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    [cancle setTitleColor:RGBCOLOR_HEX(kLabelDarkColor) forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(MoveOut) forControlEvents:UIControlEventTouchUpInside];
    [_shareView addSubview:cancle];
    
    int iTop = 40;
    int iWidth = 70;
    int iHeight = 84;
    
    int iOffset = (_shareView.frame.size.width-iWidth*4)/5;
    int iLeft = iOffset;
    NSArray *array = [self GetIconList];
    NSArray *namearray = [self GetNameList];
    
    for (int i = 0; i < array.count; i ++) {
        NSString *imagename = [NSString stringWithFormat:@"%@", [array objectAtIndex:i]];
        UIButton *sharebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sharebtn.frame = CGRectMake(iLeft, iTop, iWidth, iHeight);
        sharebtn.backgroundColor = [UIColor clearColor];
        sharebtn.tag = i+1300;
        [sharebtn addTarget:self action:@selector(OnThirdClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:sharebtn];
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, iWidth, iWidth)];
        icon.image = [UIImage imageNamed:imagename];
        [sharebtn addSubview:icon];
        
        UILabel *lbName = [[UILabel alloc] initWithFrame:CGRectMake(0, sharebtn.frame.size.height-15, sharebtn.frame.size.width, 15)];
        lbName.backgroundColor = [UIColor clearColor];
        lbName.font = [UIFont systemFontOfSize:12];
        lbName.textAlignment = NSTextAlignmentCenter;
        lbName.textColor = [UIColor darkGrayColor];
        lbName.text = [namearray objectAtIndex:i];
        [sharebtn addSubview:lbName];
        
        iLeft += (iWidth+iOffset);
        if (i == 3) {
            iLeft = iOffset;
            iTop += iHeight;
        }
    }
}
- (void)MoveOut{
    [UIView animateWithDuration:0.4 animations:^{
        _shareView.top = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [_backView removeFromSuperview];
    }];
}
- (void)MoveIn{
    [UIView animateWithDuration:0.4 animations:^{
        _shareView.top = _backView.frame.size.height-275;
    } completion:^(BOOL finished) {
        
    }];
}
- (NSArray *)GetIconList {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (NSString *name in self.mPlatforms) {
        if ([name isEqualToString:UMShareToSina]) {
            [array addObject:@"UMS_sina_icon"];
        }
        else if ([name isEqualToString:UMShareToTencent]) {
            [array addObject:@"tencent"];
        }
        else if ([name isEqualToString:UMShareToRenren]) {
            [array addObject:@"renren"];
        }
        else if ([name isEqualToString:UMShareToQzone]) {
            [array addObject:@"UMS_qzone_icon"];
        }
        else if ([name isEqualToString:UMShareToWechatSession]) {
            [array addObject:@"UMS_wechat_session_icon"];
        }
        else if ([name isEqualToString:UMShareToWechatTimeline]) {
            [array addObject:@"UMS_wechat_timeline_icon"];
        }
        else if ([name isEqualToString:UMShareToQQ]) {
            [array addObject:@"UMS_qq_icon"];
        }
        else if ([name isEqualToString:UMShareToLWSession]) {
            [array addObject:@"laiwang"];
        }
        else if ([name isEqualToString:UMShareToFacebook]) {
            [array addObject:@"facebook"];
        }
        else if ([name isEqualToString:UMShareToTwitter]) {
            [array addObject:@"twitter"];
        }
    }
    return array;
}
- (NSArray *)GetNameList {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (NSString *name in self.mPlatforms) {
        if ([name isEqualToString:UMShareToSina]) {
            [array addObject:LL(@"新浪微博")];
        }
        else if ([name isEqualToString:UMShareToTencent]) {
            [array addObject:LL(@"腾讯微博")];
        }
        else if ([name isEqualToString:UMShareToRenren]) {
            [array addObject:LL(@"人人网")];
        }
        else if ([name isEqualToString:UMShareToQzone]) {
            [array addObject:LL(@"QQ空间")];
        }
        else if ([name isEqualToString:UMShareToWechatSession]) {
            [array addObject:LL(@"微信")];
        }
        else if ([name isEqualToString:UMShareToWechatTimeline]) {
            [array addObject:LL(@"朋友圈")];
        }
        else if ([name isEqualToString:UMShareToQQ]) {
            [array addObject:LL(@"QQ")];
        }
        else if ([name isEqualToString:UMShareToLWSession]) {
            [array addObject:LL(@"来往")];
        }
        else if ([name isEqualToString:UMShareToFacebook]) {
            [array addObject:LL(@"Facebook")];
        }
        else if ([name isEqualToString:UMShareToTwitter]) {
            [array addObject:LL(@"Twitter")];
        }
    }
    return array;
}

- (void) ShareWithShareUrl:(NSString *)shareUrl andContent:(NSString *)content andImage:(UIImage *)image andSucceedBlock:(void(^)())succeedBlock andFaildBlock:(void(^)())faildBlock{
    
}



@end








