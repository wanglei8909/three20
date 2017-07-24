//
//  WPUserPortrayCtrl.m
//  woPass
//
//  Created by 王蕾 on 15/12/1.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPUserPortrayCtrl.h"
#import "WPDTTPieCell.h"
#import "WPDTTPortrayCell.h"
#import "WPWPDTTimeCell.h"
#import "WPDTTCityCell.h"
#import "WPWPDTTLoginCell.h"
#import "WPLoginHistoryUtil.h"

@implementation WPUserPortrayCtrl
{
    NSDateFormatter *dateFormatter;
}
static NSString *reuseIdentifierPortray = @"IdentifierPortray";
static NSString *reuseIdentifierLogin = @"IdentifierLogin";
static NSString *reuseIdentifierPie = @"IdentifierPie";
static NSString *reuseIdentifierCity = @"IdentifierCity";
static NSString *reuseIdentifierTime = @"IdentifierTime";


- (void)viewDidLoad{
    [super viewDidLoad];
    
    _dataSource = [[NSMutableArray alloc]initWithCapacity:10];
    
    dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"hh:mm";
    [self showLoading:YES];
    [[WPLoginHistoryUtil sharedUtil] fetchLoginHistoryDicListComplete:^(id response, NSString *msg) {
        [self hideLoading:YES];
        if (msg) {
            [self showHint:msg hide:2];
            return ;
        }else{
            NSDictionary *data = [response objectForKey:@"data"];
            NSArray *logs = [data objectForKey:@"logs"];
            for (NSDictionary *logsDict in logs) {
                NSArray *historyArray = [logsDict objectForKey:@"history"];
                //没有设备名的 改作其他
                for (NSDictionary *dict in historyArray) {
                    NSMutableDictionary *mDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
                    if ([[mDict objectForKey:@"loginMobile"] isEqualToString:@""]) {
                        [mDict setObject:@"其他" forKey:@"loginMobile"];
                    }
                    [_dataSource addObject:mDict];
                }
            }
            
            [self dealData];
            UITableView *tableView = [[UITableView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.navigationController.navigationBar.height + 22, 0, 0, 0))];
            tableView.backgroundColor = RGBCOLOR_HEX(0x27424f);
            tableView.delegate = self;
            tableView.dataSource = self;
            [tableView registerClass:[WPDTTPortrayCell class] forCellReuseIdentifier:reuseIdentifierPortray];
            [tableView registerClass:[WPWPDTTLoginCell class] forCellReuseIdentifier:reuseIdentifierLogin];
            if (_loginDeviceArray.count>0) {
                [tableView registerClass:[WPDTTPieCell class] forCellReuseIdentifier:reuseIdentifierPie];
            }
            [tableView registerClass:[WPDTTCityCell class] forCellReuseIdentifier:reuseIdentifierCity];
            [tableView registerClass:[WPWPDTTimeCell class] forCellReuseIdentifier:reuseIdentifierTime];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self.view addSubview:tableView];
        }
    }];
}
- (void)dealData{
    _portrayString = [NSMutableString string];
    _loginAppArray = [[NSMutableArray alloc]initWithCapacity:10];
    _loginDeviceArray = [[NSMutableArray alloc]initWithCapacity:10];
    _cityArray = [[NSMutableArray alloc]initWithCapacity:10];
    _timeArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    _loginAppArray = [self dealloginAppArray];
    _loginDeviceArray = [self dealDeviceArray];
    _cityArray = [self dealCityArray];
    _timeArray = [self dealTimeArray];
    _portrayString = [self dealPortrayString];
}

- (NSMutableString *)dealPortrayString{
    NSString *pString = [[NSString alloc]init];
    
    for (int i = 0; i<(_loginAppArray.count>3?3:_loginAppArray.count); i++) {
        NSDictionary *dict = _loginAppArray[i];
        pString = [pString stringByAppendingString:[NSString stringWithFormat:@"%@ ",[dict objectForKey:@"name"]]];
    }
    for (int i = 0; i<(_cityArray.count>3?3:_cityArray.count); i++) {
        NSDictionary *dict = _cityArray[i];
        pString = [pString stringByAppendingString:[NSString stringWithFormat:@"%@ ",[dict objectForKey:@"name"]]];
    }
    for (int i = 0; i<(_loginDeviceArray.count>3?3:_loginDeviceArray.count); i++) {
        NSDictionary *dict = _loginDeviceArray[i];
        pString = [pString stringByAppendingString:[NSString stringWithFormat:@"%@ ",[dict objectForKey:@"name"]]];
    }
    
    pString = [NSString stringWithFormat:@"%@%@%@%@%@",pString,pString,pString,pString,pString];
    
    return [pString mutableCopy];
}
- (NSMutableArray *)dealloginAppArray{
    NSMutableArray *nameArray = [[NSMutableArray alloc]initWithCapacity:10];
    for (NSDictionary *dict in _dataSource) {
        BOOL have = NO;
        for (NSMutableDictionary *naDict in nameArray) {
            if ([[dict objectForKey:@"loginAppName"] isEqualToString:[naDict objectForKey:@"name"]]) {
                have = YES;
                NSNumber *number = [naDict objectForKey:@"num"];
                [naDict setObject:[NSNumber numberWithInt:([number intValue]+1)] forKey:@"num"];
            }
        }
        if (have == NO) {
            NSMutableDictionary *naDict = [[NSMutableDictionary alloc]initWithCapacity:10];
            [naDict setObject:[dict objectForKey:@"loginAppName"] forKey:@"name"];
            [naDict setObject:[dict objectForKey:@"loginRegion"] forKey:@"region"];
            [naDict setObject:[NSNumber numberWithInt:1] forKey:@"num"];
            [nameArray addObject:naDict];
        }
    }
    //排序 前5
    NSArray *sortedArray = [nameArray sortedArrayUsingComparator:^(NSDictionary *dict1,NSDictionary *dict2) {
        int val1 = [[dict1 objectForKey:@"num"] intValue];
        int val2 = [[dict2 objectForKey:@"num"] intValue];
        if (val1 > val2) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    
    nameArray = [sortedArray mutableCopy];
    
    if (nameArray.count<=5) {
        return nameArray;
    }
    
    int otherNum = 0;
    for (int i = 4; i<nameArray.count; i++) {
        NSMutableDictionary *dict = nameArray[i];
        int num = [dict[@"num"] intValue];
        otherNum += num;
    }
    if (otherNum > 0) {
        nameArray = [[nameArray subarrayWithRange:NSMakeRange(0, 4)] mutableCopy];
        [nameArray addObject:[[NSMutableDictionary alloc] initWithObjects:@[@"其他",[NSNumber numberWithInt:otherNum]] forKeys:@[@"name",@"num"]]];
    }
    return nameArray;
}
- (NSMutableArray *)dealDeviceArray{
    NSMutableArray *nameArray = [[NSMutableArray alloc]initWithCapacity:10];
    for (NSDictionary *dict in _dataSource) {
        if (![dict objectForKey:@"loginMobile"]) {
            return nil;
        }
        
        BOOL have = NO;
        for (NSMutableDictionary *naDict in nameArray) {
            if ([[dict objectForKey:@"loginMobile"] isEqualToString:[naDict objectForKey:@"name"]]) {
                have = YES;
                NSNumber *number = [naDict objectForKey:@"num"];
                [naDict setObject:[NSNumber numberWithInt:([number intValue]+1)] forKey:@"num"];
            }
        }
        if (have == NO) {
            NSMutableDictionary *naDict = [[NSMutableDictionary alloc]initWithCapacity:10];
            [naDict setObject:[dict objectForKey:@"loginMobile"] forKey:@"name"];
            [naDict setObject:[NSNumber numberWithInt:1] forKey:@"num"];
            [nameArray addObject:naDict];
        }
    }
    //排序 前5
    NSArray *sortedArray = [nameArray sortedArrayUsingComparator:^(NSDictionary *dict1,NSDictionary *dict2) {
        int val1 = [[dict1 objectForKey:@"num"] intValue];
        int val2 = [[dict2 objectForKey:@"num"] intValue];
        if (val1 > val2) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    
    
    nameArray = [sortedArray mutableCopy];
    
    //去除 Android_
    for (NSMutableDictionary *dict in nameArray) {
        NSString *name = [dict objectForKey:@"name"];
        if ([name hasPrefix:@"Android_"]) {
            name = [name substringFromIndex:8];
            [dict setObject:name forKey:@"name"];
        }
    }
    
    
    if (nameArray.count<=5) {
        return nameArray;
    }
    
    //之前是否有“其他”
    BOOL have = NO;
    for (NSMutableDictionary *dict in nameArray) {
        for (NSString *key in dict) {
            if ([key isEqualToString:@"其他"]) {
                have = YES;
                break;
            }
        }
    }
    
    if (have) {
        int otherNum = 0;
        for (int i = 5; i<nameArray.count; i++) {
            NSMutableDictionary *dict = nameArray[i];
            int num = [dict[@"num"] intValue];
            otherNum += num;
        }
        if (otherNum > 0) {
            nameArray = [[nameArray subarrayWithRange:NSMakeRange(0, 5)] mutableCopy];
            for (NSMutableDictionary *dict in nameArray) {
                for (NSString *key in dict) {
                    if ([key isEqualToString:@"其他"]) {
                        NSNumber *num = [dict objectForKey:key];
                        num = [NSNumber numberWithInt:([num intValue] + otherNum)];
                        [dict setObject:num forKey:key];
                    }
                }
            }
        }
    }else{
        int otherNum = 0;
        for (int i = 4; i<nameArray.count; i++) {
            NSMutableDictionary *dict = nameArray[i];
            int num = [dict[@"num"] intValue];
            otherNum += num;
        }
        if (otherNum > 0) {
            nameArray = [[nameArray subarrayWithRange:NSMakeRange(0, 4)] mutableCopy];
            [nameArray addObject:[[NSMutableDictionary alloc] initWithObjects:@[@"其他",[NSNumber numberWithInt:otherNum]] forKeys:@[@"name",@"num"]]];
        }
    }
    return nameArray;
}
- (NSMutableArray *)dealCityArray{
    NSMutableArray *nameArray = [[NSMutableArray alloc]initWithCapacity:10];
    for (NSDictionary *dict in _dataSource) {
        BOOL have = NO;
        for (NSMutableDictionary *naDict in nameArray) {
            if ([[dict objectForKey:@"loginRegion"] isEqualToString:[naDict objectForKey:@"name"]]) {
                have = YES;
                NSNumber *number = [naDict objectForKey:@"num"];
                [naDict setObject:[NSNumber numberWithInt:([number intValue]+1)] forKey:@"num"];
            }
        }
        if (have == NO) {
            NSMutableDictionary *naDict = [[NSMutableDictionary alloc]initWithCapacity:10];
            [naDict setObject:[dict objectForKey:@"loginRegion"] forKey:@"name"];
            [naDict setObject:[NSNumber numberWithInt:1] forKey:@"num"];
            [nameArray addObject:naDict];
        }
    }
    //排序 前5
    NSArray *sortedArray = [nameArray sortedArrayUsingComparator:^(NSDictionary *dict1,NSDictionary *dict2) {
        int val1 = [[dict1 objectForKey:@"num"] intValue];
        int val2 = [[dict2 objectForKey:@"num"] intValue];
        if (val1 > val2) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    
    nameArray = [sortedArray mutableCopy];
    
    if (nameArray.count<=5) {
        return nameArray;
    }
    
    //其他
    int otherNum = 0;
    for (int i = 4; i<nameArray.count; i++) {
        NSMutableDictionary *dict = nameArray[i];
        int num = [dict[@"num"] intValue];
        otherNum += num;
    }
    if (otherNum > 0) {
        nameArray = [[nameArray subarrayWithRange:NSMakeRange(0, 4)] mutableCopy];
        [nameArray addObject:[[NSMutableDictionary alloc] initWithObjects:@[@"其他",[NSNumber numberWithInt:otherNum]] forKeys:@[@"name",@"num"]]];
    }
    
    return nameArray;
}
- (NSMutableArray *)dealTimeArray{
    
    int zero     = 0;
    int six      = 6;
    int twelve   = 12;
    int eighteen = 18;
    int twentyFour = [[dateFormatter dateFromString:@"24:00"] timeIntervalSince1970];
    
    int a= 0,b= 0,c= 0,d= 0;
    
    NSMutableArray *aArray = [[NSMutableArray alloc]initWithCapacity:10];
    for (NSDictionary *dict in _dataSource) {
        int date = [[dict objectForKey:@"loginTime"] intValue];
        
        if (date>zero && date<=six) {
            a++;
        } else if (date> six && date <=twelve){
            b++;
        }
        else if (date> twelve && date <=eighteen){
            c++;
        }
        else if (date> eighteen && date <=twentyFour){
            d++;
        }
    }
    
    [aArray addObject:[NSString stringWithFormat:@"%d",a]];
    [aArray addObject:[NSString stringWithFormat:@"%d",b]];
    [aArray addObject:[NSString stringWithFormat:@"%d",c]];
    [aArray addObject:[NSString stringWithFormat:@"%d",d]];
    
    return aArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_loginDeviceArray.count>0) {
        return 5;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            WPDTTPortrayCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierPortray forIndexPath:indexPath];
            if (!cell) {
                cell = [[WPDTTPortrayCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierPortray];
            }
            [cell configUI:_portrayString];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
            
        case 1:
        {
            WPWPDTTLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierLogin forIndexPath:indexPath];
            if (!cell) {
                cell = [[WPWPDTTLoginCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierLogin];
            }
            [cell configUI:_loginAppArray];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
            
        case 2:
        {
            if (_loginDeviceArray.count > 0) {
                WPDTTPieCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierPie forIndexPath:indexPath];
                if (!cell) {
                    cell = [[WPDTTPieCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierPie];
                }
                [cell configUI:_loginDeviceArray];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            else{
                WPDTTCityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierCity forIndexPath:indexPath];
                if (!cell) {
                    cell = [[WPDTTCityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierCity];
                }
                [cell configUI:_cityArray];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            
        }
            break;
            
        case 3:
        {
            if (_loginDeviceArray.count > 0) {
                WPDTTCityCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierCity forIndexPath:indexPath];
                if (!cell) {
                    cell = [[WPDTTCityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierCity];
                }
                [cell configUI:_cityArray];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                WPWPDTTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTime forIndexPath:indexPath];
                if (!cell) {
                    cell = [[WPWPDTTimeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierTime];
                }
                [cell configUI:_timeArray];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            
        }
        case 4:
        {
            WPWPDTTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTime forIndexPath:indexPath];
            if (!cell) {
                cell = [[WPWPDTTimeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierTime];
            }
            [cell configUI:_timeArray];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_loginDeviceArray.count>0) {
        switch (indexPath.row) {
            case 0:
            {
                return 235;
            }
            case 1:{
                return 280;
            }
            case 2:{
                return 315;
            }
            case 3:{
                return 362;
            }
            case 4:{
                return 250;
            }
        }
    }
    switch (indexPath.row) {
        case 0:
        {
            return 235;
        }
        case 1:{
            return 280;
        }
        case 2:{
            return 362;
        }
        case 3:{
            return 250;
        }
    }
    return 0;
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
    return @"我的足迹";
}

@end
