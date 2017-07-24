//
//  TZButton.m
//  wo+life
//
//  Created by htz on 15/6/30.
//  Copyright (c) 2015年 7ul.ipa. All rights reserved.
//

#import "TZButton.h"

@implementation TZButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGSize)sizeThatFits:(CGSize)size {
    
    CGSize fitSize = [super sizeThatFits:size];
    if (!self.isImageOnRight) {
        
        fitSize.width += (self.titleEdgeInsets.left);
    } else {
        
        fitSize.width += (self.imageEdgeInsets.left);
    }

    return fitSize;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (!self.isImageOnRight) {
        
        CGRect imageFrame = self.imageView.frame;
        imageFrame.origin = CGPointMake(self.imageEdgeInsets.left, self.imageEdgeInsets.top);
        
        CGRect lableFrame = self.titleLabel.frame;
        lableFrame.origin = CGPointMake(CGRectGetMaxX(imageFrame) + self.titleEdgeInsets.left, self.titleEdgeInsets.top);
        
        self.imageView.frame = imageFrame;
        self.titleLabel.frame = lableFrame;
        
    } else {
        
        CGRect lableFrame = self.titleLabel.frame;
        lableFrame.origin = CGPointMake(self.titleEdgeInsets.left, self.titleEdgeInsets.top);
        
        CGRect imageFrame = self.imageView.frame;
        imageFrame.origin = CGPointMake(CGRectGetMaxX(lableFrame) + self.imageEdgeInsets.left, self.imageEdgeInsets.top);
        
        self.titleLabel.frame  = lableFrame;
        self.imageView.frame = imageFrame;
    }
}

@end
