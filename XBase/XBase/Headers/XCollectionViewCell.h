//
//  YDCollectionViewCell.h
//  common
//
//  Created by Yamazoa on 11/27/14.
//  Copyright (c) 2014  com.7ulipa All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XCollectionViewDelegate.h"

@class XCollectionViewCellItem;

@interface UICollectionViewCell (reuse)

+ (id)dequeueCellForCollectionView:(UICollectionView*)inCollectionView forIndexPath:(NSIndexPath*)inIndexPath;

+ (CGSize)sizeForObject:(XCollectionViewCellItem*)inItem collectionView:(UICollectionView*)inCollectionView layout:(UICollectionViewLayout *)layout;
    
@end

@interface XCollectionViewCell : UICollectionViewCell
{
	XCollectionViewCellItem* _cellItem;
}

@property (nonatomic, strong) XCollectionViewCellItem* collectionViewCellItem;

@property (nonatomic, weak) id<XCollectionViewDelegate> delegate;

@property (nonatomic, weak) UIColor* cellBackgroundColor;

@property (nonatomic, weak) UICollectionView* collectionView;

@end
