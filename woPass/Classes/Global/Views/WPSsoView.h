//
//  WPSsoView.h
//  woPass
//
//  Created by htz on 15/10/13.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPSsoViewAdapterProtocol.h"

typedef void(^WPChangeAccountLabelClick)(void);

@interface WPSsoView : UIView

@property (nonatomic, copy)WPChangeAccountLabelClick changeAccountLabelClick;


- (instancetype)initWithContentModel:(id<WPSsoViewAdapterProtocol>)model;
- (void)setContentWithModel:(id<WPSsoViewAdapterProtocol>)model;
- (instancetype)applyChangeAccountLabelCick:(WPChangeAccountLabelClick)click;

@end
