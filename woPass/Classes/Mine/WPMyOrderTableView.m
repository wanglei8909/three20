//
//  WPMyOrderTableView.m
//  woPass
//
//  Created by 王蕾 on 15/7/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMyOrderTableView.h"
#import "WPSegmented.h"

#import "WPMyOrderListModel.h"

@implementation WPMyOrderTableView



-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
    }
    return self;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"WPMyOrderCell";
    WPMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[WPMyOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        __weak typeof(self) weakSelf = self;
        cell.deleteBlock = ^(WPMyOrderCell *cell){
            [weakSelf DeleteOrder:cell];
        };
        cell.payBlock = ^(WPMyOrderCell *cell){
            [weakSelf PayOrder:cell];
        };
    }
    cell.model = self.data[indexPath.row];
    return cell;
}
- (void)DeleteOrder:(WPMyOrderCell *)cell{
    [BaiduMob logEvent:@"id_order_form" eventLabel:@"del"];
    
    [self.data removeObject:cell.model];
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    //http 删除
    
    NSString *url = @"/u/deleteOrder";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:[NSString stringWithFormat:@"%d",cell.model.id] forKey:@"userOrderId"];
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        
        int code = [responseObject[@"code"] intValue];
        if (code == 0) {
            
        }
        else{
            [self DeleteOrder:cell];
        }
    })];
}

- (void)PayOrder:(WPMyOrderCell *)cell{
    [BaiduMob logEvent:@"id_order_form" eventLabel:@"pay"];
    if (self.payOrder  && self.mDelegate) {
        [self.mDelegate performSelector:self.payOrder withObject:cell];
    }
    /*
     @property (nonatomic, assign)int buyNum;
     @property (nonatomic, copy)NSString *goodsName;
     @property (nonatomic, assign)int id;
     @property (nonatomic, copy)NSString *img;
     @property (nonatomic, assign)int orderPayState;
     @property (nonatomic, assign)int orderPrice;
     @property (nonatomic, assign)int originalPrice;
     */
    
}

@end




