//
//  YDCollectionView.h
//  common
//
//  Created by Yamazoa on 11/27/14.
//  Copyright (c) 2014  com.7ulipa All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCollectionView : UICollectionView

- (void)showEmptyView;

- (void)hideEmptyView;

@property (nonatomic, copy) UIView*(^ emptyViewBlock)(XCollectionView* inCollectionView);

@property (nonatomic, copy) BOOL(^isLoading)(XCollectionView* inCollectionView);

@property (nonatomic, strong) UIView* emptyView;

@end
