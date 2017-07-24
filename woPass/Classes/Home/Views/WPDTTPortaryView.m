//
//  WPDTTPortaryView.m
//  woPass
//
//  Created by 王蕾 on 15/12/1.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPDTTPortaryView.h"

@implementation WPDTTPortaryView
{
    UIImageView *bg;
    UIImageView *genderView;
    UITextView *textView;
}
- (void)LoadContent:(NSString *)string{
    textView.text = string;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        genderView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 204, 163.5)];
        genderView.center = CGPointMake(frame.size.width*0.5, frame.size.height*0.5);
        [self addSubview:genderView];
        if ([gUser.gender isEqualToString:@"男"]) {
            genderView.image = [UIImage imageNamed:@"Porboy"];
        }else{
            genderView.image = [UIImage imageNamed:@"Porgirl"];
        }
        
        textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 150, 160)];
        textView.editable = NO;
        textView.center = CGPointMake(frame.size.width*0.5, frame.size.height*0.5-10);
        textView.backgroundColor = [UIColor clearColor];
        //textView.textAlignment = NSTextAlignmentCenter;
        textView.font = [UIFont systemFontOfSize:16];
        textView.textColor = RGBCOLOR_HEX(0xffffff);
        textView.alpha = 0.6;
        [self addSubview:textView];
        
        bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 236)];
        bg.image = [UIImage imageNamed:@"Porbd"];
        bg.center = genderView.center;
        [self addSubview:bg];
        
        
        
    }
    return self;
}


@end
