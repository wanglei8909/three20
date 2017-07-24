//
//  TZSudokuView.h
//  woPass
//
//  Created by htz on 15/7/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJExtension.h"

@class NIAttributedLabel;

typedef void(^Action)(void);

@interface TZSudokuViewCellItem : NSObject

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *imageURL;
@property (nonatomic, copy)Action action;
@property (nonatomic, copy)NSString *imageName;


+ (instancetype)cellItemWithTitle:(NSString *)title andImageName:(NSString *)imageName;

@end

@interface TZSudokuViewCell : UIView

@property (nonatomic, strong)UIImageView *iconImageView;
@property (nonatomic, strong)NIAttributedLabel *titleLabel;
@property (nonatomic, strong)TZSudokuViewCellItem *item;


@end

@interface TZSudokuView : UIView

@property (nonatomic, strong)NSArray *sudokuCellItemArray;
@property (nonatomic, assign)NSInteger numCol;
@property (nonatomic, assign)CGFloat veritcalPadding;
@property (nonatomic, assign)CGFloat horizontalPadding;




- (Class)viewCellClass;

@end
