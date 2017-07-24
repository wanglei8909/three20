//
//  YDPopOverWindow.m
//  common
//
//  Created by Tulipa on 14-7-23.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import "XPopOverWindow.h"
#import "XViewController.h"

@interface YDPopOverViewController : XViewController
{
	UIView *popOverView;
}

- (instancetype)initWithView:(UIView *)view;

@end

@implementation YDPopOverViewController

//- (void)loadView
//{
//	UIControl *control = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
//	[control addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
//	self.view = control;
//}

- (void)hide
{
	[self.view.window setHidden:YES];
}

- (instancetype)initWithView:(UIView *)view
{
	if (self = [self initWithNibName:nil bundle:nil])
	{
		popOverView = view;
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor clearColor];
	if (popOverView)
	{
		[self.view addSubview:popOverView];
	}
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	[popOverView setCenter:CGPointMake(self.view.width / 2.0f, self.view.height / 2.0f)];
}

@end



@interface XPopOverWindow ()

@property (nonatomic, weak) YDPopOverViewController *viewController;

@end

@implementation XPopOverWindow

+ (NSMutableArray *)windows
{
	static NSMutableArray *_windows = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_windows = [NSMutableArray array];
	});
	return _windows;
}

- (id)init
{
	if (self = [self initWithFrame:[UIScreen mainScreen].bounds])
	{
		self.backgroundColor = RGBACOLOR_HEX(0x000000, 0.4);
		[self setWindowLevel:UIWindowLevelAlert];
		self.rootViewController = [[YDPopOverViewController alloc] initWithView:self.view];
	}
	
	return self;
}

- (UIView *)view
{
	return _view;
}

- (instancetype)initWithView:(UIView *)view
{
	if (self = [self init])
	{
		_view = view;
	}
	return self;
}

- (void)_setHidden:(BOOL)hidden
{
	[super setHidden:hidden];
}

- (void)setHidden:(BOOL)hidden
{
	if (self.relativeViewController && self.relativeViewController.view.hidden)
	{
		return;
	}
	
	if (self.hidden == hidden)
	{
		return;
	}
	
	if (hidden)
	{
		weaklySelf();
		[weakSelf _setHidden:hidden];
	}
	else
	{
		weaklySelf();
		self.alpha = 0;
		[self _setHidden:hidden];
		[UIView animateWithDuration:0.4 animations:^{
			weakSelf.alpha = 1.0f;
		} completion:^(BOOL finished) {
			weakSelf.alpha = 1.0f;
		}];
	}
	
	if (hidden)
	{
		[[[self class] windows] removeObject:self];
	}
	else
	{
		if ([[[self class] windows] indexOfObject:self] == NSNotFound)
		{
			[[[self class] windows] addObject:self];
		}
	}
}


@end
