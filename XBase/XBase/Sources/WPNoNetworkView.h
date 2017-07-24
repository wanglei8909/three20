//
//  WPNoNetworkView.h
//  woPass
//
//  Created by 王蕾 on 15/9/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Reload)();
@interface WPNoNetworkView : UIView

@property (nonatomic, copy) Reload block;

- (instancetype)initWithAdapte:(CGFloat)adapt;

@end
