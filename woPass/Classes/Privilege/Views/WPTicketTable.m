//
//  WPTicketTable.m
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPTicketTable.h"
#import "WPTicketCell.h"

@implementation WPTicketTable


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
    WPTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[WPTicketCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    cell.getClick = ^{
        if (self.getTicket) {
            self.getTicket(tableView,indexPath);
        }
    };
    cell.model = self.data[indexPath.row];
    return cell;
}
- (void)dealloc{
    NSLog(@"---dealloc---");
}


@end
