//
//  WPNoneLoginHeaderCellItem.m
//  woPass
//
//  Created by htz on 15/7/23.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPNoneLoginHeaderCellItem.h"
#import "NIAttributedLabel.h"
#import "JMWhenTapped.h"
#import "WPURLManager.h"

@implementation WPNoneLoginHeaderCellItem

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self setup];
    }
    return self;
}

- (void)setUseLarger:(BOOL)useLarger {
    
    _useLarger = useLarger;
}

- (void)setup {
    
    self.useLarger                  = NO;
    self.locationImageName          = @"lishi";
    self.locationTitle              = @"登录历史";
    self.locationSubTitle           = @"登录即可查看登录历史";
    self.locationAccessoryImageName = @"youjiantou-";
    self.leftButtonTitle            = @"一键登录";
    self.title                      = @"一键登录沃通行证，为帐号安全保驾护航";
    self.subTitle                   = @"我已阅读并同意《授权协议》";
    self.useLarger = NO;
    self.subTitleClickAction = ^() {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"terms" ofType:@"html"];
        [WPURLManager openURLWithMainTitle:@"用户协议" urlString:path];
    };
}

- (void)setPhoneNumber:(NSString *)phoneNumber {
    
    _phoneNumber = phoneNumber;
    if (phoneNumber.length == 11) {
        
        [_phoneNumber substringWithRange:NSMakeRange(0, 3)];
        self.title = [NSString stringWithFormat:@"沃通行证提醒您使用%@****%@进行登录", [_phoneNumber substringWithRange:NSMakeRange(0, 3)], [_phoneNumber substringWithRange:NSMakeRange(7, 4)]];
        self.leftButtonTitle = @"一键登录";
        self.rightButtonTitle = @"其他帐号";
        
        self.useLarger = YES;
    }
}

- (Class)cellClass {
    return [WPNoneLoginHeaderCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return self.useLarger ? SCALED(115 + 75) : SCALED(90 + 75);
}

- (instancetype)applyLeftAction:(Action)leftButtonAction {
    
    self.leftButtonAction = leftButtonAction;
    return self;
}

- (instancetype)applyRightButtonAction:(Action)rightButtonAction {
    
    self.rightButtonAction = rightButtonAction;
    return self;
}

- (instancetype)applyLowerAction:(Action)lowerAction {
    
    self.lowerAction = lowerAction;
    return self;
}

@end

@interface WPNoneLoginHeaderCell ()

@property (nonatomic, strong)UIImageView *upperBKView;
@property (nonatomic, strong)NIAttributedLabel *titleLabel;
@property (nonatomic, strong)NIAttributedLabel *subTitleLabel;
@property (nonatomic, strong)UIButton *leftButton;
@property (nonatomic, strong)UIButton *rightButton;
@property (nonatomic, strong)UIView *agreeIconView;


@property (nonatomic, strong)UIView *lowerBKView;
@property (nonatomic, strong)UIImageView *locationImageView;
@property (nonatomic, strong)NIAttributedLabel *locationTitleLabel;
@property (nonatomic, strong)NIAttributedLabel *locationSubTitleLabel;

@property (nonatomic, strong)UIImageView *locationAccessoryImageView;

@end

@implementation WPNoneLoginHeaderCell

#pragma mark - Constructors and Life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    WPNoneLoginHeaderCellItem *cellItem = (WPNoneLoginHeaderCellItem *)self.tableViewCellItem;
    if (cellItem.useLarger) {
        
        [self largeLayout];
    } else {
        
        [self shortLayout];
    }
}

#pragma mark - Private Method







- (void)largeLayout {
    
    self.upperBKView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCALED(115));
    
    [self.titleLabel x_sizeToFit];
    self.titleLabel.centerX = self.upperBKView.width / 2;
    self.titleLabel.centerY = self.upperBKView.height * 0.243;
    
    [self.subTitleLabel x_sizeToFit];
    self.subTitleLabel.centerX = self.upperBKView.width / 2;
    self.subTitleLabel.centerY = self.upperBKView.height * 0.419;
    
    self.agreeIconView.centerY = self.subTitleLabel.centerY;
    self.agreeIconView.right = self.subTitleLabel.left - 2;
    
    self.leftButton.size = CGSizeMake(SCALED(100), SCALED(28));
    self.leftButton.centerX = self.upperBKView.width / 2;
    self.leftButton.layer.cornerRadius = self.leftButton.height / 2;
    self.leftButton.centerY = self.upperBKView.height * 0.726;
    self.leftButton.right = self.upperBKView.width / 2 - 5;
    
    self.rightButton.size = CGSizeMake(SCALED(100), SCALED(28));
    self.rightButton.centerX = self.upperBKView.width / 2;
    self.rightButton.layer.cornerRadius = self.leftButton.height / 2;
    self.rightButton.centerY = self.upperBKView.height * 0.726;
    self.rightButton.left = self.upperBKView.width / 2 + 5;
    
    self.lowerBKView.frame = CGRectMake(0, self.upperBKView.bottom, self.contentView.width, self.contentView.height - self.upperBKView.height);
    
    self.locationImageView.size = CGSizeMake(SCALED(35), SCALED(35));
    self.locationImageView.left = SCALED(kPadding);
    self.locationImageView.centerY = self.lowerBKView.height / 2;
    
    [self.locationTitleLabel x_sizeToFit];
    self.locationTitleLabel.left = self.locationImageView.right + SCALED(kPadding);
    self.locationTitleLabel.bottom = self.locationImageView.centerY - 3;
    
    [self.locationSubTitleLabel x_sizeToFit];
    self.locationSubTitleLabel.left = self.locationTitleLabel.left;
    self.locationSubTitleLabel.top = self.locationImageView.centerY + 6;
    
    self.locationAccessoryImageView.size = CGSizeMake(SCALED(10), SCALED(20));
    self.locationAccessoryImageView.centerY = self.lowerBKView.height / 2;
    self.locationAccessoryImageView.right = self.lowerBKView.width - 15;
}

- (void)shortLayout {
    
    self.upperBKView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCALED(90));
    
    self.leftButton.size = CGSizeMake(SCALED(100), SCALED(28));
    self.leftButton.centerX = self.upperBKView.width / 2;
    self.leftButton.layer.cornerRadius = self.leftButton.height / 2;
    
    [self.titleLabel x_sizeToFit];
    self.titleLabel.centerX = self.upperBKView.width / 2;
    
    self.leftButton.top = (self.upperBKView.height - self.leftButton.height - self.titleLabel.height - 7) / 2;
    self.titleLabel.centerY = self.upperBKView.height * 2.3 / 3;
    
    
    self.lowerBKView.frame = CGRectMake(0, self.upperBKView.bottom, self.contentView.width, self.contentView.height - self.upperBKView.height);
    
    self.locationImageView.size = CGSizeMake(SCALED(35), SCALED(35));
    self.locationImageView.left = SCALED(kPadding);
    self.locationImageView.centerY = self.lowerBKView.height / 2;
    
    [self.locationTitleLabel x_sizeToFit];
    self.locationTitleLabel.left = self.locationImageView.right + SCALED(kPadding);
    self.locationTitleLabel.bottom = self.locationImageView.centerY - 3;
    
    [self.locationSubTitleLabel x_sizeToFit];
    self.locationSubTitleLabel.left = self.locationTitleLabel.left;
    self.locationSubTitleLabel.top = self.locationImageView.centerY + 6;
    
    self.locationAccessoryImageView.size = CGSizeMake(SCALED(10), SCALED(20));
    self.locationAccessoryImageView.centerY = self.lowerBKView.height / 2;
    self.locationAccessoryImageView.right = self.lowerBKView.width - 15;
}

- (void)setLargeStyleWithButton:(UIButton *)button {
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    button.layer.borderWidth = 3;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.userInteractionEnabled = YES;
}

- (void)setLargeDisableStyleWithButton:(UIButton *)button {
    
    [button setTitleColor:RGBCOLOR_HEX(0xfccba3) forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    button.layer.borderWidth = 3;
    button.layer.borderColor = RGBCOLOR_HEX(0xfccba3).CGColor;
    button.userInteractionEnabled = NO;
}

- (void)setNormalStyleWithButton:(UIButton *)button {
    [button setTitleColor:RGBCOLOR_HEX(KTextOrangeColor) forState:UIControlStateNormal];
    button.titleLabel.font = XFont(kFontMiddle);
    button.backgroundColor = [UIColor whiteColor];
    button.userInteractionEnabled = YES;
}



#pragma mark - Event Reponse







#pragma mark - Delegate









#pragma mark - Getter and Setter

- (UIView *)agreeIconView {
    
    if (!_agreeIconView) {
        _agreeIconView = [[UIView alloc] init];
        _agreeIconView.size = CGSizeMake(25, 25);
        WPAgreeIconView *temp = [[WPAgreeIconView alloc] init];
        temp.centerX = _agreeIconView.width / 2;
        temp.centerY = _agreeIconView.height / 2;
        [_agreeIconView addSubview:temp];
        
        weaklySelf();
        [_agreeIconView whenTapped:^{
            
            [temp revert];
            if (temp.isOn) {
                [weakSelf setLargeStyleWithButton:weakSelf.leftButton];
            } else {
                [weakSelf setLargeDisableStyleWithButton:weakSelf.leftButton];
            }
        }];
        [self.upperBKView addSubview:_agreeIconView];
    }
    return _agreeIconView;
}

- (UIView *)lowerBKView {
    if (!_lowerBKView) {
        _lowerBKView = [[UIView alloc] init];
        _lowerBKView.backgroundColor = [UIColor whiteColor];
        _lowerBKView.layer.borderWidth = 1;
        _lowerBKView.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        [self.contentView addSubview:_lowerBKView];
    }
    return _lowerBKView;
}

- (UIImageView *)locationImageView {
    if (!_locationImageView) {
        _locationImageView = [[UIImageView alloc] init];
        [self.lowerBKView addSubview:_locationImageView];
    }
    return _locationImageView;
}

- (NIAttributedLabel *)locationTitleLabel {
    if (!_locationTitleLabel) {
        _locationTitleLabel = [NIAttributedLabel labelWithFontSize:kFontLarge color:RGBCOLOR_HEX(kLabelDarkColor)];
        [self.lowerBKView addSubview:_locationTitleLabel];
    }
    return _locationTitleLabel;
}

- (NIAttributedLabel *)locationSubTitleLabel {
    if (!_locationSubTitleLabel) {
        _locationSubTitleLabel = [NIAttributedLabel labelWithFontSize:kFontTiny color:RGBCOLOR_HEX(kDisableTitleColor)];
        [self.lowerBKView addSubview:_locationSubTitleLabel];
    }
    return _locationSubTitleLabel;
}

- (UIImageView *)locationAccessoryImageView {
    if (!_locationAccessoryImageView) {
        _locationAccessoryImageView = [[UIImageView alloc] init];
        [self.lowerBKView addSubview:_locationAccessoryImageView];
    }
    return _locationAccessoryImageView;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setNormalStyleWithButton:_leftButton];
        [self.upperBKView addSubview:_leftButton];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setNormalStyleWithButton:_rightButton];
        [self.upperBKView addSubview:_rightButton];
    }
    return _rightButton;
}

- (NIAttributedLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:[UIColor whiteColor]];
        [self.upperBKView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (NIAttributedLabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:[UIColor whiteColor]];
        [self.upperBKView addSubview:_subTitleLabel];
    }
    return _subTitleLabel;
}

- (UIImageView *)upperBKView {
    if (!_upperBKView) {
        _upperBKView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bd-6"]];
        _upperBKView.userInteractionEnabled = YES;
        [self.contentView addSubview:_upperBKView];
    }
    return _upperBKView;
}





#pragma mark - Public

- (void)setTableViewCellItem:(WPNoneLoginHeaderCellItem *)tableViewCellItem {
    
    [super setTableViewCellItem:tableViewCellItem];
    
    if (tableViewCellItem.useLarger) {
        
        self.agreeIconView.hidden = NO;
        self.subTitleLabel.hidden = NO;
        self.rightButton.hidden = NO;
        [self setLargeStyleWithButton:self.leftButton];
        [self setLargeStyleWithButton:self.rightButton];
    } else {
        
        self.agreeIconView.hidden = YES;
        self.subTitleLabel.hidden = YES;
        self.rightButton.hidden = YES;
        [self setNormalStyleWithButton:self.leftButton];
        [self setNormalStyleWithButton:self.rightButton];
    }
    
    [self.leftButton setTitle:tableViewCellItem.leftButtonTitle forState:UIControlStateNormal];
    [self.rightButton setTitle:tableViewCellItem.rightButtonTitle forState:UIControlStateNormal];
    self.titleLabel.text = tableViewCellItem.title;
    self.subTitleLabel.text = tableViewCellItem.subTitle;
    
    self.locationImageView.image = [UIImage imageNamed:tableViewCellItem.locationImageName];
    self.locationTitleLabel.text = tableViewCellItem.locationTitle;
    self.locationSubTitleLabel.text = tableViewCellItem.locationSubTitle;
    self.locationAccessoryImageView.image = [UIImage imageNamed:tableViewCellItem.locationAccessoryImageName];
    
    [self.leftButton whenTapped:^{
        
        CallBlock(tableViewCellItem.leftButtonAction);
    }];
    
    [self.rightButton whenTapped:^{
        
        CallBlock(tableViewCellItem.rightButtonAction);
    }];
    
    [self.lowerBKView whenTapped:^{
        
        CallBlock(tableViewCellItem.lowerAction);
    }];
    
    [self.subTitleLabel whenTapped:^{
       
        CallBlock(tableViewCellItem.subTitleClickAction);
    }];
    
    [self setNeedsLayout];
}


@end

@interface WPAgreeIconView ()

@property (nonatomic, weak)UIView *centerView;

@end

@implementation WPAgreeIconView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, 12, 12);
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1.5;
        self.layer.cornerRadius = self.width / 2;
        
        UIView *centerView = [[UIView alloc] init];
        centerView.size = CGSizeMake(4, 4);
        centerView.backgroundColor = [UIColor whiteColor];
        centerView.layer.cornerRadius = centerView.width / 2;
        centerView.center = CGPointMake(self.width / 2, self.height / 2);
        [self addSubview:centerView];
        self.centerView = centerView;
    }
    return self;
}

- (void)revert {
    
    self.centerView.hidden = !self.centerView.hidden;
}

- (BOOL)isOn {
    
    return !self.centerView.hidden;
}

@end


