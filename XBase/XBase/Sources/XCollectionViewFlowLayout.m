//
//  YDCollectionViewFlowLayout.m
//  common
//
//  Created by Yamazoa on 11/25/14.
//  Copyright (c) 2014  com.7ulipa All rights reserved.
//

#import "XCollectionViewFlowLayout.h"

@implementation XCollectionViewFlowLayout

-(id)init
{
	self = [super init];
	if (self) {
		self.itemSize = CGSizeMake(70, 110);
		self.scrollDirection = UICollectionViewScrollDirectionVertical;
		self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
		self.minimumInteritemSpacing = 25;
	}
	
	return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
	return YES;
}


@end
