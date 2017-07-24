//
//  WPDatePickerView.m
//  woPass
//
//  Created by 王蕾 on 15/7/16.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPDatePickerView.h"

@implementation WPDatePickerView
{
    NSDateFormatter *dateFormatter;
    UIDatePicker *mPickerView;
}

@synthesize delegate, OnPickerCancel, OnPickerSelect;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = frame;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(OnCancelClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIView *backBg = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-250, SCREEN_WIDTH, 250)];
        backBg.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        [self addSubview:backBg];
        
        UIToolbar *topBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        topBar.barStyle = UIBarStyleDefault;
        
        [backBg addSubview:topBar];
        
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(OnCancelClick)];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(OnSelectClick)];
        topBar.items = [NSArray arrayWithObjects: spaceItem,cancelItem, spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,closeItem,spaceItem, nil];
        
        mPickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height-44)];
        // 显示选中框
        mPickerView.datePickerMode = UIDatePickerModeDate;
//        mPickerView.showsSelectionIndicator=YES;
//        mPickerView.dataSource = self;
//        mPickerView.delegate = self;
        mPickerView.backgroundColor = [UIColor whiteColor];
        [backBg addSubview:mPickerView];
        
        dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    return self;
}


- (void)OnSelectClick {
    if (delegate && OnPickerSelect) {
        self.mSelectStr = [dateFormatter stringFromDate:mPickerView.date];
        SafePerformSelector(
                            [delegate performSelector:OnPickerSelect withObject:self];
                            );
    }
}

- (void)OnCancelClick {
    if (delegate && OnPickerCancel) {
                SafePerformSelector(
                            [delegate performSelector:OnPickerCancel withObject:self];
                            );
    }
}




@end
