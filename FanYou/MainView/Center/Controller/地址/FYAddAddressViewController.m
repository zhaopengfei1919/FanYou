//
//  FYAddAddressViewController.m
//  FanYou
//
//  Created by apple on 2018/6/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYAddAddressViewController.h"
#import "HZCityViewController.h"

@interface FYAddAddressViewController ()

@end

@implementation FYAddAddressViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![self.province isEqualToString:@""]) {
        self.CityLabel.text = [NSString stringWithFormat:@"%@ %@ %@",self.province,self.city,self.area];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    ismoren = YES;
    if (_isedit) {
        self.title = @"编辑收货地址";
        self.deliveryId = self.model.addr_id;
        self.province = self.model.prov;
        self.city = self.model.city;
        self.area = self.model.country;
        if (self.model.is_default == 1) {
            ismoren = YES;
        }else{
            ismoren = NO;
            [self.morenBtn setImage:[UIImage imageNamed:@"开关-关-"] forState:0];
        }
        self.nameTF.text = self.model.acc_name;
        self.PhoneTF.text = self.model.acc_mobile;
        self.AreaTextView.text = self.model.addr;
    }else{
        self.title = @"新增收货地址";
        self.province = @"";
        self.city = @"";
        self.area = @"";
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x8dd6fd).CGColor, (__bridge id)UIColorFromRGB(0x5bc1fc).CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH - 24, 37);
    [self.sureBtn.layer addSublayer:gradientLayer];
    
    self.AreaTextView.placeholder = @"请输入详细地址信息，如道路、门牌号、小区、楼栋号、单元室等";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameTF resignFirstResponder];
    [self.PhoneTF resignFirstResponder];
    [self.AreaTextView resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)chosenCity:(id)sender {
    HZCityViewController * city = [[HZCityViewController alloc]init];
    [self.navigationController pushViewController:city animated:YES];
}

- (IBAction)ismoren:(id)sender {
    ismoren = !ismoren;
    if (ismoren) {
        [self.morenBtn setImage:[UIImage imageNamed:@"开关-开-"] forState:0];
    }else
        [self.morenBtn setImage:[UIImage imageNamed:@"开关-关-"] forState:0];
}

- (IBAction)sure:(id)sender {
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入联系人姓名"];
        return;
    }
    if (![[FYUser userInfo] isphonenumberwoth:self.PhoneTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    if (self.AreaTextView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入详细地址"];
        return;
    }
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    if (_isedit) {
        [paraDic setObject:self.deliveryId forKey:@"addr_id"];
    }
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    [paraDic setObject:self.nameTF.text forKey:@"acc_name"];
    [paraDic setObject:self.PhoneTF.text forKey:@"acc_mobile"];
    [paraDic setObject:self.province forKey:@"prov"];
    [paraDic setObject:self.city forKey:@"city"];
    [paraDic setObject:self.area forKey:@"country"];
    [paraDic setObject:self.AreaTextView.text forKey:@"addr"];
    [paraDic setObject:[NSNumber numberWithBool:ismoren] forKey:@"is_default"];
    
    [NetWorkManager requestWithMethod:POST Url:AddrUpsert Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@成功",self.title]];
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
        }
    } requestRrror:^(id requestRrror) {
        
    }];
}
@end
