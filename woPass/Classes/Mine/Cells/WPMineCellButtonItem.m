//
//  WPMineCellButtonItem.m
//  woPass
//
//  Created by 王蕾 on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMineCellButtonItem.h"
#import "NIAttributedLabel.h"

@implementation WPMineCellButtonItem

- (Class)cellClass {
    return [WPMineCellButton class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return 45;
}

@end

@implementation WPMineCellButton


- (NIAttributedLabel *)btnTitleLabel {
    if (!_btnTitleLabel) {
        _btnTitleLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        _btnTitleLabel.verticalTextAlignment = NIVerticalTextAlignmentMiddle;
        [self.contentView addSubview:_btnTitleLabel];
    }
    return _btnTitleLabel;
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
    self.btnTitleLabel.font = [UIFont systemFontOfSize:16];
    [self.btnTitleLabel x_sizeToFit];
    self.btnTitleLabel.center = self.contentView.center;
    self.btnTitleLabel.textColor = RGBCOLOR_HEX(KTextOrangeColor);
    
    UIView *lingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lingView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
    [self.contentView addSubview:lingView];
    
    lingView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
    lingView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
    [self.contentView addSubview:lingView];
    
}

- (void)setTableViewCellItem:(WPMineCellButtonItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    
    self.btnTitleLabel.text = tableViewCellItem.btnTitle;
    
    [self setNeedsLayout];
}



@end






