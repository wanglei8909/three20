//
//  WPGPRSFunctionView.h
//  woPass
//
//  Created by htz on 15/9/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "TZSudokuView.h"

@interface WPGPRSFunctionViewCellItem : TZSudokuViewCellItem

@property (nonatomic, copy)NSString *subTitle;
@property (nonatomic, strong)UIColor *labelColor;


@end

@interface WPGPRSFunctionViewCell : TZSudokuViewCell

@property (nonatomic, strong)NIAttributedLabel *subTitleLabel;

@end

@interface WPGPRSFunctionView : TZSudokuView

@end
