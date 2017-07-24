//
//  WPFreeWiFiSwitchCellItem.h
//  woPass
//
//  Created by htz on 15/8/2.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "TZBasicCellItem.h"

typedef void(^SwitchChangeAction)(UISwitch *sw, BOOL isOn);

@interface WPFreeWiFiSwitchCellItem : TZBasicCellItem

@property (nonatomic, copy)SwitchChangeAction switchChangeAction;

- (instancetype)applySwitchChangeAction:(SwitchChangeAction) switchChange;

@end

@interface WPFreeWiFiSwitchCell : TZBasicCell

@property (nonatomic, strong)UISwitch *wifiSwitch;
@property (nonatomic, copy)SwitchChangeAction switchChangeAction;

@end
