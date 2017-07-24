//
//  WPCityController.m
//  woPass
//
//  Created by 王蕾 on 15/7/27.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPCityController.h"
#import "WPCityCell.h"

@implementation WPCityController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_cityArray.count==0) {
        [self AddLocationCity];
    }
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    _cityArray = [[NSMutableArray alloc]initWithCapacity:10];
    _indexArray = [[NSMutableArray alloc]initWithCapacity:10];
    _filterArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    _cityTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _cityTable.delegate = self;
    _cityTable.dataSource = self;
    _cityTable.backgroundColor = [UIColor clearColor];
    _cityTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _cityTable.sectionIndexBackgroundColor = [UIColor clearColor];
    _cityTable.sectionIndexColor = RGBCOLOR_HEX(KTextOrangeColor);
    [self.view addSubview:_cityTable];
    
    //searchView
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    _cityTable.tableHeaderView = _searchBar;
    _searchBar.showsScopeBar = YES;
    _searchBar.placeholder = @"请输入城市或首字母查询";
    
    //搜索的时候会有左侧滑动的效果
    _searchCtrl = [[UISearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
    _searchCtrl.delegate = self;
    _searchCtrl.searchResultsDataSource = self;
    _searchCtrl.searchResultsDelegate = self;
    
}

// when we start/end showing the search UI
- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    _cityTable.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        _searchBar.frame = CGRectMake(0, -44, SCREEN_WIDTH, 44);
        //self.ydNavigationBar.hidden = YES;
    }];
}
- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller {
    
}
- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    [UIView animateWithDuration:0.5 animations:^{
        _searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    }];
    _cityTable.hidden = NO;
}
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {
    
}

// called when the table is created destroyed, shown or hidden. configure as necessary.
- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
    
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView {
    
}
// called when table is shown/hidden
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {
    
}
- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView {
    
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView {
    
}
- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView {
    
}
// return YES to reload table. called when search string/option changes. convenience methods on top UISearchBar delegate methods
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [_filterArray removeAllObjects];
    NSLog(@"---->%@",searchString);
    // 谓词搜索
    for (int i = 2; i<_cityArray.count; i++) {
        NSArray *cArray = _cityArray[i][@"citys"];
        for (NSDictionary *dict in cArray) {
            NSString *name = dict [@"name"];
            NSRange range = [name rangeOfString:searchString];
            if (range.location !=  NSNotFound) {
                [_filterArray addObject:dict];
                break;
            }
            NSString *fullLetter = dict[@"fullLetter"];
            NSRange fRange = [fullLetter rangeOfString:searchString];
            if (fRange.location != NSNotFound) {
                [_filterArray addObject:dict];
                break;
            }
        }
    }
    
    return YES;
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    return NO;
}

#pragma -make tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _cityTable) {
        if (indexPath.section == 0) {
            WPCityCell *cell = [[WPCityCell alloc]init];
            return [cell LoadContent:_cityArray[0]];
        }else if (indexPath.section == 1){
            return 80;
        }else{
            return 35;
        }
    }else{
        return 35;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _cityTable) {
        return 35;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath");
    if (tableView == _cityTable) {
        if (indexPath.section >1) {
            if (self.finishBlock) {
                NSDictionary *dict = _cityArray[indexPath.section][@"citys"][indexPath.row];
                self.finishBlock(dict);
            }
        }
    }else{
        if (self.finishBlock) {
            NSDictionary *dict = _filterArray[indexPath.row];
            self.finishBlock(dict);
        }
    }
}
#pragma -make tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _cityTable) {
        if (section == 0 || section == 1) {
            return 1;
        }
        return [self.cityArray[section][@"citys"] count];
    }
    else{
        return _filterArray.count;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _cityTable) {
        return [self.cityArray count];
    }
    else return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _cityTable) {
        if (indexPath.section == 0 || indexPath.section == 1) {
            static NSString *cellId = @"WPCityCell";
            WPCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[WPCityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryNone;
                weaklySelf();
                cell.click = ^(NSDictionary *dict){
                    if (weakSelf.finishBlock) {
                        weakSelf.finishBlock(dict);
                    }
                };
            }
            if (indexPath.section == 0) {
                cell.cityArray = _cityArray[0];
            }else if (indexPath.section == 1){
                cell.cityArray = _cityArray[1][@"citys"];
            }
            return cell;
        }else{
            static NSString *cellId = @"cityCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.backgroundColor = [UIColor clearColor];
                UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 34, SCREEN_WIDTH-15, 0.8)];
                line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
                [cell.contentView addSubview:line];
            }
            cell.textLabel.text = _cityArray[indexPath.section][@"citys"][indexPath.row][@"name"];
            return cell;
        }
    }else{
        static NSString *cellId = @"fitercityCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.textLabel.text = _filterArray[indexPath.row][@"name"];
        return cell;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 35)];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = RGBCOLOR_HEX(kLabelWeakColor);
    label.font = [UIFont systemFontOfSize:16];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    NSString *title = @"";
    if (section==0) {
        title = @"定位城市";
    }else if (section == 1){
        title = @"热门城市";
    }else{
        title = _cityArray[section][@"key"];
    }
    label.text = title;
    return view;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView == _cityTable) {
        return _indexArray;
    }else return nil;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return index+2;
}
- (void)AddLocationCity{
    [self showLoading:YES];
    NSString *url = @"/c/locationToCity";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:gUser.lat forKey:@"lat"];
    [parametersDict setObject:gUser.lng forKey:@"lng"];
    //
    weaklySelf();
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        int code = [responseObject[@"code"] intValue];
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]])
            {
                if (code == 0) {
                    NSDictionary *dataDict = responseObject[@"data"];
                    NSMutableDictionary *mDict = [[NSMutableDictionary alloc]init];
                    [mDict setObject:dataDict[@"areaName"] forKey:@"name"];
                    [mDict setObject:dataDict[@"id"] forKey:@"id"];
                    [_cityArray addObject:[[NSArray alloc]initWithObjects:mDict, nil]];
                    
                    [self RequestToHttp];
                }
                else if (code == 99998) {
                    
                    [weakSelf ShowNoNetWithRelodAction:^{
                       
                        [weakSelf AddLocationCity];
                    }];
                } else {
                    [self hideLoading:YES];
                    [self showHint:msg hide:2];
                }
            }
        else {
            [self hideLoading:YES];
            [self showHint:msg hide:2];
        }
    })];
}

- (void)RequestToHttp{
    NSString *url = @"/c/serviceArea";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    
    //
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        
        int code = [responseObject[@"code"] intValue];
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]])
        {
            if (code == 0) {
                [_cityArray addObject:[responseObject objectForKey:@"data"][@"otherRegions"]];
                NSArray *allRegions = responseObject[@"data"][@"allRegions"];
                for (int i = 0; i<allRegions.count; i++) {
                    NSDictionary *cDict = allRegions[i];
                    [_cityArray addObject:cDict];
                    [_indexArray addObject:cDict[@"key"]];
                }
                [_cityTable reloadData];
                
                
            }
            else{
                [self showHint:msg hide:2];
            }
        }
        else {
            [self showHint:msg hide:2];
        }
        [self hideLoading:YES];
    })];
}


- (BOOL)hideNavigationBar
{
    return YES;
}

- (BOOL)hasYDNavigationBar
{
    return YES;
}

- (BOOL)autoGenerateBackBarButtonItem
{
    return YES;
}

- (NSString *)title {
    return @"选择城市";
}

@end
