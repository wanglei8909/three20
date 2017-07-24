//
//  WPPriWelfaresModel.h
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface WPPriWelfaresModel : NSObject

@property (nonatomic, assign)int colId;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *mainTitle;
@property (nonatomic, copy)NSString *subTitle;
@property (nonatomic, assign)int type;
@property (nonatomic, copy)NSString *url;

@end
