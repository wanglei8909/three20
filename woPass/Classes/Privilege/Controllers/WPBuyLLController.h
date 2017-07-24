//
//  WPBuyLLController.h
//  woPass
//
//  Created by 王蕾 on 15/7/31.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import "WPLLPackageView.h"
#import "WPSelectGoodsView.h"

@interface WPBuyLLController : XViewController<ABPeoplePickerNavigationControllerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ABPeoplePickerNavigationController *picker;

@end
