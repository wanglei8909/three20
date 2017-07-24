//
//  WPGPRSIndicatior.m
//  woPass
//
//  Created by htz on 15/9/19.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPGPRSIndicatiorView.h"
#import "NIAttributedLabel.h"

#define kInitialAngle M_PI_4 / 2
#define kDelta M_PI_2
#define kBoardPadding 25

#define kStartColor 0x92EF2F 
#define kEndColor 0xFE2A1F

CGFloat percent2angle(CGFloat percent);
CGPoint percent2ponit(CGFloat percent, CGFloat radius, CGPoint center);

@interface WPGPRSIndicatiorView ()

@property (nonatomic, strong)NIAttributedLabel *centerLabel;

@property (nonatomic, strong)UIColor *currentIndicatorColor;
@property (nonatomic, assign)CGFloat currentIndicatorPercent;
@property (nonatomic, strong)CADisplayLink *displayLink;
@property (nonatomic, assign)CGFloat fromValue;
@property (nonatomic, assign)CGFloat toValue;

@end

@implementation WPGPRSIndicatiorView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor clearColor];
        self.currentIndicatorColor = RGBCOLOR_HEX(kStartColor);
        self.currentIndicatorPercent = 100;
        
    }
    return self;
}

- (NIAttributedLabel *)centerLabel {
    
    if (!_centerLabel) {
        
        _centerLabel = [NIAttributedLabel new];
        _centerLabel.numberOfLines = 100;
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        [paragraphStyle setAlignment:NSTextAlignmentCenter];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"剩余流量\nM" attributes:@{
                                                                                                                      NSFontAttributeName : XFont(kFontTiny),
                                                                                                                      NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                                                                      NSParagraphStyleAttributeName : paragraphStyle
                                                                                                                      }];
        _centerLabel.attributedText = string;
        [self addSubview:_centerLabel];
    }
    return _centerLabel;
}

- (void)startAnimationFromValue:(CGFloat)fromValue ToValue:(CGFloat)toValue {
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeout)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.fromValue = fromValue;
    self.toValue = toValue;
}

- (void)timeout {
    
    CGFloat t = 2;
    self.currentIndicatorPercent -= t;
    NSString *string;
    if (fabs(self.currentIndicatorPercent - self.toValue * 100 / self.fromValue) < t) {
        
        [self.displayLink invalidate];
        self.displayLink = nil;
        self.currentIndicatorPercent = 1;
        string = [NSString stringWithFormat:@"剩余流量\n%ldM", (NSInteger)self.toValue];
    } else {
        
        string = [NSString stringWithFormat:@"剩余流量\n%ldM", (NSInteger)(self.currentIndicatorPercent * self.fromValue / 100)];
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    NSMutableAttributedString *labelString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{
                                                                                                                  NSFontAttributeName : XFont(kFontTiny),
                                                                                                                  NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                                                                  NSParagraphStyleAttributeName : paragraphStyle
                                                                                                                  }];
    [labelString addAttributes:@{
                                NSFontAttributeName : XFont(kFontLarge)
                                } range:NSMakeRange(5, labelString.length - 6)];
    self.centerLabel.attributedText = labelString;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.centerLabel x_sizeToFit];
    self.centerLabel.centerX = self.width / 2;
    self.centerLabel.centerY = self.height / 2;
}

- (void)setCurrentIndicatorPercent:(CGFloat)currentIndicatorPercent {
    
    _currentIndicatorPercent = currentIndicatorPercent;
    [self setCurrentIndicatorColorWithPercent:_currentIndicatorPercent];
    
    [self setNeedsDisplay];
}

- (UIColor *)HSBGradualWithPercent:(CGFloat)percent {

    UIColor *result;
    CGFloat startHue;
    CGFloat startSat;
    CGFloat startBri;
    [RGBCOLOR_HEX(kStartColor) getHue:&startHue saturation:&startSat brightness:&startBri alpha:NULL];
    
    CGFloat endHue;
    CGFloat endSat;
    CGFloat endBri;
    [RGBCOLOR_HEX(kEndColor) getHue:&endHue saturation:&endSat brightness:&endBri alpha:NULL];
    
    CGFloat deltaHue = (endHue - startHue) / 100.0f;
    CGFloat deltaSat = (endSat - startSat) / 100.0f;
    CGFloat deltaBri = (endBri - startBri) / 100.0f;
    
    CGFloat resultHue = startHue + deltaHue * (100 - percent);
    CGFloat resultSat = startSat + deltaSat * (100 - percent);
    CGFloat resultBri = startBri + deltaBri * (100 - percent);
    
    
    result = [UIColor colorWithHue:resultHue saturation:resultSat brightness:resultBri alpha:1];
    return result;
}

- (UIColor *)RGBGradualWithPercent:(CGFloat)percent {
    UIColor *result;
    NSInteger startRed = (kStartColor >> 16) & 0xFF;
    NSInteger startGreen = (kStartColor >> 8) & 0xFF;
    NSInteger startBlue = (kStartColor) & 0xFF;
    
    NSInteger endRed = (kEndColor >> 16) & 0xFF;
    NSInteger endGreen = (kEndColor >> 8) & 0xFF;
    NSInteger endBlue = (kEndColor) & 0xFF;
    
    CGFloat deltaRed = (endRed - startRed) / 100.0f;
    CGFloat deltaGreen = (endGreen - startGreen) / 100.0f;
    CGFloat deltaBlue = (endBlue - startBlue) / 100.0f;
    
    NSInteger resultRed = startRed + deltaRed * (100 - percent);
    NSInteger resultGreen = startGreen + deltaGreen * (100 - percent);
    NSInteger resultBlue = startBlue + deltaBlue * (100 - percent);
    
    result = RGBCOLOR_HEX((resultRed << 16) + (resultGreen << 8) + (resultBlue));
    return result;
}

- (void)setCurrentIndicatorColorWithPercent:(CGFloat)percent {
    
    UIColor *result;
    
    result = [self RGBGradualWithPercent:percent];
//    result = [self HSBGradualWithPercent:percent];
    
    self.currentIndicatorColor = result;
}


- (void)drawArcPathWithRadius:(CGFloat)radius center:(CGPoint)center percent:(CGFloat)percent context:(CGContextRef)context {
    UIBezierPath *outterPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:percent2angle(0) endAngle:percent2angle(percent) clockwise:YES];
    CGContextAddPath(context, outterPath.CGPath);
}

- (void)drawLine:(CGPoint)startPoint endPoint:(CGPoint)endPoint context:(CGContextRef)context {
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    [leftPath moveToPoint:startPoint];
    [leftPath addLineToPoint:endPoint];
    CGContextAddPath(context, leftPath.CGPath);
}

- (void)drawRect:(CGRect)rect {
    
    CGRect newRect = CGRectInset(rect, kBoardPadding, kBoardPadding);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint center ;
    CGFloat radius ;
    
    CGPoint endPoint ;
    CGPoint startPoint ;
    
    // outter
    center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    radius = newRect.size.height / 2;
    [self drawArcPathWithRadius:radius center:center percent:100 context:context];
    
    CGPoint point ;
    NSString *text;
    
    point = percent2ponit(0, radius, center);
    point = CGPointMake(point.x - SCALED(30), point.y - 10);
    text = @"0";
    [text drawInRect:CGRectMake(point.x, point.y, 100, 100) withAttributes:@{
                                                                 NSFontAttributeName : XFont(kFontTiny),
                                                                 NSForegroundColorAttributeName : [UIColor whiteColor]
                                                                 }];
    
    point = percent2ponit(10, radius, center);
    point = CGPointMake(point.x - SCALED(33), point.y - 10);
    text = @"10%";
    [text drawInRect:CGRectMake(point.x, point.y, 100, 100) withAttributes:@{
                                                                             NSFontAttributeName : XFont(kFontTiny),
                                                                             NSForegroundColorAttributeName : [UIColor whiteColor]
                                                                             }];
    
    point = percent2ponit(25, radius, center);
    point = CGPointMake(point.x - SCALED(33), point.y - 10);
    text = @"25%";
    [text drawInRect:CGRectMake(point.x, point.y, 100, 100) withAttributes:@{
                                                                             NSFontAttributeName : XFont(kFontTiny),
                                                                             NSForegroundColorAttributeName : [UIColor whiteColor]
                                                                             }];
    
    point = percent2ponit(50, radius, center);
    point = CGPointMake(point.x - 10, point.y - SCALED(18));
    text = @"50%";
    [text drawInRect:CGRectMake(point.x, point.y, 100, 100) withAttributes:@{
                                                                             NSFontAttributeName : XFont(kFontTiny),
                                                                             NSForegroundColorAttributeName : [UIColor whiteColor]
                                                                             }];
    
    point = percent2ponit(75, radius, center);
    point = CGPointMake(point.x + SCALED(9), point.y - 10);
    text = @"75%";
    [text drawInRect:CGRectMake(point.x, point.y, 100, 100) withAttributes:@{
                                                                             NSFontAttributeName : XFont(kFontTiny),
                                                                             NSForegroundColorAttributeName : [UIColor whiteColor]
                                                                             }];
    
    point = percent2ponit(100, radius, center);
    point = CGPointMake(point.x + SCALED(25), point.y - 10);
    text = @"100%";
    [text drawInRect:CGRectMake(point.x, point.y, 100, 100) withAttributes:@{
                                                                             NSFontAttributeName : XFont(kFontTiny),
                                                                             NSForegroundColorAttributeName : [UIColor whiteColor]
                                                                             }];
    
    // left
    startPoint = percent2ponit(0, radius, center);
    endPoint = CGPointMake(startPoint.x - SCALED(15), startPoint.y);
    [self drawLine:startPoint endPoint:endPoint context:context];
    
    // right
    startPoint = percent2ponit(100, radius, center);
    endPoint = CGPointMake(startPoint.x + SCALED(15), startPoint.y);
    [self drawLine:startPoint endPoint:endPoint context:context];
    
    [[UIColor whiteColor] set];
    CGContextDrawPath(context, kCGPathStroke);
    
    // blank
    CGFloat delta = 7.0f;
    [self drawArcPathWithRadius:radius - delta * 1.7 center:center percent:100 context:context];
    [RGBCOLOR_HEX(0xFCD0B3) set];
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, delta);
    CGContextDrawPath(context, kCGPathStroke);
    
    // indicator
    [self drawArcPathWithRadius:radius - delta * 1.7 center:center percent:self.currentIndicatorPercent context:context];
    [self.currentIndicatorColor set];;
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, delta);
    CGContextDrawPath(context, kCGPathStroke);
}

@end

CGFloat percent2angle(CGFloat percent) {
    
    static CGFloat initialAngle = kInitialAngle;
    static CGFloat delta = kDelta;
    
    CGFloat result = percent * (M_PI * 2 - initialAngle * 2) / 100;
    result += delta;
    result += initialAngle;
    
    return result;
}

CGPoint percent2ponit(CGFloat percent, CGFloat radius, CGPoint center) {
    
    CGPoint result;
    result = CGPointMake(center.x + radius * cos(percent2angle(percent)), center.y + radius * sin(percent2angle(percent)));
    
    return result;
}
