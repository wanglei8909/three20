//
//  WPRegisterController.h
//  woPass
//
//  Created by 王蕾 on 15/7/17.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XListTableViewController.h"
#import "NIAttributedLabel.h"

typedef void(^loginFinish)();

@interface WPRegisterController : XListTableViewController<NIAttributedLabelDelegate>

@property (nonatomic, copy)loginFinish finishBlock;

@end
