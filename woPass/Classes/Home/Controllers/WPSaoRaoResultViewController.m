//
//  WPSaoRaoResultViewController.m
//  woPass
//
//  Created by 王蕾 on 16/2/26.
//  Copyright © 2016年 unisk. All rights reserved.
//

#import "WPSaoRaoResultViewController.h"
#import "WPFangSaoRaoNavigation.h"
#import "MenuItem.h"
#import "PopMenu.h"

@interface WPSaoRaoResultViewController ()
@property (nonatomic, strong)UIImageView *image;
@property (nonatomic, strong)UILabel *tipLabel;
@property (nonatomic, strong)UIButton *iButton;
@property (nonatomic, strong)UILabel *resultLabel;

@property (nonatomic, copy)NSString *phoneNum;

@property (nonatomic, strong)PopMenu *popMenu;
@end

@implementation WPSaoRaoResultViewController

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query {
    if (self = [super initWithNavigatorURL:URL query:query]) {
        _phoneNum = query[@"phoneNum"];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    weaklySelf();
    WPFangSaoRaoNavigation *navigation = [[WPFangSaoRaoNavigation alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    navigation.iTitle = @"查询结果";
    navigation.backBlock = ^{
        [weakSelf dismiss];
    };
    [self.view addSubview:navigation];
    
    _image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 95, 95)];
    _image.image = [UIImage imageNamed:@"saoraoweikaitong"];
    _image.center = CGPointMake(SCREEN_WIDTH*0.5, 64+80);
    [navigation addSubview:_image];
    
    _tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _image.bottom+20, SCREEN_WIDTH, 30)];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.textColor = [UIColor whiteColor];
    _tipLabel.text = @"北京联通";
    [navigation addSubview:_tipLabel];
    
    _resultLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _tipLabel.bottom+5, SCREEN_WIDTH, 40)];
    _resultLabel.centerX = SCREEN_WIDTH*0.5;
    _resultLabel.textColor = [UIColor whiteColor];
    _resultLabel.textAlignment = NSTextAlignmentCenter;
    _resultLabel.font = [UIFont systemFontOfSize:kFontMiddle];
    _resultLabel.text = [NSString stringWithFormat:@"%@  未发现骚扰行为",_phoneNum];
    [navigation addSubview:_resultLabel];
    
    _iButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _iButton.frame = CGRectMake(0, _tipLabel.bottom+50, 150, 25);
    _iButton.centerX = SCREEN_WIDTH*0.5;
    _iButton.backgroundColor = [UIColor clearColor];
    _iButton.layer.masksToBounds = YES;
    _iButton.layer.cornerRadius = 12.5;
    _iButton.layer.borderWidth = 1;
    _iButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [_iButton setTitle:@"标记它，下次别来骚扰我" forState:UIControlStateNormal];
    [_iButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _iButton.titleLabel.font = [UIFont systemFontOfSize:kFontTiny];
    [_iButton addTarget:self action:@selector(markIt) forControlEvents:UIControlEventTouchUpInside];
    [navigation addSubview:_iButton];
    
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-70, 75, 41)];
    logo.centerX = SCREEN_WIDTH * 0.5;
    logo.image = [UIImage imageNamed:@"saoraoliantong"];
    [navigation addSubview:logo];
}

- (void)markIt{

    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    
    NSArray *nameArray = @[@"骚扰电话",@"广告推销",@"房产中介",@"诈骗电话",@"理财",@"保险",@"快递",@"出租",@"猎头"];
    for (int i = 0; i<9; i++) {
        NSString *imageName = [NSString stringWithFormat:@"saoraosaorao%d",11+i];
        
        MenuItem *menuItem = [MenuItem itemWithTitle:nameArray[i] iconName:imageName glowColor:[UIColor whiteColor]];
        [items addObject:menuItem];
    }
    if (!_popMenu) {
    _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
    _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
    }
    if (_popMenu.isShowed) {
        return;
    }
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        NSLog(@"%@,%ld",selectedItem.title,(long)selectedItem.index);
    };

    [_popMenu showMenuAtView:self.view];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)hideNavigationBar
{
    return YES;
}

- (BOOL)hasYDNavigationBar
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
