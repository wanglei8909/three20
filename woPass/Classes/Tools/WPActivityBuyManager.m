//
//  WPActivityBuyManager.m
//  woPass
//
//  Created by 王蕾 on 15/8/5.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPActivityBuyManager.h"
#import "WPActGoodsModel.h"

@implementation WPActivityBuyManager



-(void)getParamsFromJavaScript:(NSDictionary *) orderDict{
    /*
     {
     id = 25;
     intro = "1\U3001\U6d3b\U52a8\U4ecb\U7ecd12\U3001\U6d3b\U52a8\U4ecb\U7ecd2\n\t";
     maxNum = null;
     price = "0.01";
     title = "\U6d4b\U8bd5\U6d3b\U52a8\U4e3b\U6807\U98981";
     }*/
    
    WPActGoodsModel *model = [WPActGoodsModel objectWithKeyValues:orderDict];
    [@"WP://WPCommitOrderCtrl" openWithQuery:@{ @"model":model }];
    
    [BaiduMob logEvent:@"id_activity" eventLabel:@"join"];
}


@end
