//
//  Address2TableViewCell.m
//  FanYou
//
//  Created by apple on 2018/6/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "Address2TableViewCell.h"

@implementation Address2TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(FYAddressModel *)model{
    self.nameLabel.text = model.acc_name;
    self.phoneLabel.text = model.acc_mobile;
    self.areaLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",model.prov,model.city,model.country,model.addr];
    if (model.is_default == 1) {
        self.isMorenImage.image = [UIImage imageNamed:@"选中状态"];
    }else
        self.isMorenImage.image = [UIImage imageNamed:@"未选中状态-"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
