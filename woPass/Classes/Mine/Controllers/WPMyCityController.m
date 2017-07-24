//
//  WPMyCityController.m
//  woPass
//
//  Created by 王蕾 on 15/7/28.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMyCityController.h"
#import "WPCityCell.h"
#import "MJExtension.h"
@implementation WPMyCityController



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
    
    [self AddLocationCity];
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
    for (int i = 1; i<_cityArray.count; i++) {
        NSArray *cArray = _cityArray[i][@"cities"];
        for (NSDictionary *dict in cArray) {
            NSString *name = dict [@"name"];
            NSRange range = [name rangeOfString:searchString];
            if (range.location != NSNotFound) {
                [_filterArray addObject:dict];
                break;
            }
            NSString *fullLetter = dict[@"pinyin"];
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
        if (indexPath.section >0) {
            NSDictionary *dict = _cityArray[indexPath.section][@"cities"][indexPath.row];
            [self OnCheck:dict];
        }
    }else{
        NSDictionary *dict = _filterArray[indexPath.row];
        [self OnCheck:dict];
    }
}
#pragma -make tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _cityTable) {
        if (section == 0) {
            return 1;
        }
        return [self.cityArray[section][@"cities"] count];
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
        if (indexPath.section == 0) {
            static NSString *cellId = @"WPCityCell";
            WPCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[WPCityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryNone;
                weaklySelf();
                cell.click = ^(NSDictionary *dict){
                    [weakSelf OnCheck:dict];
                };
            }
            cell.cityArray = _cityArray[0];
            
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
            cell.textLabel.text = _cityArray[indexPath.section][@"cities"][indexPath.row][@"name"];
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
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [self hideLoading:YES];
        int code = [responseObject[@"code"] intValue];
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]])
        {
            if (code == 0) {
                NSDictionary *dataDict = responseObject[@"data"];
                if (dataDict.count >0) {
                    NSMutableDictionary *mDict = [[NSMutableDictionary alloc]init];
                    [mDict setObject:dataDict[@"areaName"] forKey:@"name"];
                    [mDict setObject:dataDict[@"id"] forKey:@"id"];
                    [_cityArray addObject:[[NSArray alloc]initWithObjects:mDict, nil]];
                }
                [self AddPlistCity];
            }
            else{
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
- (void)AddPlistCity{
    
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"region(1)" ofType:@"txt"];
    NSString *str = [[NSString alloc]initWithContentsOfFile:plistPath encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *city = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    if (city && [city isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dict in city) {
            [_cityArray addObject:dict];
            [_indexArray addObject:[NSString stringWithFormat:@"%@",dict[@"key"]]];
            //[_indexArray addObject:@""];
        }
    }
    [_cityTable reloadData];
    [self hideLoading:YES];
}

- (void)OnCheck:(NSDictionary *)cDict{
    if (self.finishBlock) {
        self.finishBlock(cDict);
    }
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
