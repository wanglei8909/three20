//
//  WPLogoffAuthenticationViewController.m
//  woPass
//
//  Created by 王蕾 on 16/2/15.
//  Copyright © 2016年 unisk. All rights reserved.
//

#import "WPLogoffAuthenticationViewController.h"
#import "NIAttributedLabel.h"
#import "WPRealNameVerifcationView.h"
#import "WPButton.h"
#import "WPTextField.h"
#import "WPKeyboardToolBar.h"

@interface WPLogoffAuthenticationViewController ()<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong)NIAttributedLabel *stataLabel;
@property (nonatomic, strong)WPRealNameVerifcationView *nameInputLabel;
@property (nonatomic, strong)WPRealNameVerifcationView *certificateTypeInputLabel;
@property (nonatomic, strong)WPRealNameVerifcationView *certificateNumberInputLabel;
@property (nonatomic, strong)WPButton *verifacationButton;
@property (nonatomic, strong)UIPickerView *certificateTypePicker;
@property (nonatomic, strong)WPKeyboardToolBar *keyboardToolBar;
@property (nonatomic, strong)UIView *maskingView;
@property (nonatomic, strong)NSDictionary *certificateType;
@property (nonatomic, strong)NSArray *certificateTypeArray;
@property (nonatomic, copy)NSString *pickerString;
@property (nonatomic, copy)NSString *pickerCode;
@property (nonatomic, assign)BOOL isAdapted;

@property (nonatomic, strong)UIView *container;

@property (nonatomic, copy)void (^completeAction)(id vc);

@end

@implementation WPLogoffAuthenticationViewController


#pragma mark - getter

- (NIAttributedLabel *)stataLabel {
    if (!_stataLabel) {
        _stataLabel = [NIAttributedLabel labelWithFontSize:kFontTiny color:RGBCOLOR_HEX(kLabelDarkColor)];
        [self.container addSubview:_stataLabel];
    }
    return _stataLabel;
}
- (WPKeyboardToolBar *)keyboardToolBar {
    if (!_keyboardToolBar) {
        
        weaklySelf();
        _keyboardToolBar = [[[WPKeyboardToolBar alloc] init] applyCancelAction:^{
            
            [weakSelf touchesBegan:nil withEvent:nil];
        } configAction:^{
            
            weakSelf.certificateTypeInputLabel.inputTextField.text = weakSelf.pickerString;
            [weakSelf touchesBegan:nil withEvent:nil];
        }];
        _keyboardToolBar.backgroundColor = RGBCOLOR_HEX(0xFBFBFB);
        _keyboardToolBar.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 44);
        _keyboardToolBar.alpha = 1;
        [[[[UIApplication sharedApplication] windows] lastObject] addSubview:_keyboardToolBar];
    }
    return _keyboardToolBar;
}

- (NSDictionary *)certificateType {
    if (!_certificateType) {
        _certificateType = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"certificate" ofType:@"plist"]];
        
    }
    return _certificateType;
}

- (NSArray *)certificateTypeArray {
    if (!_certificateTypeArray) {
        _certificateTypeArray  = [self.certificateType keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj2 compare:obj1 options:NSNumericSearch];
        }];
        
    }
    return _certificateTypeArray;
}

- (UIPickerView *)certificateTypePicker {
    if (!_certificateTypePicker) {
        _certificateTypePicker = [[UIPickerView alloc] init];
        _certificateTypePicker.dataSource = self;
        _certificateTypePicker.delegate = self;
        _certificateTypePicker.backgroundColor = [UIColor whiteColor];
    }
    return _certificateTypePicker;
}

- (UIView *)maskingView {
    if (!_maskingView) {
        _maskingView = [[UIView alloc] init];
        _maskingView.backgroundColor = [UIColor blackColor];
        _maskingView.alpha = 0.5;
        _maskingView.hidden = YES;
        [self.view addSubview:_maskingView];
    }
    return _maskingView;
}

- (WPRealNameVerifcationView *)nameInputLabel {
    if (!_nameInputLabel) {
        weaklySelf();
        _nameInputLabel = [[WPRealNameVerifcationView alloc] initWithTitle:@"姓名" placeholder:@"请输入姓名" beginEdite:^{
            weakSelf.maskingView.hidden = YES;
            weakSelf.keyboardToolBar.hidden = YES;
        }];
        [self.container addSubview:_nameInputLabel];
    }
    return _nameInputLabel;
}

- (WPRealNameVerifcationView *)certificateTypeInputLabel {
    if (!_certificateTypeInputLabel) {
        weaklySelf();
        _certificateTypeInputLabel = [[WPRealNameVerifcationView alloc] initWithTitle:@"证件类型" placeholder:@"请选择证件类型"  beginEdite:^{
            
            weakSelf.maskingView.hidden = NO;
            weakSelf.keyboardToolBar.hidden = NO;
            weakSelf.pickerString = [weakSelf.certificateType objectForKey:weakSelf.certificateTypeArray[0]];
            weakSelf.pickerCode = weakSelf.certificateTypeArray[0];
        }];
        UIButton *rightView = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightView setImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateNormal];
        [rightView setTitle:@"  " forState:UIControlStateNormal];
        [rightView x_sizeToFit];
        _certificateTypeInputLabel.inputTextField.rightView = rightView;
        _certificateTypeInputLabel.inputTextField.rightViewMode = UITextFieldViewModeAlways;
        _certificateTypeInputLabel.inputTextField.inputView = self.certificateTypePicker;
        [self.container addSubview:_certificateTypeInputLabel];
    }
    return _certificateTypeInputLabel;
}

- (WPRealNameVerifcationView *)certificateNumberInputLabel {
    if (!_certificateNumberInputLabel) {
        weaklySelf();
        _certificateNumberInputLabel = [[WPRealNameVerifcationView alloc] initWithTitle:@"证件编号" placeholder:@"请输入证件编号" beginEdite:^{
            
            weakSelf.maskingView.hidden = YES;
            weakSelf.keyboardToolBar.hidden = YES;
            
            if (SCREEN_HEIGHT < 569 && !weakSelf.isAdapted) {
                
                [weakSelf upTableView];
                weakSelf.isAdapted = YES;
            }
        }];
        [self.container addSubview:_certificateNumberInputLabel];
    }
    return _certificateNumberInputLabel;
}

- (WPButton *)verifacationButton {
    if (!_verifacationButton) {
        _verifacationButton = [[WPButton alloc] initWithTitle:@"立即认证"];
        [_verifacationButton addTarget:self action:@selector(clickedVerifacationButton) forControlEvents:UIControlEventTouchUpInside];
        [self.container addSubview:_verifacationButton];
    }
    return _verifacationButton;
}

- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] init];
        _container.backgroundColor = [UIColor clearColor];
        [self.tableView addSubview:_container];
    }
    return _container;
}



- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query {
    
    if (self = [super initWithNavigatorURL:URL query:query]) {
        
        self.completeAction = query[@"completeAction"];

    }
    
    return self;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.navigationController.navigationBar.height + 22, 0, 0, 0))];
    self.container.frame = self.tableView.bounds;
    
    [self keyboardToolBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:NULL];
    
    weaklySelf();
    [self refreshTitleLabel];
    
    [self layout];
}
- (void)getPageContentWithSuccessAction:(void (^)(void)) successAction {
    
    [self showLoading:YES];
    weaklySelf();
    [RequestManeger POST:@"/u/realNameInfo" parameters:nil complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        [weakSelf hideLoading:YES];
        if (!msg) {
            
            if (successAction) {
                successAction();
            }
        }
    })];
}

- (void)refreshTitleLabel {
    
    self.stataLabel.text = [NSString stringWithFormat:@"用户 : %@", gUser.mobile];
    [self.stataLabel setTextColor:RGBCOLOR_HEX(KTextOrangeColor) range:NSMakeRange(5, 11)];
    
    [self.stataLabel x_sizeToFit];
    
    self.nameInputLabel.placeHolder = @"请输入姓名";
    self.nameInputLabel.userInteractionEnabled = YES;
    
    
    self.certificateTypeInputLabel.placeHolder = @"请选择证件类型";
    self.certificateTypeInputLabel.userInteractionEnabled = YES;
    
    self.certificateNumberInputLabel.placeHolder = @"请输入证件编号";
    self.certificateNumberInputLabel.userInteractionEnabled  = YES;
    
}


#pragma mark - 键盘监听方法
- (void)keyboardWillAppear:(id) info {
    
    NSDictionary *userInfo = [info valueForKey:@"userInfo"];
    weaklySelf();
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        weakSelf.keyboardToolBar.bottom = [[userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue].origin.y + 10;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyboardWillDisappear:(id) info {
    
    NSDictionary *userInfo = [info valueForKey:@"userInfo"];
    weaklySelf();
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        weakSelf.keyboardToolBar.top = [[userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue].origin.y;
        weakSelf.maskingView.hidden = YES;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - pickerview代理

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.certificateType.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.pickerString = [self.certificateType objectForKey:self.certificateTypeArray[row]];
    self.pickerCode = self.certificateTypeArray[row];
}

- (NSInteger )rowForCertificateCode:(NSString *)certificateCode {
    
    __block NSInteger index = 0;
    [self.certificateTypeArray enumerateObjectsUsingBlock:^(NSString *code, NSUInteger idx, BOOL *stop) {
        
        if ([code isEqualToString:certificateCode]) {
            
            *stop = YES;
            index = idx;
        }
    }];
    
    return index;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 33;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = [UILabel labelWithFontSize:kFontLarge + 4 color:RGBCOLOR_HEX(kLabelDarkColor)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [self.certificateType objectForKey:self.certificateTypeArray[row]];
    return label;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)upTableView {
    weaklySelf();
    [UIView animateWithDuration:0.25 animations:^{
        
        weakSelf.tableView.top -= 80;
    }];
}

- (void)downTableView {
    weaklySelf();
    [UIView animateWithDuration:0.25 animations:^{
        
        weakSelf.tableView.top += 80;
    }];
}


#pragma mark - 认证按钮点击

- (void)clickedVerifacationButton {
    
    if (SCREEN_HEIGHT < 569 && self.isAdapted) {
        
        [self downTableView];
        self.isAdapted = NO;
    }
    
    if ([self.verifacationButton.titleLabel.text isEqualToString:@"重新认证"]) {
        
        
        self.nameInputLabel.placeHolder = @"";
        self.nameInputLabel.userInteractionEnabled = YES;
        
        self.certificateTypeInputLabel.placeHolder = @"";
        self.certificateTypeInputLabel.inputTextField.text = @"请选择";
        self.certificateTypeInputLabel.userInteractionEnabled =  YES;
        
        self.certificateNumberInputLabel.placeHolder = @"";
        self.certificateNumberInputLabel.userInteractionEnabled = YES;
        [self.verifacationButton setTitle:@"立即认证" forState:UIControlStateNormal];
        
        return;
    }
    
    [self.view endEditing:YES];
    
    NSString *name = self.nameInputLabel.inputTextField.text;
    NSString *type = self.certificateTypeInputLabel.inputTextField.text;
    NSString *number = self.certificateNumberInputLabel.inputTextField.text;
    
    if (!name || [name isEqualToString:@""]) {
        
        [self showHint:@"请输入姓名" hide:1];
        return;
    } else if (!type || [type isEqualToString:@""] || [type isEqualToString:@"请选择"]) {
        
        [self showHint:@"请选择证件类型" hide:1];
        return;
    } else if (!number || [number isEqualToString:@""]) {
        
        [self showHint:@"请输入证件编号" hide:1];
        return;
    }
    
    NSDictionary *param = @{
                            @"realName" : name,
                            @"idcardType" : self.pickerCode,
                            @"idcardNo" : number
                            };
    
    [BaiduMob logEvent:@"id_realname" eventLabel:@"sure"];
    
    weaklySelf();
    [self showLoading:YES];
    [RequestManeger POST:@"/u/realNameAuth" parameters:param complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        [weakSelf hideLoading:YES];
        [weakSelf showHint:msg hide:1];
        if (!msg) {
            [weakSelf getPageContentWithSuccessAction:^{
                
                [weakSelf showHint:@"认证成功" hide:1];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    CallBlock(weakSelf.completeAction, weakSelf);
                });
            }];
        }
    })];
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50 - 55)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)layout {
    
    [self.stataLabel x_sizeToFit];
    
    self.container.top = 0;
    self.stataLabel.top = 15;
    self.stataLabel.left = 15;
    
    self.nameInputLabel.frame = CGRectMake(15, 40, self.tableView.width - 30, 44);
    
    self.certificateTypeInputLabel.frame = self.nameInputLabel.frame;
    self.certificateTypeInputLabel.top = self.nameInputLabel.bottom + 10;
    
    self.certificateNumberInputLabel.frame = self.certificateTypeInputLabel.frame;
    self.certificateNumberInputLabel.top = self.certificateTypeInputLabel.bottom + 10;
    
    self.verifacationButton.frame = self.certificateNumberInputLabel.frame;
    self.verifacationButton.top = self.certificateNumberInputLabel.bottom + 15;
    
    self.maskingView.frame = self.view.bounds;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.keyboardToolBar removeFromSuperview];
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
    return @"实名认证";
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
