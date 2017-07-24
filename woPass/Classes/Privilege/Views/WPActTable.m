//
//  WPActTable.m
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPActTable.h"
#import "WPActCell.h"

@implementation WPActTable



-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
    }
    return self;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112 * SCREEN_WIDTH/320 + 30 +10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"WPMyTicketCell";
    WPActCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[WPActCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.data[indexPath.row];
    return cell;
}

@end
