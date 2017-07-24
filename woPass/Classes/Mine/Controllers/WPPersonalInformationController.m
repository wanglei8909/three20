//
//  WPPersonalInformationController.m
//  woPass
//
//  Created by 王蕾 on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPPersonalInformationController.h"


@implementation WPPersonalInformationController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    _tableView = [[WPPersonInfoTableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.rootCtrl = self;
    [self.view addSubview:_tableView];
    [_tableView LoadUserData];
    [self RequestHttps];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView LoadUserData];
}



- (void)RequestHttps{
    [self showLoading:YES];
    
    NSString *url = @"/u/userBaseInfo";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        NSLog(@"---%@\n--->%@",gUser.avatarImg,responseObject[@"data"][@"avatarImg"]);
        NSString *code = responseObject[@"code"];
        if ([code intValue]==0) {
            NSDictionary *dataDict = responseObject[@"data"];
            [gUser SetLogin:dataDict];
            
            //根据 regionCode 设置地区
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"region(1)" ofType:@"txt"];
            NSString *str = [[NSString alloc]initWithContentsOfFile:plistPath encoding:NSUTF8StringEncoding error:nil];
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *city = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            for (NSDictionary *dict in city) {
                for (NSDictionary *cDict in dict[@"cities"]) {
                    if ([cDict[@"id"] intValue] == [dataDict[@"regionCode"] intValue]) {
                        [gUser setCity:cDict[@"name"]];
                        break;
                    }
                }
            }
        }
        
        
        [_tableView LoadUserData];
        
        [self hideLoading:YES];
        
        [self showHint:msg hide:1];
    })];
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
    return @"个人信息";
}

@end
