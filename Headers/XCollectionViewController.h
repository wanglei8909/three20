//
//  YDCollectionViewController.h
//  common
//
//  Created by Yamazoa on 11/27/14.
//  Copyright (c) 2014  com.7ulipa All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCollectionViewDelegate.h"
#import "XViewController.h"
#import "XCollectionView.h"
#import "XCollectionViewFlowLayout.h"

@interface XCollectionViewController : XViewController <XCollectionViewDelegate>

@property (nonatomic, strong) XCollectionView* collectionView;

@property (nonatomic, strong) UIView* emptyView;

- (Class)collectionViewClass;

- (UICollectionViewLayout *)collectionViewLayout;

@end
