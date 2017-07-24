//
//  WPSecurityLevelCellItem.m
//  woPass
//
//  Created by htz on 15/7/8.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPSecurityLevelCellItem.h"
#import "NIAttributedLabel.h"

@interface WPSecurityLevelCellItem ()

@end

@implementation WPSecurityLevelCellItem

- (Class)cellClass {
    
    return [WPSecurityLevelCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return 150;
}

- (NSArray *)securityLevelCellItemArray {
    
    WPSecurityLevelViewCellItem *securityLevelViewItem = [[WPSecurityLevelViewCellItem alloc] init];
    securityLevelViewItem.title = @"邮箱";
    securityLevelViewItem.action = ^() {
        
        if (ISLOGINED) {
            [BaiduMob logEvent:@"id_mail_tie" eventLabel:@"click"];
            [@"WP://bindingEmail_vc" open];
        } else {
            
            [UserAuthorManager authorizationLogin:nil andSuccess:^{
                
            } andFaile:^{
                
            }];
        }
    };
    
    switch ([gUser.emailIsavalible integerValue]) {
        case 0:
            securityLevelViewItem.imageName = @"iconfont_y_m";
            break;
            
        case 1:
            securityLevelViewItem.imageName = @"iconfont_y";
            break;
    }
    
    WPSecurityLevelViewCellItem *securityLevelViewItem1 = [[WPSecurityLevelViewCellItem alloc] init];
    
    if ([gUser.isSet integerValue]) {
        
        securityLevelViewItem1.title = @"密码强度";
        securityLevelViewItem1.action = ^ {
            
            if (ISLOGINED) {
                
                [@"WP://changPwd_vc" open];
            } else {
                
                [UserAuthorManager authorizationLogin:nil andSuccess:^{
                    
                } andFaile:^{
                    
                }];
            }
        };
    } else {
        
        securityLevelViewItem1.title = @"设置密码";
        securityLevelViewItem1.action = ^ {
            
            if (ISLOGINED) {
                
                [@"WP://setPwd_vc" open];
            } else {
                
                [UserAuthorManager authorizationLogin:nil andSuccess:^{
                    
                } andFaile:^{
                    
                }];
            }
        };
    }
    
    if ([gUser.passStrength integerValue] <= 10) {
        
        securityLevelViewItem1.imageName = @"anquan_d";
    } else if ([gUser.passStrength integerValue] <= 20) {
        
        securityLevelViewItem1.imageName = @"anquan_z";

    } else if ([gUser.passStrength integerValue] <= 30) {
        
        securityLevelViewItem1.imageName = @"anquan_g";
    }
    
    WPSecurityLevelViewCellItem *securityLevelViewItem2 = [[WPSecurityLevelViewCellItem alloc] init];
    securityLevelViewItem2.title = @"实名认证";
    securityLevelViewItem2.action = ^(){
        
        if (ISLOGINED) {
            [BaiduMob logEvent:@"id_realname" eventLabel:@"safe"];
            [@"WP://realNameAuthentication_vc" open];
        } else {
            
            [UserAuthorManager authorizationLogin:nil andSuccess:^{
                
            } andFaile:^{
                
            }];
        }
        
    };
    
    switch ([gUser.realNameIsauth integerValue]) {
        case 0:
            securityLevelViewItem2.imageName = @"iconfont_v_m";
            break;
        case 1:
            securityLevelViewItem2.imageName = @"iconfont_v";
            break;
    }
    
    return @[securityLevelViewItem, securityLevelViewItem1, securityLevelViewItem2];
}

- (NSString *)title {
    return @"安全级别";
}

- (NSString *)subTitle {
    return @"绑定邮箱、提高密码强度、进行实名认证可提高安全级别";
}

@end

@interface WPSecurityLevelCell ()

@property (nonatomic, strong)WPSecurityLevelView *securityLevelView;
@property (nonatomic, strong)NIAttributedLabel *titleLabel;
@property (nonatomic, strong)NIAttributedLabel *subTitleLabel;
@property (nonatomic, strong)UIView *topMarginView;
@property (nonatomic, strong)UIView *bottomMarginView;

@end

@implementation WPSecurityLevelCell

- (UIView *)topMarginView {
    if (!_topMarginView) {
        _topMarginView = [[UIView alloc] init];
        _topMarginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self.contentView addSubview:_topMarginView];
    }
    return _topMarginView;
}

- (UIView *)bottomMarginView {
    if (!_bottomMarginView) {
        _bottomMarginView = [[UIView alloc] init];
        _bottomMarginView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self.contentView addSubview:_bottomMarginView];
    }
    return _bottomMarginView;
}

- (WPSecurityLevelView *)securityLevelView {
    if (!_securityLevelView) {
        _securityLevelView = [[WPSecurityLevelView alloc] init];
        [self.contentView addSubview:_securityLevelView];
    }
    return _securityLevelView;
}

- (NIAttributedLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        [self addSubview:_titleLabel];
        
    }
    return _titleLabel;
}

- (NIAttributedLabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [NIAttributedLabel labelWithFontSize:kFontTiny color:RGBCOLOR_HEX(kLabelWeakColor)];
        [self addSubview:_subTitleLabel];
    }
    return _subTitleLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = RGBCOLOR_HEX(0xffffff);
        self.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel x_sizeToFit];
    [self.subTitleLabel x_sizeToFit];
    
    self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(80, 0, 0, 0));
    
    self.securityLevelView.frame = self.contentView.bounds;
    
    self.titleLabel.top = 15;
    self.titleLabel.left = 5;
    
    CGRect frame = [self.subTitleLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : XFont(kFontTiny)} context:nil];
    self.subTitleLabel.size = frame.size;
    self.subTitleLabel.numberOfLines = 20;
    self.subTitleLabel.top = self.titleLabel.bottom + 10;
    self.subTitleLabel.left = self.titleLabel.left;
    
    self.topMarginView.frame = CGRectMake(0, 0, self.contentView.width, 1);
    self.bottomMarginView.frame = CGRectMake(0, self.contentView.height, self.contentView.width, 1);
    
}

- (void)setTableViewCellItem:(WPSecurityLevelCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    self.securityLevelView.sudokuCellItemArray = tableViewCellItem.securityLevelCellItemArray;
    self.titleLabel.text = tableViewCellItem.title;
    self.subTitleLabel.text = tableViewCellItem.subTitle;
    [self setNeedsLayout];

}

@end
