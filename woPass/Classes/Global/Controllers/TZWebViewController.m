//
//  TZWebViewController.m
//  woPass
//
//  Created by htz on 15/7/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "TZWebViewController.h"
#import "DRURLParametersParser.h"
#import "WPURLManager.h"
#import "YHWebViewProgressView.h"
#import "YHWebViewProgress.h"
#import "Reachability.h"
#import "WPUMShareManeger.h"

@interface TZWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong)TZWebView *webView;
@property WebViewJavascriptBridge* bridge;
@property (nonatomic, copy)NSString *urlString;
@property (nonatomic, copy)NSString *mainTitle;
@property (nonatomic, strong)NSDictionary *cookiesDic;

/*
 shareUrl  分享网址
 shareImage     分享图片
 shareContent   分享文字
 */
@property (nonatomic, copy)NSString *shareUrl;
@property (nonatomic, copy)NSString *shareImage;
@property (nonatomic, copy)NSString *shareContent;
@property (nonatomic, strong)YHWebViewProgress *progressProxy;


@end

@implementation TZWebViewController

#pragma mark - Constructors and Life cycle

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query {
    if (self = [super initWithNavigatorURL:URL query:query]) {
        
        _urlString = query[@"urlString"];
        _mainTitle = query[@"mainTitle"];
        _cookiesDic = query[@"cookiesDic"];
        
        _shareUrl = query[@"shareUrl"];
        _shareImage = query[@"shareImage"];
        _shareContent = query[@"shareContent"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    if (self.shareUrl) {
//        self.xNavigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[self rightBarButton]];
//    }
    
    _progressProxy = [[YHWebViewProgress alloc] init];
    
    YHWebViewProgressView *progressView = [[YHWebViewProgressView alloc] init];
    progressView.progressBarColor = RGBCOLOR_HEX(KTextOrangeColor);
    progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
    progressView.hidden = YES;
    
    self.progressProxy.progressView = progressView;
    self.webView.delegate = self.progressProxy;
    self.progressProxy.webViewProxy = self;
    [self.view addSubview:progressView];
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupBridge];
    
    weaklySelf();
    [[WPURLManager sharedManager] initialSendMessageFunctionWithBlock:^(id msg, void (^jsResponse)(id response) ){
        
        [weakSelf sendMessage:msg WithJsResponseCallback:^(id responseData) {
            
            jsResponse(responseData);
        }];
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self loadURLString:self.urlString withCookiesDic:self.cookiesDic];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.webView.frame = CGRectMake(0, [self ydNavigationBarHeight], self.view.width, self.view.height - [self ydNavigationBarHeight]);
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.progressProxy.progressView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 3);
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50 - 55)];
}


#pragma mark - Private Method

- (void)loadURLString:(NSString *)urlString withCookiesDic:(NSDictionary *) cookiesDic {
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        NSLog(@"%@", cookie);
    }
    NSString *scookiesDic = (NSString *)cookiesDic;
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    if (cookiesDic) {
        
//        NSMutableArray *cookiesArray = [NSMutableArray array];
//        [cookiesDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
//            
//            NSDictionary *properties = @{
//                                         //NSHTTPCookieName : [key description],
//                                         NSHTTPCookieValue : [value description],
//                                         NSHTTPCookiePath : @"/",
//                                         NSHTTPCookieDomain : @""
//                                         };
//            NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:properties];
//            [cookiesArray addObject:cookie];
//        }];
//        
//        NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:[cookiesArray copy]];
        [urlRequest setValue:scookiesDic forHTTPHeaderField:@"Cookie"];
    }
    
    if ([urlString hasPrefix:@"http"]) {
        
        [self.webView loadRequest:urlRequest];
    } else {

        NSString *htmlString = [NSString stringWithContentsOfFile:urlString
                                                         encoding:NSUTF8StringEncoding
                                                            error:NULL];
        [self.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:urlString]];
    }
}

- (UIButton *)rightBarButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 40);
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn setTitleColor:RGBCOLOR_HEX(KTextOrangeColor) forState:UIControlStateNormal];
    //btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn addTarget:self action:@selector(OnShareClick) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)setupBridge {
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [WPURLManager openURLWithMainTitle:nil urlString:data finishedAction:^(id info) {
            
            responseCallback(info);
        }];
    }];
    
    self.webView.delegate = self.progressProxy;
    self.progressProxy.webViewProxy = _bridge;
}


- (void)sendMessage:(id)message WithJsResponseCallback:(WVJBResponseCallback)responseCallback {
    
    [_bridge send:message responseCallback:responseCallback];
}




- (void)loadExamplePage:(UIWebView*)webView {
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseURL];
}



#pragma mark - Event Reponse

- (void)OnShareClick{
    [[WPUMShareManeger shareManager] shareWithmShareUrl:self.shareUrl andContent:self.shareContent andImage:self.shareImage];
}



#pragma mark - Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.progressProxy.progressView.hidden = NO;
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reachability currentReachabilityStatus];
    if (status == NotReachable) {
        [self ShowNoNetWithRelodAction:^{
            [self loadURLString:self.urlString withCookiesDic:self.cookiesDic];
        }];
        [self showHint:@"网络异常，请重试" hide:1];
    } else {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.progressProxy.progressView.hidden = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}








#pragma mark - Getter and Setter

- (TZWebView *)webView {
    if (!_webView) {
        _webView = [[TZWebView alloc] init];
        _webView.delegate = self;
        _webView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
        [self.view addSubview:_webView];
    }
    return _webView;
}





#pragma mark - Public


#pragma mark - Three20


- (BOOL)hideNavigationBar
{
    return YES;
}

- (BOOL)hasYDNavigationBar
{
    return YES;
}

- (BOOL)autoGenerateBackBarButtonItem
{
    return YES;
}

- (NSString *)title {
    return self.mainTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

@implementation TZWebView


@end