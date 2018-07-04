//
//  FYOrderTableViewCell.m
//  FanYou
//
//  Created by apple on 2018/6/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYOrderTableViewCell.h"

@implementation FYOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(FYHomeModel *)model{
    _model = model;
    self.NameLabel.text = model.goods_name;
    [self.GoodsImage sd_setImageWithURL:[NSURL URLWithString:model.goods_icon] placeholderImage:[UIImage imageNamed:@""]];
    if ([model.is_seven intValue] == 1) {
        self.SevenImage.hidden = NO;
    }else
        self.SevenImage.hidden = YES;
    
    NSString * price = [NSString stringWithFormat:@"￥%@",model.goods_price];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:price];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    self.PriceLabel.attributedText = string;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
