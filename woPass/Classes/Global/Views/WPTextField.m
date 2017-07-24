//
//  WPTextField.m
//  woPass
//
//  Created by htz on 15/7/19.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPTextField.h"

@implementation WPTextField

- (instancetype)init {
    
    if (self = [self initWithPlaceholder:@"" placeholderColor:RGBCOLOR_HEX(kPlaceHolderColor)]) {
        
    }
    return self;
}

- (instancetype)initWithPlaceholder:(NSString *)placeholder placeholderColor:(UIColor *)color {
    
    if (self = [super init]) {
        
        
        NSAttributedString *attPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{
                                                                                                           NSFontAttributeName : XFont(kFontLarge),
                                                                                                           NSForegroundColorAttributeName : color}];
        self.attributedPlaceholder = attPlaceholder;
        self.backgroundColor = RGBCOLOR_HEX(0xffffff);
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1;
        self.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        self.layer.masksToBounds = YES;
        self.font = XFont(kFontMiddle);
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    
    return self;
}

+ (instancetype)textFieldWithPlaceholder:(NSString *)placeholder placeholderColor:(UIColor *)color {
    
    return [[self alloc] initWithPlaceholder:placeholder placeholderColor:color];
}

+ (instancetype)textFieldWithPlaceholder:(NSString *)placeholder {
    return [self textFieldWithPlaceholder:placeholder placeholderColor:RGBCOLOR_HEX(kPlaceHolderColor)];
}

- (NSString *)text {
    
    NSString *string = [super text];
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
