//
//  WPCurrentDeviceCellItem.m
//  woPass
//
//  Created by htz on 15/7/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPCurrentDeviceCellItem.h"
#import "NIAttributedLabel.h"

@interface WPCurrentDeviceCellItem ()

@end

@implementation WPCurrentDeviceCellItem

- (Class)cellClass {
    
    return [WPCurrentDeviceCell class];
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    
    return self.subHeadTitle ? 130 : (self.headTitle ? 100 : 65);
}

- (TZBasicCellMarginType)marginType {
    return TZBasicCellAllMargin;
}

+ (NSDictionary *)replacedKeyFromPropertyName {
    
    return @{
             @"title" : @"model",
             @"subTitle" : @"useTime"
             };
}

- (NSString *)iconName {
    return @"iphone";
}

@end

@interface WPCurrentDeviceCell ()

@property (nonatomic, strong)NIAttributedLabel *subHeadTitleLabel;
@property (nonatomic, strong)NIAttributedLabel *subTitleLabel;
@property (nonatomic, strong)UIButton *deleteButton;

@end

@implementation WPCurrentDeviceCell

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_deleteButton];
    }
    return _deleteButton;
}


- (NIAttributedLabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [NIAttributedLabel labelWithFontSize:kFontTiny color:RGBCOLOR_HEX(kLabelWeakColor)];
        [self.contentView addSubview:_subTitleLabel];
        
    }
    return _subTitleLabel;
}
- (NIAttributedLabel *)subHeadTitleLabel {
    if (!_subHeadTitleLabel) {
        _subHeadTitleLabel = [NIAttributedLabel labelWithFontSize:kFontTiny color:RGBCOLOR_HEX(kLabelWeakColor)];
        [self addSubview:_subHeadTitleLabel];
    }
    return _subHeadTitleLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.subHeadTitleLabel.isHidden) {
        
        [self.headTitleLabel setFont:XFont(kFontMiddle) range:NSMakeRange(0, 4)];
        [self.headTitleLabel setTextColor:RGBCOLOR_HEX(kLabelDarkColor) range:NSMakeRange(0, 4)];
        [self.headTitleLabel x_sizeToFit];
        self.headTitleLabel.top = 10;
        
        self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(70, 0, 0, 0));
        
        CGRect frame = [self.subHeadTitleLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : XFont(kFontTiny)} context:nil];
        self.subHeadTitleLabel.size = frame.size;
        self.subHeadTitleLabel.numberOfLines = 20;
        self.subHeadTitleLabel.left = self.headTitleLabel.left;
        self.subHeadTitleLabel.top = self.headTitleLabel.bottom + 10;
        
    } else {
        
        self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(38, 0, 0, 0));
        
        if (!self.headTitleLabel.isHidden) {
            
            [self.headTitleLabel setFont:XFont(kFontMiddle) range:NSMakeRange(0, 4)];
            [self.headTitleLabel setTextColor:RGBCOLOR_HEX(kLabelDarkColor) range:NSMakeRange(0, 4)];
            [self.headTitleLabel x_sizeToFit];
            self.headTitleLabel.top = (38 - self.headTitleLabel.height) / 2;
            
        } else {
            
            self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(5, 0, 0, 0));
        }
    }
    
    self.iconImageView.centerX = 30;
    self.iconImageView.top = (self.contentView.height - self.iconImageView.height) / 2;
    
    self.titleLabel.top = 10;
    self.titleLabel.left = (self.iconImageView.centerX + 30);
    
    [self.subTitleLabel x_sizeToFit];
    self.subTitleLabel.left = self.titleLabel.left;
    self.subTitleLabel.top = self.titleLabel.bottom + 10;
}

- (void)setTableViewCellItem:(WPCurrentDeviceCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    self.subHeadTitleLabel.text = tableViewCellItem.subHeadTitle;
    self.titleLabel.text = [tableViewCellItem.title stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.subTitleLabel.text = [[NSString stringWithFormat:@"最后登录时间:  %@",tableViewCellItem.subTitle] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if (tableViewCellItem.subHeadTitle) {
        
        self.subHeadTitleLabel.hidden = NO;
    } else {
        
        self.subHeadTitleLabel.hidden = YES;
    }
    
    [self setNeedsLayout];

}


@end