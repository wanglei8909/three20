//
//  UIView+ShowMsg.m
//  woPass
//
//  Created by 王蕾 on 15/10/30.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "UIView+ShowMsg.h"
#import "MBProgressHUD.h"

@implementation UIView (ShowMsg)



- (void)showHint:(NSString *)hint hide:(CGFloat)delay
{
    if (!hint) {
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.yOffset = ((SCREEN_HEIGHT-64)*0.5) - 150;
    [hud setDetailsLabelFont:XFont(14)];
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setMode:MBProgressHUDModeText];
    [hud setDetailsLabelText:hint];
    [hud hide:YES afterDelay:delay];
}

@end
