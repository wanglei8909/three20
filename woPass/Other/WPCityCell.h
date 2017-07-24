//
//  WPCityCell.h
//  woPass
//
//  Created by 王蕾 on 15/7/27.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XViewController.h"

typedef void(^OnClick)(NSDictionary *dict);

@interface WPCityCell : UITableViewCell

@property (nonatomic, strong)NSArray *cityArray;
@property (nonatomic, copy)OnClick click;

-(float)LoadContent:(NSArray *)array;

@end
