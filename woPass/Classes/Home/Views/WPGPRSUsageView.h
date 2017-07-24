//
//  WPGPRSUsageView.h
//  woPass
//
//  Created by htz on 15/8/10.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "TZSudokuView.h"
@class NIAttributedLabel;

@interface WPGPRSUsageViewCellItem : TZSudokuViewCellItem

@property (nonatomic, copy)NSString *subtitle;

@end

@interface WPGPRSUsageViewCell : TZSudokuViewCell

@property (nonatomic, strong)NIAttributedLabel *subtitleLabel;

@end

@interface WPGPRSUsageView : TZSudokuView

@end


