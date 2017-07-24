//
//  YDCollectionViewDelegate.h
//  common
//
//  Created by Yamazoa on 11/27/14.
//  Copyright (c) 2014  com.7ulipa All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCollectionViewCellItem;
@class XCollectionViewCell;

@protocol XCollectionViewDelegate <NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

- (id)objectForCollectionView:(UICollectionView*)inTableView atIndex:(NSIndexPath*)indexPath;

- (void)didSelectObject:(XCollectionViewCellItem*)inObject forCollectionView:(UICollectionView*)inCollection atIndex:(NSIndexPath*)indexPath;

- (void)handleActionForCell:(XCollectionViewCell*)cell object:(XCollectionViewCellItem*)item info:(id)info;

- (id)objectForCollectionViewSectionHeader:(UICollectionView *)inCollectionView atSection:(NSUInteger)section;


@end