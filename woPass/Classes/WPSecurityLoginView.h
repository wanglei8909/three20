//
//  WPSecurityLoginView.h
//  woPass
//
//  Created by 王蕾 on 15/10/30.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^seGoLogin)(NSString *mobile,NSString *codeNum);
typedef void(^swiftClick)();

@interface WPSecurityLoginView : UIView

@property (nonatomic, copy) seGoLogin loginBlock;
@property (nonatomic, copy) swiftClick swiftBlock;

@end
