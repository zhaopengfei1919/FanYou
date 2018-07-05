//
//  FYCardTableViewCell.m
//  FanYou
//
//  Created by apple on 2018/6/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYCardTableViewCell.h"

@implementation FYCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(FYCardModel *)model{
    _model = model;
    self.BankName.text = model.bank_name;
    self.CardNumber.text = [NSString stringWithFormat:@"****    ****    ****    %@",model.card_no];
    if (model.card_type == nil) {
        
    }else
        self.CardType.text = model.card_type;
    
    if ([model.bank_name isEqualToString:@"工商银行"]) {
        self.BankImage.image = [UIImage imageNamed:@"工行icon-"];
        self.BackImage.image = [UIImage imageNamed:@"工行背景-"];
    }else if ([model.bank_name isEqualToString:@"农业银行"]){
        self.BankImage.image = [UIImage imageNamed:@"农行icon-"];
        self.BackImage.image = [UIImage imageNamed:@"农行背景-"];
    }else if ([model.bank_name isEqualToString:@"招商银行"]){
        self.BankImage.image = [UIImage imageNamed:@"招行icon-"];
        self.BackImage.image = [UIImage imageNamed:@"招行背景-"];
    }else{
        [self.BankImage sd_setImageWithURL:[NSURL URLWithString:model.back_icon]];
        [self.BackImage sd_setImageWithURL:[NSURL URLWithString:model.back_icon]];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
