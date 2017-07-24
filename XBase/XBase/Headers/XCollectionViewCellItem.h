//
//  YDCollectionViewCellItem.h
//  common
//
//  Created by Yamazoa on 11/27/14.
//  Copyright (c) 2014  com.7ulipa All rights reserved.
//

#import "XObject.h"

@class XCollectionViewCell;

@interface XCollectionViewCellItem : XObject

@property (nonatomic, weak) XCollectionViewCell *collectionCell;

@property (nonatomic, strong) TTURLAction* action;

@property (nonatomic, strong) void(^actionBlock)(void);

- (Class)cellClass;

- (CGSize)sizeForCollectionView:(UICollectionView *) inCollectionView layout:(UICollectionViewLayout *)layout;

- (id)applyAction:(TTURLAction *)action;
- (id)applyActionBlock:(void(^)(void))actionBlock;

@end
