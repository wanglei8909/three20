//
//  YDCollectionView.m
//  common
//
//  Created by Yamazoa on 11/27/14.
//  Copyright (c) 2014  com.7ulipa All rights reserved.
//

#import "XCollectionView.h"

@implementation XCollectionView
{
	BOOL firstFlag;
}

- (void)reloadData
{
	[super reloadData];
}

- (void)showEmptyView
{
	if (! self.emptyView)
	{
		self.emptyView = self.emptyViewBlock(self);
	}
	
	[self addSubview:self.emptyView];
	[self.emptyView setHidden:NO];
	[self.emptyView setFrame:self.bounds];
}

- (void)hideEmptyView
{
	[self.emptyView setHidden:YES];
}

@end
