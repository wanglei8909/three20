//
//  WPNearListCell.m
//  woPass
//
//  Created by 王蕾 on 15/8/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPNearListCell.h"
#import <BaiduMapAPI/BMKPoiSearch.h>
#import <BaiduMapAPI/BMKPoiSearchOption.h>
#import <BaiduMapAPI/BMKGeometry.h>
#import "WPMapSelectedSheet.h"
#import "WPURLManager.h"

@implementation WPNearListCell
{
    UIView *line1;
    UIView *line2;
    UIButton *btn1;
    UIButton *btn2;
    UIView *back;
    UIButton *backBtn;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        back = [[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 115)];
        back.backgroundColor = [UIColor whiteColor];
        back.layer.borderWidth = 1;
        back.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        [self.contentView addSubview:back];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, back.width-100, 20)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        [back addSubview:_nameLabel];
        
        _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.right+15, 5, 65, 20)];
        _distanceLabel.textAlignment = NSTextAlignmentRight;
        _distanceLabel.font = [UIFont systemFontOfSize:16];
        [back addSubview:_distanceLabel];
        
        _starView = [[WPStarView alloc]initWithFrame:CGRectMake(10, _nameLabel.bottom+7, 120, 20)];
        [back addSubview:_starView];
        
        _perPriceLabel = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(135, _nameLabel.bottom+10, 90, 20)];
        _perPriceLabel.backgroundColor =[UIColor clearColor];
        _perPriceLabel.font = [UIFont systemFontOfSize:14];
        [back addSubview:_perPriceLabel];
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, _perPriceLabel.bottom+5, back.width-30, 20)];
        _addressLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        _addressLabel.font = [UIFont systemFontOfSize:14];
        [back addSubview:_addressLabel];
        
        line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 80, back.width, 1)];
        line1.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [back addSubview:line1];
        
        line2 = [[UIView alloc]initWithFrame:CGRectMake(back.width*0.5, 85, 1, 25)];
        line2.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [back addSubview:line2];
        
        for (int i = 0; i<2; i++) {
            UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
            btn.frame = CGRectMake(i*back.width*0.5, 80, back.width*0.5, 35);
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 100+i;
            [back addSubview:btn];
            //iconfont-daozhequ2
            NSString *imageName = [NSString stringWithFormat:@"iconfont-daozhequ%d",i+1];
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(btn.width*0.5-30, 10, 15, 15)];
            image.image = [UIImage imageNamed:imageName];
            [btn addSubview:image];
            
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(image.right+5, 0, 80, 35)];
            title.text = i==0?@"到这去":@"电话";
            title.font = [UIFont systemFontOfSize:16];
            [btn addSubview:title];
            if (i==0) {
                btn1 = btn;
            }else{
                btn2 = btn;
            }
        }
        
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.backgroundColor = [UIColor clearColor];
        backBtn.frame = CGRectMake(0, 0, back.width, 80);
        [backBtn addTarget:self action:@selector(DetailClick) forControlEvents:UIControlEventTouchUpInside];
        [back addSubview:backBtn];
    }
    return self;
}
- (void)DetailClick{
    if ([_detailUrl isEqualToString:@"http://map.baidu.com/"]) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无详情" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [av show];
        return;
    }
    if (_detailUrl && _detailUrl.length>0) {
        [WPURLManager openURLWithMainTitle:@"详情" urlString:_detailUrl];
        [BaiduMob logEvent:@"id_local" eventLabel:@"url"];
    }
}
- (void)BtnClick:(UIButton *)sender{
    if (sender.tag == 100) {
        WPMapSelectedSheet *sheet = [[WPMapSelectedSheet alloc]initWithData:self.info];
        [sheet showInView:self];
        [BaiduMob logEvent:@"id_local" eventLabel:@"way"];
    }else{
        if (self.info.phone.length == 0) {
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无联系电话" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [av show];
            return;
        }
        if (self.info.phone) {
           self.info.phone = [self.info.phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
           self.info.phone = [self.info.phone stringByReplacingOccurrencesOfString:@")" withString:@""];
        }
        NSRange range = [self.info.phone rangeOfString:@"|"];
        if (range.location != NSNotFound) {
            self.info.phone = [self.info.phone stringByReplacingCharactersInRange:NSMakeRange(range.location, self.info.phone.length-range.location) withString:@""];
        }
        NSLog(@"%@",[NSString stringWithFormat:@"tel://%@",self.info.phone]);
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.info.phone]];
        UIWebView *phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
        [self addSubview:phoneCallWebView];
        [BaiduMob logEvent:@"id_local" eventLabel:@"tel"];
    }
}

-(void)layoutSubviews{
    _detailUrl = nil;
    _starView.hidden = YES;
    _perPriceLabel.hidden = YES;
    
    _nameLabel.text = [NSString stringWithFormat:@"%d.%@",self.indexPath,_info.name];
    _addressLabel.text = _info.address;
    
    BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake([gUser.lat doubleValue],[gUser.lng doubleValue]));
    BMKMapPoint point2 = BMKMapPointForCoordinate(_info.pt);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    if (distance<1000) {
        _distanceLabel.text = [NSString stringWithFormat:@"%.0fm",distance];
    }else{
        _distanceLabel.text = [NSString stringWithFormat:@"%.2fkm",distance/1000];
    }
    
    if (_info.price == 0.f) {
        
    }else{
        
    }
    float rat = _info.overallRating/5.f;
    if (rat==0) {
        _starView.hidden = YES;
        _perPriceLabel.hidden = YES;
        _addressLabel.top = _nameLabel.bottom + 10;
        line1.top = 60;
        line2.top = 65;
        btn1.top = 60;
        btn2.top = 60;
        back.height = 95;
        backBtn.height = 60;
    }else{
        _starView.hidden = NO;
        _starView.scorePercent = rat;
        _perPriceLabel.hidden = NO;
        _perPriceLabel.text = [NSString stringWithFormat:@"人均：￥%d",(int)_info.price];
        [_perPriceLabel setTextColor:RGBCOLOR_HEX(kLabelWeakColor) range:NSMakeRange(0, 3)];
        [_perPriceLabel setTextColor:RGBCOLOR_HEX(KTextOrangeColor) range:NSMakeRange(3, _perPriceLabel.text.length-3)];
        _addressLabel.top = _perPriceLabel.bottom + 5;
        line1.top = 80;
        line2.top = 85;
        btn1.top = 80;
        btn2.top = 80;
        backBtn.height = 80;
        back.height = 115;
    }
    _detailUrl = _info.detailUrl;
    
//    //初始化检索服务
//    weaklySelf();
//    _poisearch = [[BMKPoiSearch alloc] init];
//    _poisearch.delegate = weakSelf;
//    //POI详情检索
//    BMKPoiDetailSearchOption* option = [[BMKPoiDetailSearchOption alloc] init];
//    option.poiUid = _info.uid;//POI搜索结果中获取的uid
//    BOOL flag = [_poisearch poiDetailSearch:option];
//    if(flag)
//    {
//        //详情检索发起成功
//    }
//    else
//    {
//        //详情检索发送失败
//    }
}

-(void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPoiDetailResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode
{
    if(errorCode == BMK_SEARCH_NO_ERROR){
        NSLog(@"----->%@",poiDetailResult.detailUrl);
        if (poiDetailResult.price == 0.f) {
            _perPriceLabel.hidden = YES;
        }else{
            _perPriceLabel.hidden = NO;
            _perPriceLabel.text = [NSString stringWithFormat:@"人均：￥%d",(int)poiDetailResult.price];
            [_perPriceLabel setTextColor:RGBCOLOR_HEX(kLabelWeakColor) range:NSMakeRange(0, 3)];
            [_perPriceLabel setTextColor:RGBCOLOR_HEX(KTextOrangeColor) range:NSMakeRange(3, _perPriceLabel.text.length-3)];
        }
        float rat = poiDetailResult.overallRating/5.f;
        if (rat==0) {
            _starView.hidden = YES;
        }else{
            _starView.hidden = NO;
            _starView.scorePercent = rat;
        }
        _detailUrl = poiDetailResult.detailUrl;
    }
}
- (void)dealloc{
    _poisearch.delegate = nil;
    _poisearch = nil;
    _info = nil;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
