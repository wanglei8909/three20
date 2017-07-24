//
//  WPstarLevelVIew.m
//  woPass
//
//  Created by htz on 15/7/13.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPstarLevelVIew.h"


@interface WPstarLevelVIew ()

@end

@implementation WPstarLevelVIew

- (void)layoutSubviews {
    [super layoutSubviews];
    weaklySelf();
    __block NSInteger index = 0;
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
      
        if ([subview isKindOfClass:[UIImageView class]]) {
            
            subview.size = CGSizeMake(15, 15);
            subview.left = index * (subview.width + 5);
            index ++;
        }
    }];
    
    
    
}

- (void)setStarLevel:(NSInteger)starLevel {
    _starLevel = starLevel;
    
    [self removeAllSubviews];
    
    for (NSInteger index = 0; index < _starLevel / 20; index ++) {
        
        UIImageView *starImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star11"]];
        
        [self addSubview:starImageView];
    }
    
    if ((_starLevel % 20)) {
        
        UIImageView *starImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star-1"]];
        [self addSubview:starImageView];
    }
    
    [self setNeedsDisplay];
}


@end
