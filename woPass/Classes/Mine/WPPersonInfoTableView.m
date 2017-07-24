//
//  WPPersonInfoTableView.m
//  woPass
//
//  Created by 王蕾 on 15/7/16.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPPersonInfoTableView.h"
#import "WPDatePickerView.h"
#import "UIImageView+WebCache.h"
#import "WPModifyUserInfoViewModel.h"
#import "WTVAlertView.h"
#import "NSObject+TZExtension.h"

@implementation WPPersonInfoTableView


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.scrollEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource =self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.titleArray = @[@[@"头像",@"昵称",@"绑定手机"],@[@"性别",@"出生日期"],@[@"地区",@"个性签名"]];
        [self InitSubView];
        [self initImagePicker];
    }
    
    return self;
}
- (void)InitSubView{
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    _headImageView.right = SCREEN_WIDTH - 30;
    _headImageView.image = [UIImage imageNamed:@"iconfont-touxiang"];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 35*0.5;
    _headImageView.top = 10;
   
    _nikeName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 45)];
    _nikeName.right = SCREEN_WIDTH - 30;
    _nikeName.textAlignment = NSTextAlignmentRight;
    _nikeName.font = [UIFont systemFontOfSize:12];
    _nikeName.textColor = RGBCOLOR_HEX(0x999999);
//    
//    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 45)];
//    _numLabel.right = SCREEN_WIDTH - 30;
//    _numLabel.textAlignment = NSTextAlignmentRight;
//    _numLabel.font = [UIFont systemFontOfSize:16];
//    _numLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
    
    _sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 45)];
    _sexLabel.right = SCREEN_WIDTH - 30;
    _sexLabel.textAlignment = NSTextAlignmentRight;
    _sexLabel.font = [UIFont systemFontOfSize:12];
    _sexLabel.textColor = RGBCOLOR_HEX(0x999999);
    
    _areaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 45)];
    _areaLabel.right = SCREEN_WIDTH - 30;
    _areaLabel.textAlignment = NSTextAlignmentRight;
    _areaLabel.font = [UIFont systemFontOfSize:12];
    _areaLabel.textColor = RGBCOLOR_HEX(0x999999);
    
    _birthdayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 45)];
    _birthdayLabel.right = SCREEN_WIDTH - 30;
    _birthdayLabel.textAlignment = NSTextAlignmentRight;
    _birthdayLabel.font = [UIFont systemFontOfSize:12];
    _birthdayLabel.textColor = RGBCOLOR_HEX(0x999999);
    
    _signLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 45)];
    _signLabel.right = SCREEN_WIDTH - 30;
    _signLabel.textAlignment = NSTextAlignmentRight;
    _signLabel.font = [UIFont systemFontOfSize:12];
    _signLabel.textColor = RGBCOLOR_HEX(0x999999);
}

- (void)LoadUserData{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:gUser.avatarImg] placeholderImage:[UIImage imageNamed:@"iconfont-touxiang"]];
    _nikeName.text = gUser.nickname;
    //_numLabel.text = gUser.mobile;
    _sexLabel.text = gUser.gender;
    _birthdayLabel.text = gUser.birthday;
    _areaLabel.text = gUser.city;
    _signLabel.text = gUser.signature;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 2;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"PersonInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //[cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self LoadTitleViewIn:cell.contentView AtIndexpath:indexPath];
    [self AddTopLine:cell.contentView isFull:indexPath.row == 0];
    if (indexPath.row == [self.titleArray[indexPath.section] count]-1) {
        [self AddbottomLine:cell.contentView];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell.contentView addSubview:_headImageView];
        }else if (indexPath.row == 1){
            [cell.contentView addSubview:_nikeName];
        }else{
            //[cell.contentView addSubview:_numLabel];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            [cell.contentView addSubview:_sexLabel];
        }else if (indexPath.row == 1){
            [cell.contentView addSubview:_birthdayLabel];
        }
    }else{
        if (indexPath.row == 0) {
            [cell.contentView addSubview:_areaLabel];
        }else if (indexPath.row == 1){
            [cell.contentView addSubview:_signLabel];
        }
    }
    
    return cell;
}
#pragma mark - choose carmer ,image library

- (void)gainPhotoFromPhotogallery
{
    _pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.rootCtrl presentViewController:_pickerVC animated:YES completion:^{
        
    }];
}

- (void)gainPhotoFromCamera
{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        _pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        _pickerVC.mediaTypes = @[@"public.image"];
        
        [self.rootCtrl presentViewController:_pickerVC animated:YES completion:^{
            
        }];
    }
    else{
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"请注意" message:@"设备不支持相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alterView show];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *image = nil;
    if([type isEqualToString:@"public.image"]){
        
        if (_pickerVC.allowsEditing) {
            image = [info objectForKey:UIImagePickerControllerEditedImage];
            
        }
        else{
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
    }
    
    [_pickerVC dismissViewControllerAnimated:YES completion:^{
        [_headImageView setImage:image];
//        //        icon
        NSData *imageData = UIImagePNGRepresentation(image);
        gUser.avatarImgData = imageData;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [WPModifyUserInfoViewModel ChangeUserHeaderImage:image AndSecceed:^(NSString * imageUrl){
                
            }];
        });
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_pickerVC dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)initImagePicker
{
    _pickerVC = [[UIImagePickerController alloc] init];
    _pickerVC.allowsEditing = YES;
    _pickerVC.delegate = self;
}

#pragma mark - alert show
-(void)showIconEditAlert
{
    WTVAlertView *alert = [[WTVAlertView alloc] initWithTitle:@"设置您的头像" message:nil delegate:self buttonTitles:@[@"照相",@"从图库选择"] buttonImageNames:@[@"systemCamera",@"systemPhotoAlbum"]];
    alert.tag = 0;
    [alert show];
}

#pragma mark - AlertView delegate
-(void)wtvAlertView:(WTVAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==0) {
        switch (buttonIndex) {
            case 0:
            {
                //相机
                [self gainPhotoFromCamera];
            }
                break;
            case 1:
            {
                //系统相册
                [self gainPhotoFromPhotogallery];
                
            }
                break;
            default:
                break;
        }
    }
}
- (void)RequestHttps{
    [_rootCtrl showLoading:YES];
    
    NSString *url = @"/u/userBaseInfo";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    weaklySelf();
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        NSLog(@"---%@\n--->%@",gUser.avatarImg,responseObject[@"data"][@"avatarImg"]);
        NSString *code = responseObject[@"code"];
        if ([code intValue]==0) {
            NSDictionary *dataDict = responseObject[@"data"];
            [gUser SetLogin:dataDict];
            
            //根据 regionCode 设置地区
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"region(1)" ofType:@"txt"];
            NSString *str = [[NSString alloc]initWithContentsOfFile:plistPath encoding:NSUTF8StringEncoding error:nil];
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *city = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            for (NSDictionary *dict in city) {
                for (NSDictionary *cDict in dict[@"cities"]) {
                    if ([cDict[@"id"] intValue] == [dataDict[@"regionCode"] intValue]) {
                        [gUser setCity:cDict[@"name"]];
                        break;
                    }
                }
            }
        }
        
        [weakSelf LoadUserData];
        
        [weakSelf.rootCtrl hideLoading:YES];
        
        [weakSelf.rootCtrl showHint:msg hide:1];
    })];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([UserAuthorManager gainCurrentStateForUserLoginAndBind] == 0) {
        [UserAuthorManager authorizationLogin:nil andSuccess:^{
            [self RequestHttps];
        }andFaile:^{
            
        }];
        return;
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //头像
            [self showIconEditAlert];
        }else if (indexPath.row == 1){
            //nike
            [@"WP://WPNikeController" openWithQuery:nil animated:YES];
        }else{
            //num 账号
            [@"WP://WPPhoneNumController" openWithQuery:nil animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            //性别
            [@"WP://WPSexController" openWithQuery:nil animated:YES];
        }else if (indexPath.row == 1){
            //生日
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            WPDatePickerView *datePicker = [[WPDatePickerView alloc]initWithFrame:window.bounds];
            datePicker.delegate = self;
            datePicker.OnPickerCancel = @selector(PickerCancelClck:);
            datePicker.OnPickerSelect = @selector(PickerSelectClick:);
            [window addSubview:datePicker];
        }
    }else{
        if (indexPath.row == 0) {
            //地区
            if (!_cityController) {
                weaklySelf();
                _cityController = [[WPMyCityController alloc]init];
                _cityController.finishBlock = ^(NSDictionary *dict){
                    weakSelf.areaLabel.text = dict[@"name"];
                    gUser.city = dict[@"name"];
                    NSString *url = @"/u/modifyUserBaseInfo";
                    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
                    [parametersDict setObject:dict[@"id"] forKey:@"regionCode"];
                    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
                        
                        int code = [responseObject[@"code"] intValue];
                        if (code == 0) {
                            
                        }
                        else{
                            
                        }
                    })];
                    [weakSelf.rootCtrl dismissViewControllerAnimated:YES completion:nil];
                };
            }
            [self.rootCtrl presentViewController:_cityController animated:YES completion:nil];
            
        }else if (indexPath.row == 1){
            //签名
            [@"WP://WPSignController" openWithQuery:nil animated:YES];
        }
    }
}
- (void)PickerCancelClck:(WPDatePickerView *)picker{
    [picker removeFromSuperview];
}
- (void)PickerSelectClick:(WPDatePickerView *)picker{
    _birthdayLabel.text = picker.mSelectStr;
    [WPModifyUserInfoViewModel ChangeUserInfoWithType:@"birthday" AndValue:_birthdayLabel.text AndSecceed:^{
        
    }];
    [picker removeFromSuperview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 55;
    }else return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}



- (void)LoadTitleViewIn:(UIView *)contentView AtIndexpath:(NSIndexPath *)path{
    float iHeigt = 45;
    if (path.section == 0 && path.row ==0 ) {
        iHeigt = 55;
    }
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, iHeigt)];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = self.titleArray[path.section][path.row];
    [contentView addSubview:titleLabel];
    
    UIImageView *accessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 27/2)];
    [contentView addSubview:accessoryImageView];
    accessoryImageView.center = titleLabel.center;
    //16 - 27
    accessoryImageView.right = SCREEN_WIDTH - 10;
    accessoryImageView.image = [UIImage imageNamed:@"youjiantou-"];
}
- (void)AddTopLine:(UIView *)contentView isFull:(BOOL)full{
    float left = full?0:15;
    float iWidth = full?SCREEN_WIDTH:SCREEN_WIDTH-15;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(left, 0, iWidth, 1)];
    view.backgroundColor = RGBCOLOR_HEX(kMargineColor);
    [contentView addSubview:view];
    
}
- (void)AddbottomLine:(UIView *)contentView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, contentView.bottom, SCREEN_WIDTH, 1)];
    view.backgroundColor = RGBCOLOR_HEX(kMargineColor);
    [contentView addSubview:view];
}

@end





