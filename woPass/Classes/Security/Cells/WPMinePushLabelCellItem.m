//
//  WPMinePushLabelCellItem.m
//  woPass
//
//  Created by htz on 15/11/2.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPMinePushLabelCellItem.h"
#import "NIAttributedLabel.h"

@interface WPMinePushLabelCellItem ()

@end

@implementation WPMinePushLabelCellItem

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.title = @"如果你需要关闭或开启沃通行证的新消息通知，请在IPhone的“设置”-“通知”功能中，找到应用程序“沃通行证”更改";
    }
    return self;
}

- (Class)cellClass {
    return [WPMinePushLabelCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return [self.title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : XFont(kFontTiny)} context:NULL].size.height + kPadding;
}

@end

@interface WPMinePushLabelCell ()

@property (nonatomic, strong) NIAttributedLabel *titleLabel;

@end

@implementation WPMinePushLabelCell

- (NIAttributedLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [NIAttributedLabel labelWithFontSize:kFontTiny color:RGBCOLOR_HEX(kDisableTitleColor)];
        _titleLabel.numberOfLines = 10;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.bounds;
    self.titleLabel.left = 10;
    self.titleLabel.top = 10;
}

- (void)setTableViewCellItem:(WPMinePushLabelCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    self.titleLabel.text = tableViewCellItem.title;
    
}

@end
