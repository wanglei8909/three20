//
//  WPAdsView.h
//  woPass
//
//  Created by htz on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "TZSudokuView.h"

typedef NS_ENUM(NSUInteger, WPAdsLayoutOption) {
    WPAdsLayoutDouble,
    WPAdsLayoutSingle,
};

@interface WPAdsViewCellItem : TZSudokuViewCellItem

@property (nonatomic, copy)NSString *actionURL;


@end

@interface WPAdsViewCell : TZSudokuViewCell

@property (nonatomic, assign)WPAdsLayoutOption layoutType;


@end

@interface WPAdsView : TZSudokuView

@property (nonatomic, assign)WPAdsLayoutOption layoutType;


@end
