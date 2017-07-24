//
//  WPLLPackageView.h
//  woPass
//
//  Created by 王蕾 on 15/8/3.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedType)(NSInteger index);

@interface WPLLPackageView : UIView

@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, strong)UILabel *areaLabel;
@property (nonatomic, copy)SelectedType selectBlock;

-(void)LoadContent;

@end
