//
//  WPRandomCodeLoginView.h
//  woPass
//
//  Created by 王蕾 on 15/10/30.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GoLogin)(NSString *mobile,NSString *codeNum);
typedef void(^RandomSecuClick)();

@interface WPRandomCodeLoginView : UIView

@property (nonatomic, assign) int step;
@property (nonatomic, copy) GoLogin loginBlock;
@property (nonatomic, copy) RandomSecuClick secuBlock;
@end
