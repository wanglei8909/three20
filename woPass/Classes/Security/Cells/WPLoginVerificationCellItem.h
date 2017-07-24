//
//  WPLoginVerificationCellItem.h
//  woPass
//
//  Created by htz on 15/7/10.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "TZBasicCellItem.h"
#import "WPLocationVerificationView.h"

@interface WPLoginVerificationCellItem : TZBasicCellItem

@property (nonatomic, copy)NSString *subTitle;
@property (nonatomic, strong)NSArray *itemsArray;

@end

@interface WPLoginVerificationCell : TZBasicCell

@property (nonatomic, strong)UISwitch *switchAccessoryView;
@property (nonatomic, strong)NIAttributedLabel *subTitleLabel;
@property (nonatomic, strong)WPLocationVerificationView *locationVerificationView;



@end