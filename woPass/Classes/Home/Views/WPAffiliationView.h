//
//  WPAffiliationView.h
//  woPass
//
//  Created by htz on 15/7/31.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPAffiliationViewModel : NSObject

@property (nonatomic, copy)NSString *phoneNumber;
@property (nonatomic, copy)NSString *affiliation;
@property (nonatomic, copy)NSString *phoneCode;


@end

@interface WPAffiliationView : UIView

@property (nonatomic, strong)WPAffiliationViewModel *affiliationViewModel;


@end
