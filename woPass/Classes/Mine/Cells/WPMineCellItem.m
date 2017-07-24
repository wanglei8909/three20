//
//  WPMineCellItem.m
//  woPass
//
//  Created by 王蕾 on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMineCellItem.h"
#import "NIAttributedLabel.h"
#import "SDImageCache.h"

@implementation WPMineCellItem

- (Class)cellClass {
    return [WPMineCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return 45;
}

@end


@implementation WPMineCell

- (NIAttributedLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [NIAttributedLabel labelWithFontSize:16 color:RGBCOLOR_HEX(kLabelDarkColor)];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}
- (UIImageView *)accessoryImageView {
    if (!_accessoryImageView) {
        _accessoryImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_accessoryImageView];
    }
    return _accessoryImageView;
}
- (UILabel *)cacheLabel{
    if (!_cacheLabel) {
        _cacheLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-120, 0, 110, 45)];
        _cacheLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        _cacheLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_cacheLabel];
    }
    return _cacheLabel;
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

    
    self.iconImageView.bounds = CGRectMake(0, 0, 20, 20);
    self.iconImageView.left = 10;
    self.iconImageView.top = (self.contentView.height - self.iconImageView.height) / 2;
    
    [self.titleLabel x_sizeToFit];
    self.titleLabel.center = self.iconImageView.center;
    self.titleLabel.left = self.iconImageView.right + 10;
    
    [self.accessoryImageView x_sizeToFit];
    self.accessoryImageView.center = self.iconImageView.center;
    self.accessoryImageView.right = self.width - 10;
    
    NSIndexPath *path =[self.tableView indexPathForCell:self];
    NSLog(@"---->%ld",path.section);
    if (path.section == 0) {
        UIView *lingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lingView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self.contentView addSubview:lingView];
        
        lingView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
        lingView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self.contentView addSubview:lingView];
    }else if (path.section == 1){
        if (path.row == 0) {
            UIView *lingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            lingView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
            [self.contentView addSubview:lingView];
        }else if (path.row == 1) {
            UIView *lingView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 1)];
            lingView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
            [self.contentView addSubview:lingView];
        }else if (path.row == 2) {
            UIView *lingView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 1)];
            lingView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
            [self.contentView addSubview:lingView];
            
            lingView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
            lingView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
            [self.contentView addSubview:lingView];
        }
        
    }else{
        if (path.row == 0) {
            UIView *lingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            lingView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
            [self.contentView addSubview:lingView];
        }else if (path.row == 1) {
            UIView *lingView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 1)];
            lingView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
            [self.contentView addSubview:lingView];
        }
        else if(path.row == 2){
            //558868
            float cache = [[SDImageCache sharedImageCache] getSize];
            if (cache > 1024 *1024) {
                cache = cache / 1024/1024;
                self.cacheLabel.text = [NSString stringWithFormat:@"当前有%.2fM缓存",cache];
            }
            else if (cache <= 1024 *1024) {
                cache = cache / 1024;
                self.cacheLabel.text = [NSString stringWithFormat:@"当前有%.2fK缓存",cache];
            }
            
            UIView *lingView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 1)];
            lingView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
            [self.contentView addSubview:lingView];
            
            lingView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
            lingView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
            [self.contentView addSubview:lingView];
        }
    }
}

- (void)setTableViewCellItem:(WPMineCellItem *)tableViewCellItem {
    [super setTableViewCellItem:tableViewCellItem];
    
    self.titleLabel.text = tableViewCellItem.title;
    self.iconImageView.image = [UIImage imageNamed:tableViewCellItem.iconName];
    self.accessoryImageView.image = [UIImage imageNamed:tableViewCellItem.accessoryName];
    
    
    if (tableViewCellItem.accessoryName) {
        self.accessoryImageView.hidden = NO;
    } else {
        self.accessoryImageView.hidden = YES;
    }
    
    [self setNeedsLayout];
}


@end