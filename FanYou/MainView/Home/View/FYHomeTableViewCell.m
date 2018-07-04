//
//  FYHomeTableViewCell.m
//  FanYou
//
//  Created by apple on 2018/6/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYHomeTableViewCell.h"
#import "FYAddOrderViewController.h"

@implementation FYHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x5bc1fc).CGColor, (__bridge id)UIColorFromRGB(0x2daef9).CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.bounds;
    [self.BuyBtn.layer addSublayer:gradientLayer];
    
    self.BuyBtn.layer.cornerRadius = 9;
    // Initialization code
}
-(void)setModel:(FYHomeModel *)Model{
    _Model = Model;
    self.TitleLabel.text = Model.goods_name;
    self.ContentLabel.text = Model.goods_desc;
    [self.Image sd_setImageWithURL:[NSURL URLWithString:Model.goods_icon] placeholderImage:[UIImage imageNamed:@""]];
    
    [self.BuyBtn addTarget:self action:@selector(addorder:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)addorder:(UIButton *)btn{
    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] && object != nil) {
        object = [object nextResponder];
    }
    UIViewController *superController = (UIViewController*)object;
    if ([[FYUser userInfo].userId isEqualToNumber:[NSNumber numberWithInt:0]]) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    FYAddOrderViewController * addorder = [[FYAddOrderViewController alloc]init];
    addorder.goods_id = self.Model.goods_id;
    [superController.navigationController pushViewController:addorder animated:YES];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
