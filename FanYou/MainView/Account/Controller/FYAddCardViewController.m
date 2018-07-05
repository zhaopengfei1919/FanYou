//
//  FYAddCardViewController.m
//  FanYou
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYAddCardViewController.h"

@interface FYAddCardViewController ()

@end

@implementation FYAddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增银行卡";
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x8dd6fd).CGColor, (__bridge id)UIColorFromRGB(0x5bc1fc).CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH-24, 37);
    [self.addBtn.layer addSublayer:gradientLayer];
    // Do any additional setup after loading the view from its nib.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.NameTF resignFirstResponder];
    [self.NumTF resignFirstResponder];
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

- (IBAction)add:(id)sender {
    if (self.NameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的银行名称"];
        return;
    }
    if (self.NumTF.text.length < 5) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的银行卡号"];
        return;
    }
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    [paraDic setObject:self.NameTF.text forKey:@"bank_name"];
    [paraDic setObject:self.NumTF.text forKey:@"card_no"];
    
    self.addBtn.enabled = NO;
    [NetWorkManager requestWithMethod:POST Url:AddCard Parameters:paraDic success:^(id responseObject) {
        self.addBtn.enabled = YES;
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"新增银行卡成功"];
            [weakself.navigationController popViewControllerAnimated:YES];
        }else
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"errmsg"]];
    } requestRrror:^(id requestRrror) {
        
    }];
}
@end
