//
//  WPtableView.m
//  woPass
//
//  Created by 王蕾 on 15/7/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPtableView.h"

@implementation WPtableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.scrollEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource =self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        NSArray *idleImages = @[[UIImage imageNamed:@"s1"]];
        NSArray *refreshingImages = @[[UIImage imageNamed:@"s1"],[UIImage imageNamed:@"s2"],[UIImage imageNamed:@"s3"],[UIImage imageNamed:@"s4"],[UIImage imageNamed:@"s5"],[UIImage imageNamed:@"s6"],[UIImage imageNamed:@"s7"],[UIImage imageNamed:@"s8"]];
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        // 设置普通状态的动画图片
        [header setImages:idleImages forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [header setImages:idleImages forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
        header.lastUpdatedTimeLabel.hidden = YES;
        // 设置header
        self.header = header;
        __weak typeof(self) weakSelf = self;
        self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (weakSelf.loadMore) {
                weakSelf.loadMore();
            }
        }];
    }
    return self;
}
- (void)loadNewData{
    if (self.refresh) {
        self.refresh();
    }
}

- (void)setData:(NSMutableArray *)data{
    _data = data;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didSelectRow) {
        self.didSelectRow(self,indexPath);
    }
}




@end
