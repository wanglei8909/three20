//
//  YDCollectionViewCell.m
//  common
//
//  Created by Yamazoa on 11/27/14.
//  Copyright (c) 2014  com.7ulipa All rights reserved.
//

#import "XCollectionViewCell.h"
#import "XCollectionViewCellItem.h"

@implementation UICollectionViewCell (reuse)

+ (id)dequeueCellForCollectionView:(UICollectionView *)inCollectionView forIndexPath:(NSIndexPath *) inIndexPath
{
	XCollectionViewCell* cell = [inCollectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:inIndexPath];
	if (! cell) {
		cell = [[[self class] alloc] initWithFrame:CGRectZero];
	}
	return cell;
}

+ (CGSize)sizeForObject:(XCollectionViewCellItem *)inItem collectionView:(UICollectionView *)inCollectionView layout:(UICollectionViewLayout *)layout
{
	return CGSizeMake(70, 110);
}

@end

@implementation XCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		[self setCellBackgroundColor:[UIColor clearColor]];
	}
	return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
	[super setBackgroundColor:self.cellBackgroundColor];
}

- (void)setCellBackgroundColor:(UIColor *)cellBackgroundColor
{
	[super setBackgroundColor:cellBackgroundColor];
}

- (UIColor *)cellBackgroundColor
{
	return self.backgroundColor;
}

@end
