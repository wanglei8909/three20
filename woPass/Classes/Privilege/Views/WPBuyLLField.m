//
//  WPBuyLLField.m
//  woPass
//
//  Created by 王蕾 on 15/7/31.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPBuyLLField.h"

@implementation WPBuyLLField

-(CGRect)placeholderRectForBounds:(CGRect)bounds{    
    return CGRectMake(bounds.origin.x+20, bounds.origin.y, bounds.size.width, bounds.size.height);
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectMake(bounds.origin.x+20, bounds.origin.y, bounds.size.width, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectMake(bounds.origin.x+20, bounds.origin.y, bounds.size.width, bounds.size.height);
}

@end
