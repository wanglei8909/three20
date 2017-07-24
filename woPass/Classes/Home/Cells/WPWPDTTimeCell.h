//
//  WPWPDTTimeCell.h
//  woPass
//
//  Created by 王蕾 on 15/12/1.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCChart.h"

@interface WPWPDTTimeCell : UITableViewCell<SCChartDataSource>

- (void)configUI:(NSArray *)timeArray;


@end
