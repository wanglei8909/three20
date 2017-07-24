//
//  WPMoreServiceController.m
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMoreServiceController.h"
#import "WPAppListModel.h"
#import "UIImageView+WebCache.h"
#import "WPURLManager.h"

@implementation WPMoreServiceController
///life/apps

{
    UIScrollView *scroller;
    NSMutableArray *dataArray;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    dataArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0,44, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scroller.showsVerticalScrollIndicator =NO;
    scroller.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scroller];
    
    [self RequestToHttp];
}



- (void)RequestToHttp{
    
    NSString *url = @"/life/apps";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        NSArray *cArray = responseObject[@"data"][@"appList"];
        
        for (NSDictionary *dict in cArray) {
            WPAppListModel *model = [WPAppListModel objectWithKeyValues:dict];
            [dataArray addObject:model];
        }
        [self ReloadUI];
    })];
}
- (void)ReloadUI{
    
    float width = SCREEN_WIDTH/3;
    float scale = SCREEN_WIDTH / 320;
    float heigh = width;
    float left = 0;
    float top = 0;
    
    for (int i = 0; i < dataArray.count; i++) {
        WPAppListModel *model = dataArray[i];
        if (i%3==0 && i!=0) {
            left = 0;
            top += heigh;
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(left-0.25, top-0.25, width+0.5, heigh+0.5);
        btn.backgroundColor = [UIColor clearColor];
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [scroller addSubview:btn];
        
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 41*scale, 45*scale)];
        icon.center = CGPointMake(btn.width*0.5, btn.height*0.5-15);
        [icon sd_setImageWithURL:[NSURL URLWithString:model.appHomeIcon] placeholderImage:nil];
        [btn addSubview:icon];
        
        UILabel *morename = [[UILabel alloc]initWithFrame:CGRectMake(-20, icon.bottom+5, width+40, 20)];
        morename.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        morename.backgroundColor = [UIColor clearColor];
        morename.font = [UIFont systemFontOfSize:14];
        morename.textAlignment = NSTextAlignmentCenter;
        morename.text = model.appName;
        [btn addSubview:morename];
        
        left += width;
        
        if (i==dataArray.count-1) {
            scroller.contentSize = CGSizeMake(SCREEN_WIDTH, top+heigh);
        }
    }
    
}

- (void)BtnClick:(UIButton *)sender{
    NSInteger tag = sender.tag - 100;
    WPAppListModel *model = dataArray[tag];
    [WPURLManager openURLWithMainTitle:model.appName urlString:model.appUrl];
    
    [self LogBaiduMob:@"id_life_serve" :@"more" :tag+1];
}
- (void)LogBaiduMob:(NSString *)event :(NSString *)sub :(NSInteger)tag{
    NSString *label = [sub stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)tag]];
    [BaiduMob logEvent:event eventLabel:label];
}
//
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
    return @"更多";
}

@end
