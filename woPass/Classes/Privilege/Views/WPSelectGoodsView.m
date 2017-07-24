//
//  WPSelectGoodsView.m
//  woPass
//
//  Created by 王蕾 on 15/8/3.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPSelectGoodsView.h"

@implementation WPSelectGoodsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = [[NSMutableArray alloc]initWithCapacity:10];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
        title.text = @"可选宝贝";
        title.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        title.font = [UIFont systemFontOfSize:16];
        title.backgroundColor = [UIColor clearColor];
        [self addSubview:title];
    }
    return self;
}

-(void)dealloc{
    _dataArray = nil;
}
-(void)LoadContent:(NSArray *)dataArray{
    [_dataArray removeAllObjects];
    if ([self viewWithTag:1000]) [[self viewWithTag:1000] removeFromSuperview];
    if ([self viewWithTag:1001]) [[self viewWithTag:1001] removeFromSuperview];
    

//    NSMutableDictionary *nDict = [dict[@"nation"] mutableCopy];
//    if (nDict && [nDict isKindOfClass:[NSMutableDictionary class]]) {
//        [nDict setObject:dict[@"productName"] forKey:@"productName"];
//        [nDict setObject:@"全国" forKey:@"name"];
//        [_dataArray addObject:nDict];
//    }
//    NSMutableDictionary *lDict = [dict[@"local"] mutableCopy];
//    if (lDict &&[lDict isKindOfClass:[NSMutableDictionary class]]) {
//        [lDict setObject:dict[@"productName"] forKey:@"productName"];
//        [lDict setObject:@"本地" forKey:@"name"];
//        [_dataArray addObject:lDict];
//    }
    
    _seleDict = _dataArray[0];
    
    for (int i = 0; i<_dataArray.count; i++) {
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        view.frame = CGRectMake(0, 20+i*80, self.frame.size.width, 70);
        view.backgroundColor = [UIColor whiteColor];
        [view setBackgroundImage:[[UIImage imageNamed:@"weixuanzhong"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 5, 10, 5)] forState:UIControlStateNormal];
        [view setBackgroundImage:[UIImage imageNamed:@"xuazhongtop02"] forState:UIControlStateSelected];
        [view addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        view.tag = 1000+i;
        [self addSubview:view];
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, view.width-80, 16)];
        name.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        name.font = [UIFont systemFontOfSize:16];
        name.text = _dataArray[i][@"name"];
        [view addSubview:name];
        
        UILabel *des = [[UILabel alloc]initWithFrame:CGRectMake(10, name.bottom, view.width-80, 40)];
        des.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        des.numberOfLines = 2;
        des.font = [UIFont systemFontOfSize:14];
        des.text = _dataArray[i][@"description"];
        [view addSubview:des];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(view.width-75, 15, 1, view.height-30)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [view addSubview:line];
        
        UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(view.width-75, 0, 75, view.height)];
        price.textAlignment = NSTextAlignmentCenter;
        price.textColor = RGBCOLOR_HEX(KTextOrangeColor);
        price.backgroundColor =[UIColor clearColor];
        price.font = [UIFont systemFontOfSize:14];
        float priceValue = [_dataArray[i][@"price"] floatValue];
        price.text = [NSString stringWithFormat:@"￥%.2f",priceValue];
        [view addSubview:price];
        
        if (i==0) {
            view.selected = YES;
        }
        
        self.height = view.bottom + 10;
    }
}
-(void)Click:(UIButton *)sender{
    if ([self viewWithTag:1000]) [(UIButton *)[self viewWithTag:1000] setSelected:NO];
    if ([self viewWithTag:1001]) [(UIButton *)[self viewWithTag:1001] setSelected:NO];
    
    sender.selected = YES;
    
    _seleDict = _dataArray[sender.tag-1000];
}



@end







