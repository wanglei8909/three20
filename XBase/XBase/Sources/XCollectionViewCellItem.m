//
//  YDCollectionViewCellItem.m
//  common
//
//  Created by Yamazoa on 11/27/14.
//  Copyright (c) 2014  com.7ulipa All rights reserved.
//

#import "XCollectionViewCellItem.h"
#import "XCollectionViewCell.h"

@implementation XCollectionViewCellItem

- (Class)cellClass
{
	return [XCollectionViewCell class];
}

- (CGSize)sizeForCollectionView:(UICollectionView *)inCollectionView layout:(UICollectionViewLayout *)layout
{
    return [[self cellClass] sizeForObject:self collectionView:inCollectionView layout:layout];
}

- (id)applyAction:(TTURLAction *)action
{
	self.action = action;
	return self;
}

- (id)applyActionBlock:(void (^)(void))actionBlock
{
	self.actionBlock = actionBlock;
	return self;
}

@end
