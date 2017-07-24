//
//  WPAboutController.m
//  woPass
//
//  Created by 王蕾 on 15/7/23.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPAboutController.h"
#import "WPBackDoorView.h"

@interface WPAboutController ()

@property (nonatomic, strong)WPBackDoorView *backDoorView;
@property (nonatomic, strong)UIButton *backDoorButton;
@property (nonatomic, assign)NSInteger count;

@end

@implementation WPAboutController

- (UIButton *)backDoorButton {
    if (!_backDoorButton) {
        _backDoorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backDoorButton setTitle:@"kakaka" forState:UIControlStateNormal];
        [_backDoorButton x_sizeToFit];
        [_backDoorButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backDoorButton setTitleColor:RGBCOLOR_HEX(kBackgroundColor) forState:UIControlStateNormal];
        [self.view addSubview:_backDoorButton];
    }
    return _backDoorButton;
}

- (WPBackDoorView *)backDoorView {
    if (!_backDoorView) {
        _backDoorView = [WPBackDoorView backDoorViewOnClick:^(NSInteger index) {
            
            switch (index) {
                case WPBackDoorOnLine: {
                    [[NSUserDefaults standardUserDefaults] setObject:BASEURLONLINE forKey:BASEURLKEY];
                    [[NSUserDefaults standardUserDefaults] setObject:SSOBASEURLONLINE forKey:SSOBASEURLKEY];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                    break;
                case WPBackDoorTest: {
                    [[NSUserDefaults standardUserDefaults] setObject:BASEURLTEST forKey:BASEURLKEY];
                    [[NSUserDefaults standardUserDefaults] setObject:SSOBASEURLTEST forKey:SSOBASEURLKEY];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                    break;
                case WPBackDoorDev: {
                    [[NSUserDefaults standardUserDefaults] setObject:BASEURLDEV forKey:BASEURLKEY];
                    [[NSUserDefaults standardUserDefaults] setObject:SSOBASEURLDEV forKey:SSOBASEURLKEY];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                    break;
                default:
                    break;
            }
        }];
        [self.view addSubview:_backDoorView];
    }
    return _backDoorView;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    //[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
    NSString *version = [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    //AboutLogo
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    logo.center = CGPointMake(SCREEN_WIDTH*0.5, 58+60);
    logo.image = [UIImage imageNamed:@"Icon-180"];
    [self.view addSubview:logo];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    nameLabel.center = logo.center;
    nameLabel.top = logo.bottom+5;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
    nameLabel.text = @"沃通行证";
    [self.view addSubview:nameLabel];
    
    UILabel *vLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 14)];
    vLabel.center = nameLabel.center;
    vLabel.top = nameLabel.bottom;
    vLabel.textAlignment = NSTextAlignmentCenter;
    vLabel.backgroundColor = [UIColor clearColor];
    vLabel.font = [UIFont systemFontOfSize:13];
    vLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
    vLabel.text = APPVERSION;
    [self.view addSubview:vLabel];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, vLabel.bottom+20, SCREEN_WIDTH, 90)];
    back.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:back];
    
    for (int i = 0; i<3; i++) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, i*45, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [back addSubview:lineView];
    }
    
    for (int i = 0; i<2; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, i*45, 60, 45)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        label.font = [UIFont systemFontOfSize:15];
        label.text = i==0?@"邮箱：":@"QQ群：";
        [back addSubview:label];
        
        UITextView *field = [[UITextView alloc]initWithFrame:CGRectMake(65, 5+i*45, SCREEN_WIDTH-100, 45)];
        //field.text =
        field.text = i==0?@"wokefu@wo.cn":@"280996956";
        field.backgroundColor = [UIColor clearColor];
        field.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        field.font = [UIFont systemFontOfSize:15];
        field.editable = NO;
        field.scrollEnabled = NO;
        [back addSubview:field];
    }
    
    self.backDoorView.frame = CGRectMake(0, 100, 200, 30);
    self.backDoorView.hidden = YES;
    self.backDoorButton.bottom = SCREEN_HEIGHT;
}

- (void)buttonClick:(id) button {
    
    self.count ++;
    if (self.count > 5) {
        
        self.count = 0;
        self.backDoorView.hidden = NO;
    }
}

- (BOOL)hideNavigationBar
{
    return YES;
}

- (BOOL)hasYDNavigationBar
{
    return YES;
}

- (BOOL)autoGenerateBackBarButtonItem
{
    return YES;
}

- (NSString *)title {
    return @"关于";
}

@end
