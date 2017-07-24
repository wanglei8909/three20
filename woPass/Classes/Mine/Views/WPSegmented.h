//
//  WPSegmented.h
//  woPass
//
//  Created by 王蕾 on 15/7/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedSegmented)(NSInteger index);

@interface WPSegmented : UIView


- (instancetype) initWithItems:(NSArray *)items andBlock:(SelectedSegmented)selected;

@end
