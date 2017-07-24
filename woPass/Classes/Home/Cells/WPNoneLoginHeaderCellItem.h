//
//  WPNoneLoginHeaderCellItem.h
//  woPass
//
//  Created by htz on 15/7/23.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XTableViewCellItem.h"
#import "XTableViewCell.h"
#import "NIAttributedLabel.h"

typedef void(^Action)(void);

@interface WPNoneLoginHeaderCellItem : XTableViewCellItem

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subTitle;
@property (nonatomic, copy)NSString *leftButtonTitle;
@property (nonatomic, copy)NSString *rightButtonTitle;
@property (nonatomic, copy)NSString *phoneNumber;


@property (nonatomic, copy)NSString *locationImageName;
@property (nonatomic, copy)NSString *locationTitle;
@property (nonatomic, copy)NSString *locationSubTitle;
@property (nonatomic, copy)NSString *locationAccessoryImageName;
@property (nonatomic, assign, readonly)BOOL useLarger;

@property (nonatomic, copy)Action leftButtonAction;
@property (nonatomic, copy)Action rightButtonAction;
@property (nonatomic, copy)Action lowerAction;
@property (nonatomic, copy)Action subTitleClickAction;


- (instancetype)applyLeftAction:(Action)leftButtonAction;
- (instancetype)applyRightButtonAction:(Action)rightButtonAction;
- (instancetype)applyLowerAction:(Action)lowerAction;



@end

@interface WPNoneLoginHeaderCell : XTableViewCell


@end

@interface WPAgreeIconView : UIView

- (void)revert;
- (BOOL)isOn;

@end