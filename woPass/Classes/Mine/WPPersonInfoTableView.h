//
//  WPPersonInfoTableView.h
//  woPass
//
//  Created by 王蕾 on 15/7/16.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPBaseTableView.h"
#import "WPMyCityController.h"

@interface WPPersonInfoTableView : WPBaseTableView<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) UIViewController *rootCtrl;
@property (nonatomic, strong) UIImagePickerController *pickerVC;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nikeName;
//@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *sexLabel;
@property (nonatomic, strong) UILabel *birthdayLabel;
@property (nonatomic, strong) UILabel *areaLabel;
@property (nonatomic, strong) UILabel *signLabel;

@property (nonatomic, copy)NSArray *titleArray;
@property (nonatomic, strong) WPMyCityController *cityController;

- (void)LoadUserData;

@end
