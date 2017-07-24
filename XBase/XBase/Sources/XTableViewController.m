//
//  CTableViewController.m
//  HotelManager
//
//  Created by Tulipa on 14-5-3.
//  Copyright (c) 2014年 Tulipa. All rights reserved.
//

#import "XTableViewController.h"
#import "XTableViewCell.h"
#import "XTableViewCellItem.h"
#import "XTableEmptyView.h"
#import "NSArray+YDTableSectionView.h"

@interface XTableViewController () 


@end


@implementation XTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView setDataSource:self];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
}

- (void)createScrollView
{
    self.scrollView = [[[self scrollViewClass] alloc] initWithFrame:self.view.bounds style:[self tableViewStyle]];
}

- (XTableView *)tableView
{
    return (id)self.scrollView;
}

- (Class)scrollViewClass
{
    return [self tableViewClass];
}

- (Class)tableViewClass
{
    return [XTableView class];
}

- (UITableViewStyle)tableViewStyle
{
	return UITableViewStylePlain;
}

#pragma mark Table View Delegate and Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XTableViewCellItem* item = [self objectForTableView:tableView atIndex:indexPath];
    XTableViewCell* cell = [[item cellClass] dequeueCellForTableView:tableView];
    cell.tableView = tableView;
	item.tableViewCell = cell;
    [cell setDelegate:self];
    [cell setTableViewCellItem:item];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XTableViewCellItem* item = [self objectForTableView:tableView atIndex:indexPath];
    return [item heightForTableView:tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSAssert([NSThread isMainThread], @"非主线程");
    
    XTableViewCellItem *obj = [self objectForTableView:tableView atIndex:indexPath];
    
    [self didSelectObject:obj forTableView:tableView atIndex:indexPath];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	XTableViewCellItem *item = [self objectForTableviewSectionHeader:tableView atSection:section];
    return [self createCommonSectionView:item tableview:tableView];
}

- (UIView *)createCommonSectionView:(XTableViewCellItem *)item tableview:(UITableView *)tableView
{
    if (item)
    {
        YDtableSectionView *sectionView = [[YDtableSectionView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, [item heightForTableView:tableView])];
        XTableViewCell *cell = [[[item cellClass] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell setTableViewCellItem:item];
        [cell setFrame:sectionView.bounds];
        [cell setDelegate:self];
        [sectionView addSubview:cell];
        [sectionView addTarget:self action:@selector(sectionViewDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        sectionView.sectionItem = item;
        cell.tableView = self.tableView;
        return sectionView;
    }
    else
    {
        UIView* view =[[UIView alloc] init];
        [view setBackgroundColor:[UIColor clearColor]];
        return view;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    XTableViewCellItem *item = [self objectForTableviewSectionFooter:tableView atSection:section];
    return [self createCommonSectionView:item tableview:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	XTableViewCellItem *item = [self objectForTableviewSectionHeader:tableView atSection:section];
	return [item heightForTableView:tableView];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    XTableViewCellItem *item = [self objectForTableviewSectionFooter:tableView atSection:section];
    return [item heightForTableView:tableView];
}

- (void)sectionViewDidClicked:(YDtableSectionView *)sender
{
	[self didSelectObject:sender.sectionItem forTableView:self.tableView atIndex:nil];
}

- (void)handleActionForCell:(XTableViewCell *)cell object:(XTableViewCellItem *)item info:(id)info
{
    // Need Override
}

- (id)objectForTableView:(UITableView *)inTableView atIndex:(NSIndexPath *)indexPath
{
    return [[XTableViewCellItem alloc] init];
}

- (id)objectForTableviewSectionHeader:(UITableView *)inTableView atSection:(NSUInteger)section
{
	return nil;
}

- (id)objectForTableviewSectionFooter:(UITableView *)inTableView atSection:(NSUInteger)section
{
    return nil;
}

- (void)didSelectObject:(XTableViewCellItem *)inObject forTableView:(UITableView *)inTableView atIndex:(NSIndexPath *)indexPath
{
    if (inObject.action)
	{
		dispatch_async(dispatch_get_main_queue(), ^{
			[[XNavigator navigator] openURLAction:inObject.action];
		});
	}
	else if (inObject.actionBlock)
	{
		inObject.actionBlock(self.tableView, nil);
	}
}


#pragma mark - emptyView

- (UIView*)emptyView
{
    XTableEmptyView* emptyView = [[XTableEmptyView alloc] init];
    [emptyView setMsg:@"暂无数据"];
    return emptyView;
}

@end
