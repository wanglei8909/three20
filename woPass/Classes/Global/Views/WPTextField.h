//
//  WPTextField.h
//  woPass
//
//  Created by htz on 15/7/19.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPTextField : UITextField

- (instancetype)initWithPlaceholder:(NSString *)placeholder placeholderColor:(UIColor *)color;

+ (instancetype)textFieldWithPlaceholder:(NSString *)placeholder placeholderColor:(UIColor *)color;

+ (instancetype)textFieldWithPlaceholder:(NSString *)placeholder;

@end

