//
//  TZSudokuView.m
//  woPass
//
//  Created by htz on 15/7/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "TZSudokuView.h"
#import "NIAttributedLabel.h"
#import "UIView+WhenTappedBlocks.h"
#import "UIImageView+WebCache.h"

@implementation TZSudokuViewCellItem

+ (instancetype)cellItemWithTitle:(NSString *)title andImageName:(NSString *)imageName {
    
    @throw NSGenericException;
    id cellItem = [[self alloc] init];
    [cellItem setTitle:title];
    [cellItem setImageURL:imageName];
    return cellItem;
}

@end

@implementation TZSudokuViewCell

- (NIAttributedLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [NIAttributedLabel labelWithFontSize:kFontMiddle color:RGBCOLOR_HEX(kLabelDarkColor)];
        [self addSubview:_titleLabel];
        
    }
    return _titleLabel;
}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self.iconImageView x_sizeToFit];
    [self.titleLabel x_sizeToFit];
    self.titleLabel.top = self.iconImageView.bottom;
}

- (void)setItem:(TZSudokuViewCellItem *)item {
    _item = item;
    UIImage *placeholderImage = [UIImage imageNamed:@"iconfont-morentu"];
    UIImage *image = [UIImage imageNamed:item.imageName];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.imageURL] placeholderImage:image ? image : placeholderImage];
    self.titleLabel.text = item.title;
    [self whenTapped:item.action];
}


@end

@implementation TZSudokuView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    weaklySelf();
    __block NSInteger index = 0;
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subViews, NSUInteger idx, BOOL *stop) {
        
        if ([subViews isKindOfClass:[TZSudokuViewCell class]]) {
            
            if (weakSelf.numCol) {

                NSInteger numRow = ((weakSelf.sudokuCellItemArray.count - 1) / weakSelf.numCol + 1);

                subViews.width = (weakSelf.width - (weakSelf.horizontalPadding * (weakSelf.numCol - 1))) / weakSelf.numCol;
                subViews.height = (weakSelf.height - weakSelf.veritcalPadding * (numRow - 1)) / numRow;
                subViews.left = (index % weakSelf.numCol) * (subViews.width + weakSelf.horizontalPadding);
                subViews.top = (index / weakSelf.numCol) * (subViews.height + weakSelf.veritcalPadding);
                index ++;
            } else {
                
                subViews.width = weakSelf.width / weakSelf.sudokuCellItemArray.count;
                subViews.height = weakSelf.height;
                subViews.left = index * (weakSelf.width / weakSelf.sudokuCellItemArray.count);
                index ++;
            }
        }
    }];
}

- (void)setSudokuCellItemArray:(NSArray *)sudokuViewCellItemArray {
    
    _sudokuCellItemArray = sudokuViewCellItemArray;
    
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        
        if ([subView isKindOfClass:[TZSudokuViewCell class]]) {
            
            [subView removeFromSuperview];
        }
    }];
    
    for (NSInteger i = 0; i < sudokuViewCellItemArray.count; i ++) {
        
        TZSudokuViewCell *cell = [[[self viewCellClass] alloc] init];
        [self addSubview:cell];
    }
    
    __block NSInteger index = 0;
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subViews, NSUInteger idx, BOOL *stop) {
        

        if ([subViews isKindOfClass:[TZSudokuViewCell class]]) {
            TZSudokuViewCellItem *item = sudokuViewCellItemArray[index];
            ((TZSudokuViewCell *)subViews).item = item;
            index ++;
        }
    }];
    
}

- (Class)viewCellClass {
    
    return [TZSudokuViewCell class];
}

//- (CGSize)sizeThatFits:(CGSize)size {
//    
//     frame = [super sizeThatFits:size];
//
//}

@end
