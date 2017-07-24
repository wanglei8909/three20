//
//  YDCollectionViewController.m
//  common
//
//  Created by Yamazoa on 11/27/14.
//  Copyright (c) 2014  com.7ulipa All rights reserved.
//

#import "XCollectionViewController.h"
#import "XCollectionViewCell.h"
#import "XCollectionViewCellItem.h"
#import "XCollectionEmptyView.h"
#import "XCollectionViewFlowLayout.h"
#import "XCollectionViewCell.h"

@interface XCollectionViewController ()


@end

@implementation XCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.collectionView = [[[self collectionViewClass] alloc] initWithFrame:self.view.bounds collectionViewLayout:[self collectionViewLayout]];

	self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
	[self.collectionView setDelegate:self];
	[self.collectionView setDataSource:self];
    
	if ([self.collectionView isKindOfClass:[XCollectionView class]])
	{
		self.collectionView.emptyView = self.emptyView;
	}
	
	if (YDAvalibleOS(7))
	{
		self.automaticallyAdjustsScrollViewInsets = NO;
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	[self.view addSubview:self.collectionView];
}

- (Class)collectionViewClass
{
	return [XCollectionView class];
}

- (UICollectionViewLayout *)collectionViewLayout
{
	XCollectionViewFlowLayout* flowLayout = [[XCollectionViewFlowLayout alloc] init];
	return  flowLayout;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	XCollectionViewCellItem* item = [self objectForCollectionView:collectionView atIndex:indexPath];
	XCollectionViewCell* cell = [[item cellClass] dequeueCellForCollectionView:collectionView forIndexPath:indexPath];
	cell.collectionView = collectionView;
	item.collectionCell = cell;
	[cell setDelegate:self];
	[cell setCollectionViewCellItem:item];
	return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	XCollectionViewCellItem* item = [self objectForCollectionView:collectionView atIndex:indexPath];
	return [item sizeForCollectionView:collectionView layout:collectionViewLayout];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSAssert([NSThread isMainThread], @"非主线程");
	
	XCollectionViewCellItem *obj = [self objectForCollectionView:collectionView atIndex:indexPath];
	
	[self didSelectObject:obj forCollectionView:collectionView atIndex:indexPath];
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (id)objectForCollectionView:(UICollectionView*)inTableView atIndex:(NSIndexPath*)indexPath
{
	return nil;
}

- (void)didSelectObject:(XCollectionViewCellItem *)inObject forCollectionView:(UICollectionView*)inCollection atIndex:(NSIndexPath*)indexPath
{
	if (inObject.action)
	{
		dispatch_async(dispatch_get_main_queue(), ^{
			[[XNavigator navigator] openURLAction:inObject.action];
		});
	}
	else if (inObject.actionBlock)
	{
		dispatch_async(dispatch_get_main_queue(), inObject.actionBlock);
	}

}

- (void)handleActionForCell:(XCollectionViewCell*)cell object:(XCollectionViewCellItem*)item info:(id)info
{
	
}

- (id)objectForCollectionViewSectionHeader:(UICollectionView *)inCollectionView atSection:(NSUInteger)section
{
	return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return [[self objectForCollectionViewSectionHeader:self.collectionView atSection:section] sizeForCollectionView:collectionView layout:self.collectionView.collectionViewLayout];
}


- (UIView*)emptyView
{
	XCollectionEmptyView* emptyView = [[XCollectionEmptyView alloc] init];
	[emptyView setMsg:@"暂无数据"];
	return emptyView;
}


@end
