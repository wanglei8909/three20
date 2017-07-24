//
//  WPUMShareManeger.h
//  woPass
//
//  Created by 王蕾 on 15/8/11.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocial.h"

@interface WPUMShareManeger : NSObject<UMSocialUIDelegate>


@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *shareView;
@property (nonatomic, strong) NSArray *mPlatforms;
@property (nonatomic, strong) NSString *mShareUrl;
@property (nonatomic, strong) NSString *mContent;
@property (nonatomic, strong) UIImage *mImage;
@property (nonatomic, strong) NSString *mImageUrl;
@property (nonatomic, weak) UIViewController *mRootCtrl;

+ (instancetype)shareManager;

- (void)shareWithmShareUrl:(NSString *)shareUrl andContent:(NSString *)content andImage:(NSString *)imageUrl;

- (void) ShareWithShareUrl:(NSString *)shareUrl andContent:(NSString *)content andImage:(UIImage *)image andSucceedBlock:(void(^)())succeedBlock andFaildBlock:(void(^)())faildBlock;

@end
