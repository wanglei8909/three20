//
//  BannerView.m
//  TJLike
//
//  Created by MC on 15-3-30.
//  Copyright (c) 2015年 IPTV_MAC. All rights reserved.
//

#import "BannerView.h"
#import "UIImageView+WebCache.h"
@implementation BannerView
{
    UIImageView *netView;
}
@synthesize delegate,OnClick;
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor lightGrayColor];
        
        UIImageView *holder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 180, 34)];
        holder.centerX = self.centerX;
        holder.image = [UIImage imageNamed:@"placeholder-2"];
        [self addSubview:holder];
        
        netView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        netView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:netView];

        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = netView.bounds;
        but.backgroundColor = [UIColor clearColor];
        [but addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:but];
    }
    return self;
}
- (void)Click{
    if (delegate && OnClick) {
        SafePerformSelector([delegate performSelector:OnClick withObject:self]);
    }
}
- (void)LoadContent:(WPPriAdModel *)info{
    self.mInfo = info;
    [netView sd_setImageWithURL:[NSURL URLWithString:info.img]];
    NSLog(@"---->%@",info.img);
}
- (void)dealloc{
    self.mInfo = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
