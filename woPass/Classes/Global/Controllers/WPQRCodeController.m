//
//  WPQRCodeController.m
//  woPass
//
//  Created by 王蕾 on 15/7/27.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPQRCodeController.h"


static const float kLineMinY = 185;
static const float kLineMaxY = 385;
static const float kReaderViewWidth = 200;
static const float kReaderViewHeight = 200;

@implementation WPQRCodeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    
    [self initUI];
    [self setOverlayPickerView];
    [self startSYQRCodeReading];
    [self initTitleView];
    [self createBackBtn];
}

- (void)dealloc
{
    if (_qrSession) {
        [_qrSession stopRunning];
        _qrSession = nil;
    }
    
    if (_qrVideoPreviewLayer) {
        _qrVideoPreviewLayer = nil;
    }
    
    if (_line) {
        _line = nil;
    }
    
    if (_lineTimer)
    {
        [_lineTimer invalidate];
        _lineTimer = nil;
    }
}

- (void)initTitleView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, 64)];
    bgView.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
    [self.view addSubview:bgView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 40) / 2.0, 20, 70, 44)];
    titleLab.center = CGPointMake(SCREEN_WIDTH*0.5, 22+20);
    titleLab.text = @"扫一扫";
    titleLab.shadowColor = [UIColor lightGrayColor];
    titleLab.shadowOffset = CGSizeMake(0, - 1);
    titleLab.font = [UIFont boldSystemFontOfSize:18.0];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLab];
}

- (void)createBackBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 60, 44)];
    [btn setCenter:CGPointMake(40, 20+22)];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancleSYQRCodeReading) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)initUI
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //摄像头判断
    NSError *error = nil;
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if (error)
    {
        NSLog(@"没有摄像头-%@", error.localizedDescription);
        return;
    }
    
    //设置输出(Metadata元数据)
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    //设置输出的代理
    //使用主线程队列，相应比较同步，使用其他队列，相应不同步，容易让用户产生不好的体验
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [output setRectOfInterest:[self getReaderViewBoundsWithSize:CGSizeMake(kReaderViewWidth, kReaderViewHeight)]];
    
    //拍摄会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    
    // 读取质量，质量越高，可读取小尺寸的二维码
    if ([session canSetSessionPreset:AVCaptureSessionPreset1920x1080])
    {
        [session setSessionPreset:AVCaptureSessionPreset1920x1080];
    }
    else if ([session canSetSessionPreset:AVCaptureSessionPreset1280x720])
    {
        [session setSessionPreset:AVCaptureSessionPreset1280x720];
    }
    else
    {
        [session setSessionPreset:AVCaptureSessionPresetPhoto];
    }
    
    if ([session canAddInput:input])
    {
        [session addInput:input];
    }
    
    if ([session canAddOutput:output])
    {
        [session addOutput:output];
    }
    
    //设置输出的格式
    //一定要先设置会话的输出为output之后，再指定输出的元数据类型
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    //设置预览图层
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    
    //设置preview图层的属性
    //preview.borderColor = [UIColor redColor].CGColor;
    //preview.borderWidth = 1.5;
    [preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    //设置preview图层的大小
    preview.frame = self.view.layer.bounds;
    //将图层添加到视图的图层
    [self.view.layer insertSublayer:preview atIndex:0];
    //[self.view.layer addSublayer:preview];
    self.qrVideoPreviewLayer = preview;
    self.qrSession = session;
}

- (CGRect)getReaderViewBoundsWithSize:(CGSize)asize
{
    return CGRectMake(kLineMinY / SCREEN_HEIGHT, ((SCREEN_WIDTH - asize.width) / 2.0) / SCREEN_WIDTH, asize.height / SCREEN_HEIGHT, asize.width / SCREEN_WIDTH);
}

- (void)setOverlayPickerView
{
    //画中间的基准线
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300) / 2.0, kLineMinY, 300, 12 * 300 / 320.0)];
    [_line setImage:[UIImage imageNamed:@"QRCodeLine"]];
    [self.view addSubview:_line];
    
    //最上部view
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, kLineMinY-64)];//80
    upView.alpha = 0.3;
    upView.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
    [self.view addSubview:upView];
    
    //左侧的view
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, kLineMinY, (SCREEN_WIDTH - kReaderViewWidth) / 2.0, kReaderViewHeight)];
    leftView.alpha = 0.3;
    leftView.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
    [self.view addSubview:leftView];
    
    //右侧的view
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - CGRectGetMaxX(leftView.frame), kLineMinY, CGRectGetMaxX(leftView.frame), kReaderViewHeight)];
    rightView.alpha = 0.3;
    rightView.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
    [self.view addSubview:rightView];
    
    CGFloat space_h = SCREEN_HEIGHT - kLineMaxY;
    
    //底部view
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0, kLineMaxY, SCREEN_WIDTH, space_h)];
    downView.alpha = 0.3;
    downView.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
    [self.view addSubview:downView];
    
    //四个边角
    UIImage *cornerImage = [UIImage imageNamed:@"QRCodeTopLeft"];
    
    //左侧的view
    UIImageView *leftView_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) - cornerImage.size.width / 2.0, CGRectGetMaxY(upView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    leftView_image.image = cornerImage;
    [self.view addSubview:leftView_image];
    
    cornerImage = [UIImage imageNamed:@"QRCodeTopRight"];
    
    //右侧的view
    UIImageView *rightView_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(rightView.frame) - cornerImage.size.width / 2.0, CGRectGetMaxY(upView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    rightView_image.image = cornerImage;
    [self.view addSubview:rightView_image];
    
    cornerImage = [UIImage imageNamed:@"QRCodebottomLeft"];
    
    //底部view
    UIImageView *downView_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) - cornerImage.size.width / 2.0, CGRectGetMinY(downView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    downView_image.image = cornerImage;
    //downView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:downView_image];
    
    cornerImage = [UIImage imageNamed:@"QRCodebottomRight"];
    
    UIImageView *downViewRight_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(rightView.frame) - cornerImage.size.width / 2.0, CGRectGetMinY(downView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    downViewRight_image.image = cornerImage;
    //downView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:downViewRight_image];
    
    //说明label
    UILabel *labIntroudction = [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame = CGRectMake(CGRectGetMaxX(leftView.frame), CGRectGetMinY(downView.frame) + 25, kReaderViewWidth, 20);
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.font = [UIFont boldSystemFontOfSize:13.0];
    labIntroudction.textColor = [UIColor whiteColor];
    labIntroudction.text = @"将二维码置于框内,即可自动扫描";
    [self.view addSubview:labIntroudction];
    
    UIView *scanCropView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) - 1,kLineMinY,self.view.frame.size.width - 2 * CGRectGetMaxX(leftView.frame) + 2, kReaderViewHeight + 2)];
    scanCropView.layer.borderColor = RGBCOLOR_HEX(KTextOrangeColor).CGColor;
    scanCropView.layer.borderWidth = 2.0;
    [self.view addSubview:scanCropView];
}

#pragma mark -
#pragma mark 输出代理方法

//此方法是在识别到QRCode，并且完成转换
//如果QRCode的内容越大，转换需要的时间就越长
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //扫描结果
    if (metadataObjects.count > 0)
    {
        [self stopSYQRCodeReading];
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        if (obj.stringValue && ![obj.stringValue isEqualToString:@""] && obj.stringValue.length > 0)
        {
            NSLog(@"---------%@",obj.stringValue);
            if ([obj.stringValue hasPrefix:@"http"])
            {
                if (self.SYQRCodeSuncessBlock) {
                    self.SYQRCodeSuncessBlock(self,obj.stringValue);
                }
            }
            else
            {
                if (self.SYQRCodeFailBlock) {
                    self.SYQRCodeFailBlock(self);
                }
            }
        }
        else
        {
            if (self.SYQRCodeFailBlock) {
                self.SYQRCodeFailBlock(self);
            }
        }
    }
    else
    {
        if (self.SYQRCodeFailBlock) {
            self.SYQRCodeFailBlock(self);
        }
    }
}
#pragma mark 交互事件
- (void)startSYQRCodeReading
{
    _lineTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 20 target:self selector:@selector(animationLine) userInfo:nil repeats:YES];
    [self.qrSession startRunning];
}

- (void)stopSYQRCodeReading
{
    if (_lineTimer)
    {
        [_lineTimer invalidate];
        _lineTimer = nil;
    }
    [self.qrSession stopRunning];
}

//取消扫描
- (void)cancleSYQRCodeReading
{
    [self stopSYQRCodeReading];
    if (self.SYQRCodeCancleBlock)
    {
        self.SYQRCodeCancleBlock(self);
    }
}


#pragma mark -
#pragma mark 上下滚动交互线

- (void)animationLine
{
    __block CGRect frame = _line.frame;
    static BOOL flag = YES;
    if (flag)
    {
        frame.origin.y = kLineMinY;
        flag = NO;
        [UIView animateWithDuration:1.0 / 20 animations:^{
            frame.origin.y += 5;
            _line.frame = frame;
        } completion:nil];
    }
    else
    {
        if (_line.frame.origin.y >= kLineMinY)
        {
            if (_line.frame.origin.y >= kLineMaxY - 12)
            {
                frame.origin.y = kLineMinY;
                _line.frame = frame;
                
                flag = YES;
            }
            else
            {
                [UIView animateWithDuration:1.0 / 20 animations:^{
                    frame.origin.y += 5;
                    _line.frame = frame;
                    
                } completion:nil];
            }
        }
        else
        {
            flag = !flag;
        }
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
