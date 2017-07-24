//
//  WPMIneAppCellItem.h
//  woPass
//
//  Created by htz on 15/7/13.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "TZBasicCellItem.h"
#import "WPstarLevelVIew.h"
#import "MJExtension.h"

@interface WPMIneAppCellItem : TZBasicCellItem

@property (nonatomic, copy)NSString *subTitle;
@property (nonatomic, assign)NSInteger starLevel;
@property (nonatomic, copy)NSString *imageURL;
@property (nonatomic, copy)NSString *actionURL;
@property (nonatomic, copy)NSString *itemId;
@property (nonatomic, copy)NSString *bindUrl;


@end


@interface WPMIneAppCell : TZBasicCell

@property (nonatomic, strong)NIAttributedLabel *subTitleLable;
@property (nonatomic, strong)WPstarLevelVIew *starLevelView;
@property (nonatomic, strong)UIButton *accessoryButton;

@end