//
//  WPKeyboardToolBar.h
//  woPass
//
//  Created by htz on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Action)(void);

@interface WPKeyboardToolBar : UIView

@property (nonatomic, strong)UIButton *cancelButton;
@property (nonatomic, strong)UIButton *configButton;
@property (nonatomic, copy)Action cancelAction;
@property (nonatomic, copy)Action configAction;


- (instancetype)applyCancelAction:(Action)cancelAction configAction:(Action)configAction;


@end
