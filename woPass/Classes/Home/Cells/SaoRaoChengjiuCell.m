//
//  SaoRaoChengjiuCell.m
//  woPass
//
//  Created by 王蕾 on 16/2/26.
//  Copyright © 2016年 unisk. All rights reserved.
//

#import "SaoRaoChengjiuCell.h"

@implementation SaoRaoChengjiuCell
{
    UILabel *numLabel;
    UILabel *typeLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        numLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH*0.5-20, 42)];
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        [self.contentView addSubview:numLabel];
        
        typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5, 0, SCREEN_WIDTH*0.5-20, 42)];
        typeLabel.backgroundColor = [UIColor clearColor];
        typeLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        typeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:typeLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 41, SCREEN_WIDTH, 1)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self.contentView addSubview:line];
    }
    return self;
}
- (void)loadContent:(NSDictionary *)dict{
    numLabel.text = dict[@"num"];
    typeLabel.text = dict[@"type"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
