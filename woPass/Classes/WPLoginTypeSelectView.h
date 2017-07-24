//
//  WPLoginTypeSelectView.h
//  woPass
//
//  Created by 王蕾 on 15/7/17.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

typedef void (^OnSelectBlock)(NSInteger index);

@interface WPLoginTypeSelectView : UIView

@property (nonatomic, copy) OnSelectBlock selectBlock;


@end
