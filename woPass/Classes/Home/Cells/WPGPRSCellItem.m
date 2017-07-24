//
//  WPGPRSCellItem.m
//  woPass
//
//  Created by htz on 15/8/10.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPGPRSCellItem.h"
#import "NIAttributedLabel.h"
#import "WPGPRSFunctionView.h"
#import "WPURLManager.h"

@interface WPGPRSCellItem ()

@end

@implementation WPGPRSCellItem

- (Class)cellClass {
    return [WPGPRSCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    
    return SCALED(400);
}

- (NSArray *)functionCellItemArray {
    
    WPGPRSFunctionViewCellItem *item0 = [[WPGPRSFunctionViewCellItem alloc] init];
    item0.imageName = @"web";
    item0.title = @"看网站";
    item0.subTitle = [NSString stringWithFormat:@"≈%.2f小时", [self.unusedValue floatValue] / 2];
    item0.labelColor = RGBCOLOR_HEX(0x66ce3e);
    
    WPGPRSFunctionViewCellItem *item1 = [[WPGPRSFunctionViewCellItem alloc] init];
    item1.imageName = @"message";
    item1.title = @"聊天";
    item1.subTitle = [NSString stringWithFormat:@"≈%.2f小时", [self.unusedValue floatValue] / 1];
    item1.labelColor = RGBCOLOR_HEX(0x46a0dc);

    
    WPGPRSFunctionViewCellItem *item2 = [[WPGPRSFunctionViewCellItem alloc] init];
    item2.imageName = @"music";
    item2.title = @"听音乐";
    item2.subTitle = [NSString stringWithFormat:@"≈%.2f小时", [self.unusedValue floatValue] / 30];
    item2.labelColor = RGBCOLOR_HEX(0xff615b);

    
    WPGPRSFunctionViewCellItem *item3 = [[WPGPRSFunctionViewCellItem alloc] init];
    item3.imageName = @"tv";
    item3.title = @"看视频";
    item3.subTitle = [NSString stringWithFormat:@"≈%.2f小时", [self.unusedValue floatValue] / 120];
    item3.labelColor = RGBCOLOR_HEX(0xf19506);

    return @[item0, item1, item2, item3];
}

- (NSInteger)numCol {
    
    return 2;
}

@end

@interface WPGPRSCell ()

@property (nonatomic, strong)NIAttributedLabel *titleLabel;
@property (nonatomic, strong)WPGPRSFunctionView *functionView;
@property (nonatomic, strong)UIButton *buyButton;

@end

@implementation WPGPRSCell

- (WPGPRSFunctionView *)functionView {
    if (!_functionView) {
        _functionView = [[WPGPRSFunctionView alloc] init];
        [self.contentView addSubview:_functionView];
    }
    return _functionView;
}

- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyButton setTitle:@"充流量" forState:UIControlStateNormal];
        [_buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyButton setBackgroundColor:RGBCOLOR_HEX(0x46be1f)];
        [_buyButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_buyButton];
    }
    return _buyButton;
}

- (NIAttributedLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:@"本月还剩MB" attributes:@{NSFontAttributeName : XFont(kFontLarge), NSForegroundColorAttributeName : RGBCOLOR_HEX(kLabelDarkColor)}];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel x_sizeToFit];
    self.titleLabel.left = SCALED(20);
    self.titleLabel.top = SCALED(20);
    
    [self.buyButton x_sizeToFit];
    self.buyButton.height *= 0.9;
    self.buyButton.width *= 1.3;
    self.buyButton.layer.cornerRadius = self.buyButton.height / 2;
    self.buyButton.layer.masksToBounds = YES;
    self.buyButton.centerY = self.titleLabel.centerY;
    self.buyButton.right = self.contentView.width - SCALED(kPadding);
    
    self.functionView.size = CGSizeMake(SCREEN_WIDTH - SCALED(28), SCALED(150));
    self.functionView.top = self.titleLabel.bottom + SCALED(20);
    self.functionView.left = SCALED(15);
}

- (void)setTableViewCellItem:(WPGPRSCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"本月还剩%@MB", tableViewCellItem.unusedValue ? tableViewCellItem.unusedValue : @""] attributes:@{NSFontAttributeName : XFont(kFontLarge), NSForegroundColorAttributeName : RGBCOLOR_HEX(kLabelDarkColor)}];
    [titleString addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_HEX(KLabelGreenColor) range:NSMakeRange(4, titleString.length - 6)];
    self.titleLabel.attributedText = titleString;

    self.functionView.sudokuCellItemArray = tableViewCellItem.functionCellItemArray;
    self.functionView.numCol = tableViewCellItem.numCol;
    
    [self setNeedsLayout];
}

- (void)buttonClick:(UIButton *)button {

    [WPURLManager openURLWithMainTitle:@"流量办理" urlString:@"http://www.unclicks.com/traffic/union?channelCode=sk12"];
}

@end