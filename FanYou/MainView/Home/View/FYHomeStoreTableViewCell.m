//
//  FYHomeStoreTableViewCell.m
//  FanYou
//
//  Created by apple on 2018/6/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYHomeStoreTableViewCell.h"

@implementation FYHomeStoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(FYHomeStoreModel *)model{
    self.TitleLabel.text = model.shop_name;
    self.DescLabel.text = model.desc;
    [self.LogoImage sd_setImageWithURL:[NSURL URLWithString:model.shop_logo] placeholderImage:[UIImage imageNamed:@""]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
