//
//  YDPopoverView.h
//  common
//
//  Created by Tulipa on 14-8-27.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XPopoverView : UIView
{
	UIView *_view;
	UIImageView *bgView;
}

@property (nonatomic, readonly) UIView *view;
@property (nonatomic, strong) UIImageView *bgView;

- (BOOL)blurryBackground;

@end
