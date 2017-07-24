//
//  WPSegementController.h
//  woPass
//
//  Created by htz on 15/7/12.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WPSegementController;

@protocol WPSegementControllerDelegate <NSObject>

- (void)WPSegementController:(WPSegementController *)segementController FirstButtonDidClicked:(UIButton *)button;

- (void)WPSegementController:(WPSegementController *)segementController secondButtonDidClicked:(UIButton *)button;

@end

@interface WPSegementController : UIView

@property (nonatomic, weak)id<WPSegementControllerDelegate> delegate;


@end
