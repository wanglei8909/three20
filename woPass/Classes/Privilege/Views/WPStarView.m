//
//  WPStarView.m
//  woPass
//
//  Created by 王蕾 on 15/8/28.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPStarView.h"

#define FOREGROUND_STAR_IMAGE_NAME @"b27_icon_star_yellow"
#define BACKGROUND_STAR_IMAGE_NAME @"b27_icon_star_gray"

@implementation WPStarView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildDataAndUI];
    }
    return self;
}

- (void)buildDataAndUI{
    self.foregroundStarView = [self createStarViewWithImage:FOREGROUND_STAR_IMAGE_NAME];
    self.backgroundStarView = [self createStarViewWithImage:BACKGROUND_STAR_IMAGE_NAME];
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
    _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width-42, 1, 42, 20)];
    _scoreLabel.textColor = RGBCOLOR_HEX(KTextOrangeColor);
    _scoreLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_scoreLabel];
    
    self.scorePercent = 0;
    
}

#pragma mark - Get and Set Methods

- (void)setScorePercent:(CGFloat)scroePercent {
    
    if (scroePercent < 0) {
        _scorePercent = 0;
    } else if (scroePercent > 1) {
        _scorePercent = 1;
    } else {
        _scorePercent = scroePercent;
    }
    self.foregroundStarView.frame = CGRectMake(0, 0, (self.bounds.size.width - 45) * self.scorePercent, self.bounds.size.height);
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f分",scroePercent*5.f];
    
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    float right = 45;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width-right, self.height)];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < 5; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * (self.bounds.size.width - right) / 5, 0, (self.bounds.size.width - right) / 5, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
