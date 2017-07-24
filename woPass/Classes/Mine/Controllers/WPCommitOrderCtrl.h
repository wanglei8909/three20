//
//  WPCommitOrderCtrl.h
//  woPass
//
//  Created by 王蕾 on 15/8/3.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XViewController.h"
#import "WPActGoodsModel.h"
#import "WPStepper.h"
#import "NIAttributedLabel.h"

@interface WPCommitOrderCtrl : XViewController<UITextFieldDelegate>

@property (nonatomic, strong) NIAttributedLabel *totalPriceLabel;
@property (nonatomic, strong) WPStepper *numStepper;
@property (nonatomic, strong) WPActGoodsModel *model;


@end
