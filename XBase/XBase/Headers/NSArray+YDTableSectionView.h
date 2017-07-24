//
//  NSArray+YDTableSectionView.h
//  common
//
//  Created by Tulipa on 14-8-18.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTableViewCellItem.h"

@interface NSArray (YDTableSectionView)

@property (nonatomic, strong) XTableViewCellItem *sectionHeaderItem;

@property (nonatomic, strong) XTableViewCellItem *sectionFooterItem;

@end

@interface YDtableSectionView : UIControl

@property (nonatomic, strong) XTableViewCellItem *sectionItem;

@end