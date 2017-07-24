//
//  WPWelfaresBtn.h
//  woPass
//
//  Created by 王蕾 on 15/8/17.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPPriWelfaresModel.h"

@interface WPWelfaresBtn : UIButton

@property (nonatomic, strong) UIImageView *tImage;
@property (nonatomic, strong) UILabel *tLabel;
@property (nonatomic, strong) UILabel *bLabel;

-(void) LoadContentUI:(WPPriWelfaresModel *)model;

@end
