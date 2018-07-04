//
//  AddressTableViewCell1.m
//  FanYou
//
//  Created by apple on 2018/6/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AddressTableViewCell1.h"

@implementation AddressTableViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(FYAddressModel *)model{
    self.nameLabel.text = model.acc_name;
    self.PhoneLabel.text = model.acc_mobile;
    if (model.is_default == 1) {
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"[默认地址]%@ %@ %@ %@",model.prov,model.city,model.country,model.addr]];
        [string addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xF8304B) range:NSMakeRange(0, 6)];
        [string addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:NSMakeRange(6, string.length - 6)];
        self.areaLabel.attributedText = string;
    }else
        self.areaLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",model.prov,model.city,model.country,model.addr];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
