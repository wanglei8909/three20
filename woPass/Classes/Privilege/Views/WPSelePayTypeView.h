//
//  WPSelePayTypeView.h
//  woPass
//
//  Created by 王蕾 on 15/8/3.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectFinish)(NSInteger btnIndex);


@interface WPSelePayTypeView : UIView

@property (nonatomic, copy) SelectFinish mBlock;

- (void)HiddenView;

@end
