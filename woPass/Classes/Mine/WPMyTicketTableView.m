//
//  WPMyTicketTableView.m
//  woPass
//
//  Created by 王蕾 on 15/7/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMyTicketTableView.h"
#import "WPMyTicketCell.h"

@implementation WPMyTicketTableView



-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
    }
    return self;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 144;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"WPMyTicketCell";
    WPMyTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[WPMyTicketCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.model = self.data[indexPath.row];
    return cell;
}

@end
