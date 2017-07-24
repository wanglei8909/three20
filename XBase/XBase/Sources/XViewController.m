//
//  CViewController.m
//  HotelManager
//
//  Created by Tulipa on 14-5-6.
//  Copyright (c) 2014年 Tulipa. All rights reserved.
//

#import "XViewController.h"
#import "MBProgressHUD.h"
#import "BaiduMobStat.h"
#import <ImageIO/ImageIO.h>
#import "WPNoNetworkView.h"
#import <UIViewControllerAdditions.h>
#import "WPShowNoDataView.h"

@interface _YDNavigationBarLabel : UILabel

@end

@implementation _YDNavigationBarLabel

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
	if ([self superview])
	{
		[self setCenterY:self.superview.height / 2.0f];
	}
}

@end

@interface _YDNavigationBarItem : UINavigationItem

@end

@implementation _YDNavigationBarItem

@end

@interface XViewController ()
{
	_YDNavigationBarItem *navigationBarItem;
    _YDNavigationBarItem *xNavigationBarItem;
    WPNoNetworkView *_noNetView;
    WPShowNoDataView *_noDataView;
    
}
@end

@implementation XViewController

- (UINavigationItem *)navigationItem
{
	if (! navigationBarItem)
	{
		navigationBarItem = [[_YDNavigationBarItem alloc] init];
		if (self.title.length)
		{
			[navigationBarItem setTitle:self.title];
		}
	}
	return navigationBarItem;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    //[self.view setBackgroundColor:[UIColor whiteColor]];
    self.view.backgroundColor = RGBCOLOR_HEX(0xf8f8f8);
    if ([self autoGenerateBackBarButtonItem])
    {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setBackgroundImage:[UIImage imageNamed:@"zuo"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [backButton sizeToFit];
        if ([self hasYDNavigationBar])
        {
            self.xNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        }
        else
        {
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        }
    }
    
	if ([self hasYDNavigationBar])
	{
		self.ydNavigationBar = [[XNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, [self ydNavigationBarHeight])];
		[self.view addSubview:self.ydNavigationBar];
		[self.ydNavigationBar pushNavigationItem:self.xNavigationItem animated:NO];
	}
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.ydNavigationBar setFrame:CGRectMake(0, 0, self.view.width, [self ydNavigationBarHeight])];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.view bringSubviewToFront:self.ydNavigationBar];
    [[BaiduMobStat defaultStat]pageviewStartWithName:self.title];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[BaiduMobStat defaultStat]pageviewEndWithName:self.title];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [XViewController doNavigatorGarbageCollection];
    });
}

- (CGFloat)ydNavigationBarHeight
{
    return YDAvalibleOS(7) ? 64 : 44;
}

- (BOOL)hasYDNavigationBar
{
	return NO;
}

- (UINavigationItem *)xNavigationItem
{
    if (! xNavigationBarItem)
    {
        xNavigationBarItem = [[_YDNavigationBarItem alloc] init];
        if (self.title.length)
        {
            [xNavigationBarItem setTitle:self.title];
        }
    }
    return xNavigationBarItem;
}

- (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion
{
	if (YDAvalibleOS(8) && ! flag)
	{
		__block BOOL wait = YES;
		[super dismissViewControllerAnimated:flag completion:^{
			if (completion)
			{
				completion();
			}
			wait = NO;
		}];
		while (wait)
		{
			[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
		}
	}
	else
	{
		[super dismissViewControllerAnimated:flag completion:completion];
	}
}

- (UIBarButtonItem *)GetImageBarItem:(UIImage *)image target:(id)target action:(SEL)action {
    int iBtnWidth = YDAvalibleOS(7)?30:40;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, iBtnWidth, 40);
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    int iWidth = image.size.width/2;
    int iHeight = image.size.height/2;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake((iBtnWidth-iWidth)/2, (40-iHeight)/2, iWidth, iHeight);
    [rightBtn addSubview:imageView];
    
    return [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
- (UIBarButtonItem *)GetTextBarItem:(NSString *)name target:(id)target action:(SEL)action {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setTitle:name forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGBCOLOR_HEX(0xed6d00) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [rightBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
    return [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
- (void)AddRightImageBtn:(UIImage *)image target:(id)target action:(SEL)action {
    self.xNavigationItem.rightBarButtonItem = [self GetImageBarItem:image target:target action:action];
}
- (void)AddRightTextBtn:(NSString *)name target:(id)target action:(SEL)action {
    self.xNavigationItem.rightBarButtonItem = [self GetTextBarItem:name target:target action:action];
}

- (void)AddLeftTextBtn:(NSString *)name target:(id)target action:(SEL)action{
    self.xNavigationItem.leftBarButtonItem = [self GetTextBarItem:name target:target action:action];
}

- (void)ShowNoData{
    if (!_noDataView) {
        _noDataView = [[WPShowNoDataView alloc]init];
        _noDataView.backgroundColor = self.view.backgroundColor;
        //_noDataView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_noDataView];
    }
    _noDataView.hidden = NO;
}

- (void)ShowNoNetWithRelodAction:(void(^)()) block{

    [self ShowNoNetWithRelodAction:block adapt:65];
}

- (void)ShowNoNetWithRelodAction:(void(^)()) block adapt:(CGFloat)adapt {
    
    if (!_noNetView) {
        _noNetView = [[WPNoNetworkView alloc]initWithAdapte:adapt];
        _noNetView.backgroundColor = self.view.backgroundColor;
        [self.view addSubview:_noNetView];
    }
    _noNetView.block = block;
    _noNetView.hidden = NO;
}

@end


@implementation UIViewController (hint)

- (void)showHint:(NSString *)hint hide:(CGFloat)delay
{
    if (!hint) {
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.yOffset = ((SCREEN_HEIGHT-64)*0.5) - 150;
    [hud setDetailsLabelFont:XFont(14)];
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setMode:MBProgressHUDModeText];
    [hud setDetailsLabelText:hint];
    [hud hide:YES afterDelay:delay];
}

- (void)showLoading:(BOOL)animated
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:animated];
    
    [hud setColor:[UIColor clearColor]];
    
    [hud setCustomView:[self getCustomView]];
    
    [hud setAnimationType:MBProgressHUDAnimationZoom];
    
    [hud setRemoveFromSuperViewOnHide:YES];
    
    [hud setMode:MBProgressHUDModeCustomView];
    
    [hud setDetailsLabelText:@"正在加载中..."];
    
    [hud setDetailsLabelColor:[UIColor darkGrayColor]];
    
    [hud setDetailsLabelFont:XFont(14)];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"loading" withExtension:@"gif"];
    hud.customView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    
}
- (UIImageView *)getCustomView{
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65, 65)];
    view.backgroundColor = [UIColor clearColor];
    //loading1
    view.image = [UIImage imageNamed:@"loading1"];
    return view;
}

- (void)hideLoading:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}



@end


#if __has_feature(objc_arc)
#define toCF (__bridge CFTypeRef)
#define fromCF (__bridge id)
#else
#define toCF (CFTypeRef)
#define fromCF (id)
#endif

@implementation UIImage (animatedGIF)

static int delayCentisecondsForImageAtIndex(CGImageSourceRef const source, size_t const i) {
    int delayCentiseconds = 1;
    CFDictionaryRef const properties = CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
    if (properties) {
        CFDictionaryRef const gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
        if (gifProperties) {
            NSNumber *number = fromCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFUnclampedDelayTime);
            if (number == NULL || [number doubleValue] == 0) {
                number = fromCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFDelayTime);
            }
            if ([number doubleValue] > 0) {
                // Even though the GIF stores the delay as an integer number of centiseconds, ImageIO “helpfully” converts that to seconds for us.
                delayCentiseconds = (int)lrint([number doubleValue] * 100);
            }
        }
        CFRelease(properties);
    }
    return delayCentiseconds;
}

static void createImagesAndDelays(CGImageSourceRef source, size_t count, CGImageRef imagesOut[count], int delayCentisecondsOut[count]) {
    for (size_t i = 0; i < count; ++i) {
        imagesOut[i] = CGImageSourceCreateImageAtIndex(source, i, NULL);
        delayCentisecondsOut[i] = delayCentisecondsForImageAtIndex(source, i);
    }
}

static int sum(size_t const count, int const *const values) {
    int theSum = 0;
    for (size_t i = 0; i < count; ++i) {
        theSum += values[i];
    }
    return theSum;
}

static int pairGCD(int a, int b) {
    if (a < b)
        return pairGCD(b, a);
    while (true) {
        int const r = a % b;
        if (r == 0)
            return b;
        a = b;
        b = r;
    }
}

static int vectorGCD(size_t const count, int const *const values) {
    int gcd = values[0];
    for (size_t i = 1; i < count; ++i) {
        // Note that after I process the first few elements of the vector, `gcd` will probably be smaller than any remaining element.  By passing the smaller value as the second argument to `pairGCD`, I avoid making it swap the arguments.
        gcd = pairGCD(values[i], gcd);
    }
    return gcd;
}

static NSArray *frameArray(size_t const count, CGImageRef const images[count], int const delayCentiseconds[count], int const totalDurationCentiseconds) {
    int const gcd = vectorGCD(count, delayCentiseconds);
    size_t const frameCount = totalDurationCentiseconds / gcd;
    UIImage *frames[frameCount];
    for (size_t i = 0, f = 0; i < count; ++i) {
        UIImage *const frame = [UIImage imageWithCGImage:images[i]];
        for (size_t j = delayCentiseconds[i] / gcd; j > 0; --j) {
            frames[f++] = frame;
        }
    }
    return [NSArray arrayWithObjects:frames count:frameCount];
}

static void releaseImages(size_t const count, CGImageRef const images[count]) {
    for (size_t i = 0; i < count; ++i) {
        CGImageRelease(images[i]);
    }
}

static UIImage *animatedImageWithAnimatedGIFImageSource(CGImageSourceRef const source) {
    size_t const count = CGImageSourceGetCount(source);
    CGImageRef images[count];
    int delayCentiseconds[count]; // in centiseconds
    createImagesAndDelays(source, count, images, delayCentiseconds);
    int const totalDurationCentiseconds = sum(count, delayCentiseconds);
    NSArray *const frames = frameArray(count, images, delayCentiseconds, totalDurationCentiseconds);
    UIImage *const animation = [UIImage animatedImageWithImages:frames duration:(NSTimeInterval)totalDurationCentiseconds / 100.0];
    releaseImages(count, images);
    return animation;
}

static UIImage *animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceRef CF_RELEASES_ARGUMENT source) {
    if (source) {
        UIImage *const image = animatedImageWithAnimatedGIFImageSource(source);
        CFRelease(source);
        return image;
    } else {
        return nil;
    }
}

+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithData(toCF data, NULL));
}

+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithURL(toCF url, NULL));
}

@end

