//
//  OrderHeaderView.m
//  FanYou
//
//  Created by apple on 2018/6/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "OrderHeaderView.h"
#import "FYAddressListViewController.h"

@implementation OrderHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setModel:(FYAddressModel *)model{
    _model = model;
    self.NameLabel.text = [NSString stringWithFormat:@"收货人：%@",model.acc_name];
    self.PhoneLabel.text = model.acc_mobile;
    self.AreaLabel.text = [NSString stringWithFormat:@"收货地址：%@ %@ %@ %@",model.prov,model.city,model.country,model.addr];
    
    CGSize size = CGSizeMake(SCREEN_WIDTH - 50,2000);
    NSDictionary * fontDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],NSFontAttributeName, nil];
    CGRect labelsize = [self.AreaLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    if (labelsize.size.height < 30) {
        self.AreaLabelHeight.constant = labelsize.size.height;
    }else
        self.AreaLabelHeight.constant = 30;
}

- (IBAction)chosenAddress:(id)sender {
    FYAddressListViewController * address = [[FYAddressListViewController alloc]init];
    
    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] && object != nil) {
        object = [object nextResponder];
    }
    UIViewController *superController = (UIViewController*)object;
    address.isfromOrder = YES;
    [superController.navigationController pushViewController:address animated:YES];
    address.addressBlock = ^(FYAddressModel *model) {
        [self.AddressBtn setTitle:@"" forState:0];
        self.model = model;
    };
}
@end
