//
//  WPBackDoorView.h
//  woPass
//
//  Created by htz on 15/8/11.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WPBackDoorOnLine = 0xff,
    WPBackDoorTest,
    WPBackDoorDev,
} WPBackDoorType;

typedef void(^Action)(NSInteger index);

@interface WPBackDoorView : UIView

@property (nonatomic, copy)Action buttonSelectAction;

+ (instancetype)backDoorViewOnClick:(Action) buttonSelectAction;

@end
