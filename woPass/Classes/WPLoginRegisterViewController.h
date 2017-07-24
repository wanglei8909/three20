//
//  WPLoginRegisterViewController.h
//  woPass
//
//  Created by 王蕾 on 15/7/16.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XViewController.h"

typedef void (^LogInBlock)(id info);

@interface WPLoginRegisterViewController : XViewController<UITextFieldDelegate>

@property (nonatomic, strong) LogInBlock loginFinish;

@end
