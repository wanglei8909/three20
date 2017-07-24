//
//  MenuButton.h
//  woPass
//
//  Created by 王蕾 on 16/2/26.
//  Copyright © 2016年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuItem;

typedef void(^DidSelctedItemCompletedBlock)(MenuItem *menuItem);

@interface MenuButton : UIView

/**
 *  点击操作
 */
@property (nonatomic, copy) DidSelctedItemCompletedBlock didSelctedItemCompleted;

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame menuItem:(MenuItem *)menuItem;


@end
