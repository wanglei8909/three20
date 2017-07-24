//
//  WPWOHuLianLoginView.h
//  woPass
//
//  Created by 王蕾 on 15/10/30.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HuLianLogin)(NSString *mobile);
typedef void(^HulianSecuClick)();

@interface WPWOHuLianLoginView : UIView

@property (nonatomic, copy) HuLianLogin loginBlock;
@property (nonatomic, copy) HulianSecuClick secuBlock;

- (void) loginAgain;

@end
