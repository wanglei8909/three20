//
//  CListTableViewController.h
//  HotelManager
//
//  Created by Tulipa on 14-5-9.
//  Copyright (c) 2014年 Tulipa. All rights reserved.
//

#import "XTableViewController.h"

@interface XListTableViewController : XTableViewController
{
    NSArray* _items;
}
@property (nonatomic, strong) NSArray* items;
@property (nonatomic, assign) NSInteger curPage;
@end
