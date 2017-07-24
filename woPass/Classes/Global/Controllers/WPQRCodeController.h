//
//  WPQRCodeController.h
//  woPass
//
//  Created by 王蕾 on 15/7/27.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface WPQRCodeController : XViewController<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *qrSession;//回话
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *qrVideoPreviewLayer;//读取
@property (nonatomic, strong) UIImageView *line;//交互线
@property (nonatomic, strong) NSTimer *lineTimer;//交互线控制

@property (nonatomic, copy) void (^SYQRCodeCancleBlock) (WPQRCodeController *);//扫描取消
@property (nonatomic, copy) void (^SYQRCodeSuncessBlock) (WPQRCodeController *,NSString *);//扫描结果
@property (nonatomic, copy) void (^SYQRCodeFailBlock) (WPQRCodeController *);//扫描失败

@end
