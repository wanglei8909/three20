//
//  WPAdsViewPagerCellItem.m
//  woPass
//
//  Created by htz on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//


#import "WPAdsViewPagerCellItem.h"
#import "WPPagerAdsModel.h"
#import "UIImageView+WebCache.h"
#import "TZWebViewController.h"
#import "NSObject+TZExtension.h"
#import "WPURLManager.h"
#import "JMWhenTapped.h"
#import "UIImage+WebP.h"


@interface WPAdsViewPagerCellItem () {
    
    dispatch_queue_t _serialQueue;
}

@end

@implementation WPAdsViewPagerCellItem

- (instancetype)init {
    
    if (self = [super init]) {
        
        _serialQueue = dispatch_queue_create("adsViewQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (Class)cellClass {
    return [WPAdsViewPagerCell class];
}

- (BOOL)autoSetValues {
    return YES;
}

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    return (self.pagerAdsArray.count >= 1 ? (SCALED(self.imageHeight) + kPadding) : 0);
}

- (void)setPagerAdsArray:(NSArray *)pagerAdsArray {
    
    _pagerAdsArray = pagerAdsArray;
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [self.imagesArray removeAllObjects];
    weaklySelf();

    [pagerAdsArray enumerateObjectsUsingBlock:^(WPPagerAdsModel  *pagerAdsModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        __block UIImage *adsImage;
        UIImage *placeHolderImage = [UIImage imageNamed:@"placeholder-2"];
        adsImage = [imageCache imageFromDiskCacheForKey:pagerAdsModel.imageURL];
        
        if (!adsImage) {
            
            adsImage = placeHolderImage;
            weakSelf.imageHeight = 150;
            [weakSelf.imagesArray addObject:adsImage];
            dispatch_async(_serialQueue, ^{
                
                UIImage *urlImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pagerAdsModel.imageURL]]];
                if (urlImage) {
                    adsImage = urlImage;
                    [imageCache storeImage:adsImage forKey:pagerAdsModel.imageURL];
                    [weakSelf.imagesArray removeObjectAtIndex:idx];
                    [weakSelf.imagesArray insertObject:adsImage atIndex:idx];
                    weakSelf.imageHeight = adsImage.size.height / 2;
                    [weakSelf reloadCell];
                }
            });
        } else {
            
            weakSelf.imageHeight = adsImage.size.height / 2;
            [weakSelf.imagesArray addObject:adsImage];
        }
    }];
}

- (void)reloadCell {
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
        WPAdsViewPagerCell *cell = (WPAdsViewPagerCell *)self.tableViewCell;
        cell.adsPagerView = nil;
        CallBlock(self.imageReadyAction);
    });
}

- (NSMutableArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [[NSMutableArray alloc] init];
    }
    return _imagesArray;
}

- (instancetype)applyImageReadyAction:(Action)imageReadyAction {
    
    _imageReadyAction = imageReadyAction;
    return self;
}


@end

@interface WPAdsViewPagerCell () <GCPagingViewDelegate>

@end

@implementation WPAdsViewPagerCell

- (GCPagingView *)adsPagerView {
    if (!_adsPagerView) {
        WPAdsViewPagerCellItem *cellItem = (WPAdsViewPagerCellItem *)self.tableViewCellItem;
        _adsPagerView = [[GCPagingView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCALED(cellItem.imageHeight))];
        _adsPagerView.delegate = self;
        [self.contentView addSubview:_adsPagerView];
        
    }
    return _adsPagerView;
}

- (NSInteger)numberOfPagesInPagingView:(GCPagingView *)pagingView {
    WPAdsViewPagerCellItem *cellItem = (WPAdsViewPagerCellItem *)self.tableViewCellItem;
    return cellItem.imagesArray.count;
}

- (UIView *)GCPagingView:(GCPagingView*)pagingView viewAtIndex:(NSInteger)index {
    
    UIImageView *imageView = (UIImageView *)[pagingView dequeueReusablePage];
    WPAdsViewPagerCellItem *item = (WPAdsViewPagerCellItem *)self.tableViewCellItem;
    
    if (!imageView) {
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALED(item.imageHeight))];
    }
    [imageView whenTapped:^{
        
        [WPURLManager openURLWithMainTitle:((WPPagerAdsModel *)[item.pagerAdsArray objectAtIndex:index]).title urlString:((WPPagerAdsModel *)[item.pagerAdsArray objectAtIndex:index]).actionURL];
        
    }];
    
    imageView.image = [item.imagesArray objectAtIndex:index];;
    return imageView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(kPadding, 0, 0, 0));
    
    self.adsPagerView.frame = self.contentView.bounds;
}

- (void)setTableViewCellItem:(WPAdsViewPagerCellItem *)tableViewCellItem {
    
    [super setTableViewCellItem:tableViewCellItem];
    [self.adsPagerView reloadData];
    if (tableViewCellItem.imagesArray.count > 1) {
        
        [self.adsPagerView startAutoScroll];
    } else {
        
        [self.adsPagerView stopAutoScroll];
    }
    
    if (![tableViewCellItem heightForTableView:nil]) {
        
        self.hidden = YES;
    } else {
        
        self.hidden = NO;
    }
    
    [self setNeedsLayout];
}

@end
