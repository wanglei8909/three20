//
//  NSArray+YDTableSectionView.m
//  common
//
//  Created by Tulipa on 14-8-18.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import "NSArray+YDTableSectionView.h"
#import <objc/runtime.h>

@implementation NSArray (YDTableSectionView)

- (void)setSectionHeaderItem:(XTableViewCellItem *)sectionHeaderItem
{
	objc_setAssociatedObject(self, "sectionHeaderItem", sectionHeaderItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XTableViewCellItem *)sectionHeaderItem
{
	return objc_getAssociatedObject(self, "sectionHeaderItem");
}

- (void)setSectionFooterItem:(XTableViewCellItem *)sectionFooterItem
{
    objc_setAssociatedObject(self, "sectionFooterItem", sectionFooterItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XTableViewCellItem *)sectionFooterItem
{
    return objc_getAssociatedObject(self, "sectionFooterItem");
}

@end


@implementation YDtableSectionView


@end