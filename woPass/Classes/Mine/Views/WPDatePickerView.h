//
//  WPDatePickerView.h
//  woPass
//
//  Created by 王蕾 on 15/7/16.
//  Copyright (c) 2015年 unisk. All rights reserved.
//


@interface WPDatePickerView : UIView

@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) SEL OnPickerSelect;
@property (nonatomic, assign) SEL OnPickerCancel;
@property (nonatomic, strong) NSString *mSelectStr;

@end
