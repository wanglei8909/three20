//
//  WPBackDoorView.m
//  woPass
//
//  Created by htz on 15/8/11.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPBackDoorView.h"

@implementation WPBackDoorView


+ (instancetype)backDoorViewOnClick:(Action) buttonSelectAction {
    
    return [[self alloc] initWithAction:buttonSelectAction];
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        NSArray *titleArray = @[@"线上", @"测试", @"开发"];
        
        NSInteger flag = 0;
        NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:BASEURLKEY];
        if ([url isEqualToString:BASEURLONLINE]) {
            
            flag = WPBackDoorOnLine;
        } else if ([url isEqualToString:BASEURLTEST]) {
            
            flag = WPBackDoorTest;
        } else if ([url isEqualToString:BASEURLDEV]) {
            
            flag = WPBackDoorDev;
        }
        
        self.size = CGSizeMake(100, 30);
        for (NSInteger index = 0; index < 3 ; index ++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:titleArray[index] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
            button.titleLabel.font = XFont(kFontTiny);
            [button setTitleColor:RGBCOLOR_HEX(KTextOrangeColor) forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithColor:[UIColor blackColor]] forState:UIControlStateSelected];
            button.tag = WPBackDoorOnLine + index;
            if (button.tag == flag) {
                
                button.selected = YES;
            }
            [self addSubview:button];
        }
        
    }
    return self;
}

- (instancetype)initWithAction:(Action) buttonSelectAction {
    
    if (self = [self init]) {
        
        self.buttonSelectAction = buttonSelectAction;
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    weaklySelf();
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        
        subview.height = weakSelf.height;
        subview.width = weakSelf.width / 5;
        subview.left = idx * (subview.width);
        subview.centerY = weakSelf.height / 2;
    }];
    
}

- (void)buttonClick:(UIButton *)button {
    
    [self.subviews enumerateObjectsUsingBlock:^(UIButton *subview, NSUInteger idx, BOOL *stop) {
        
        subview.selected = NO;
    }];
    button.selected = YES;
    if (self.buttonSelectAction) {
        
        self.buttonSelectAction(button.tag);
    }
}

@end
