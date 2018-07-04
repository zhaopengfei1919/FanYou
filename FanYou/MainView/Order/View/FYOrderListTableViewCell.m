//
//  FYOrderListTableViewCell.m
//  FanYou
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYOrderListTableViewCell.h"

@implementation FYOrderListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(FYOrderListModel *)model{
    _model = model;
    self.NameLabel.text = model.goods_name;
    [self.GoodsImage sd_setImageWithURL:[NSURL URLWithString:model.goods_icon] placeholderImage:[UIImage imageNamed:@""]];
    if ([model.is_seven intValue] == 1) {
        self.SevenImage.hidden = NO;
    }else
        self.SevenImage.hidden = YES;
    self.PriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.goods_price floatValue]];
    self.CountLabel.text = [NSString stringWithFormat:@"x%@",model.goods_count];
    
    CGSize size = CGSizeMake(SCREEN_WIDTH - 160,2000);
    NSDictionary * fontDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil];
    CGRect labelsize = [self.NameLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    if (labelsize.size.height < 35) {
        self.NameLabelHeight.constant = labelsize.size.height;
    }else
        self.NameLabelHeight.constant = 35;
}
-(void)setDetailmodel:(FYOrderDetailModel *)detailmodel{
    _detailmodel = detailmodel;
    self.NameLabel.text = detailmodel.goods_name;
    [self.GoodsImage sd_setImageWithURL:[NSURL URLWithString:detailmodel.goods_icon] placeholderImage:[UIImage imageNamed:@""]];
    if ([detailmodel.is_seven intValue] == 1) {
        self.SevenImage.hidden = NO;
    }else
        self.SevenImage.hidden = YES;
    self.PriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[detailmodel.goods_price floatValue]];
    self.CountLabel.text = [NSString stringWithFormat:@"x%@",detailmodel.goods_count];
    
    CGSize size = CGSizeMake(SCREEN_WIDTH - 160,2000);
    NSDictionary * fontDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil];
    CGRect labelsize = [self.NameLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    if (labelsize.size.height < 35) {
        self.NameLabelHeight.constant = labelsize.size.height;
    }else
        self.NameLabelHeight.constant = 35;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
