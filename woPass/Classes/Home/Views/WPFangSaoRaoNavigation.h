//
//  WPFangSaoRaoNavigation.h
//  woPass
//
//  Created by 王蕾 on 16/2/25.
//  Copyright © 2016年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WPFangSaoRaoNavigationBackBlock)();

@interface WPFangSaoRaoNavigation : UIView

@property (nonatomic, copy)NSString *iTitle;
@property (nonatomic, copy)WPFangSaoRaoNavigationBackBlock backBlock;

@end
