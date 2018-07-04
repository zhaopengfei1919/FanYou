//
//  FYCenterViewController.m
//  FanYou
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYCenterViewController.h"
#import "FYSetupViewController.h"
#import "FYInformationViewController.h"
#import "FYMyCardViewController.h"
#import "FYAddressListViewController.h"
#import "FYOrderListViewController.h"
#import "FYWithDrawViewController.h"

@interface FYCenterViewController ()

@end

@implementation FYCenterViewController
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
-(void)userdetail{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    
    [NetWorkManager requestWithMethod:POST Url:UserDetail Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            NSDictionary * result = [responseObject objectForKey:@"result"];
            [weakself.HeadImage sd_setImageWithURL:[NSURL URLWithString:[result safeObjectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"默认头像-"]];
            weakself.UserName.text = [result safeObjectForKey:@"nickname"];
            [weakself.LevelBtn setTitle:[result safeObjectForKey:@"level"] forState:0];
            NSString * bablance = [NSString stringWithFormat:@"￥%.2f 提现",[[result safeObjectForKey:@"acc_balance"] floatValue]];
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:bablance];
            [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(string.length - 2, 2)];
            [string addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x8ba4f3) range:NSMakeRange(string.length - 2, 2)];
            self.BalanceLabel.attributedText = string;
            
            self.balance = [result safeObjectForKey:@"acc_balance"];
        }else
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
    } requestRrror:^(id requestRrror) {
        
    }];
}
-(void)ordercount{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    
    [NetWorkManager requestWithMethod:POST Url:OrderStatistics Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            NSDictionary * result = [responseObject safeObjectForKey:@"result"];
            [weakself setui:result];
        }else
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];

    } requestRrror:^(id requestRrror) {
        
    }];
}
-(void)setui:(NSDictionary *)result{
    NSMutableAttributedString * str1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"待付款%@",[result safeObjectForKey:@"unpay"]]];
    [str1 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xF8304B) range:NSMakeRange(3, str1.length - 3)];
    self.Label1.attributedText = str1;
    
    NSMutableAttributedString * str2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"待发货%@",[result safeObjectForKey:@"undeliver"]]];
    [str2 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xF8304B) range:NSMakeRange(3, str1.length - 3)];
    self.Label2.attributedText = str2;
    
    NSMutableAttributedString * str3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"待收货%@",[result safeObjectForKey:@"unreceive"]]];
    [str3 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xF8304B) range:NSMakeRange(3, str1.length - 3)];
    self.Label3.attributedText = str3;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self ordercount];
    [self setupUI];
    [self userdetail];
    // Do any additional setup after loading the view from its nib.
}
-(void)setupUI{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x8dd6fd).CGColor, (__bridge id)UIColorFromRGB(0x5bc1fc).CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 70+StatusHeight);
    [self.BackImage.layer addSublayer:gradientLayer];
    
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.colors = @[
                              (id)[UIColor colorWithRed:141.0f/255.0f green:214.0f/255.0f blue:253.0f/255.0f alpha:1.0f].CGColor,
                              (id)[UIColor colorWithRed:141.0f/255.0f green:214.0f/255.0f blue:253.0f/255.0f alpha:0].CGColor];
    gradientLayer1.locations = @[@0, @1];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(1.0, 0);
    gradientLayer1.frame = CGRectMake(0, 0, 106, 24);
    [self.LevelBtn.layer addSublayer:gradientLayer1];
    self.LevelBtn.layer.cornerRadius = 12;
    self.HeadImage.layer.cornerRadius = 20;
    
    self.TopScroll.constant = -StatusHeight;
    self.ViewHeight.constant = 70 + StatusHeight;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)returnCenter:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)orderClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    FYOrderListViewController * orderList = [[FYOrderListViewController alloc]init];
    if (btn.tag == 0) {
        orderList.type = @"我的订单";
    }else if (btn.tag == 1){
        orderList.type = @"待付款";
    }else if (btn.tag == 2){
        orderList.type = @"待发货";
    }else if (btn.tag == 3){
        orderList.type = @"待收货";
    }
    [self.navigationController pushViewController:orderList animated:YES];
}

- (IBAction)btnClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    if (btn.tag == 11) {
        FYMyCardViewController * card = [[FYMyCardViewController alloc]init];
        [self.navigationController pushViewController:card animated:YES];
    }else if (btn.tag == 12){
        FYWithDrawViewController * withdraw = [[FYWithDrawViewController alloc]init];
        withdraw.balance = self.balance;
        [self.navigationController pushViewController:withdraw animated:YES];
    }else if (btn.tag == 13){
        FYInformationViewController * infor = [[FYInformationViewController alloc]init];
        [self.navigationController pushViewController:infor animated:YES];
    }else if (btn.tag == 14){
        FYAddressListViewController * address = [[FYAddressListViewController alloc]init];
        address.isfromOrder = NO;
        [self.navigationController pushViewController:address animated:YES];
    }else if (btn.tag == 15){
        FYSetupViewController * setup = [[FYSetupViewController alloc]init];
        [self.navigationController pushViewController:setup animated:YES];
    }
}
@end
