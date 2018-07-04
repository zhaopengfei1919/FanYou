//
//  FYLoginViewController.m
//  FanYou
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYLoginViewController.h"
#import "FYRegsiteViewController.h"

@interface FYLoginViewController ()<UITextFieldDelegate>

@end

@implementation FYLoginViewController
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
//    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x8dd6fd).CGColor, (__bridge id)UIColorFromRGB(0x5bc1fc).CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH-24, 37);
    [self.loginBtn.layer addSublayer:gradientLayer];
    self.loginBtn.layer.cornerRadius = 4;
    
    
    self.buttonTop.constant = 14 + StatusHeight;
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneTF) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneTF resignFirstResponder];
    [self.PwdTF resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)returnHome:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)gotoregsite:(id)sender {
    UIButton * btn = (UIButton *)sender;
    FYRegsiteViewController * regsite = [[FYRegsiteViewController alloc]init];
    if (btn.tag == 1) {
        regsite.titleStr = @"手机快速注册";
    }else
        regsite.titleStr = @"忘记密码";
    [self.navigationController pushViewController:regsite animated:YES];
}

- (IBAction)login:(id)sender {
    if ([self.phoneTF.text length] != 11 || ![[FYUser userInfo] isphonenumberwoth:self.phoneTF.text]){
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    if ([self.PwdTF.text length] == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:self.phoneTF.text forKey:@"mobile"];
    [paraDic setObject:self.PwdTF.text forKey:@"pwd"];

    [NetWorkManager requestWithMethod:POST Url:Login Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary * result = [responseObject objectForKey:@"result"];
            [defaults setObject:result forKey:@"UserInfo"];
            [defaults setObject:[NSString stringWithFormat:@"%@",[result objectForKey:@"id"]] forKey:@"UserID"];
            [defaults setObject:[result objectForKey:@"sign"] forKey:@"sign"];
            [defaults synchronize];
            
            [weakself.navigationController popViewControllerAnimated:YES];
        }else
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
    } requestRrror:^(id requestRrror) {
        
    }];
}
//切换密码输入框可见不可见状态
- (IBAction)isSecure:(id)sender {
    static BOOL issecure = NO;
    self.PwdTF.secureTextEntry = issecure;
    issecure = !issecure;
    if (issecure) {
        [self.SecureBtn setImage:[UIImage imageNamed:@"密码不可见"] forState:0];
    }else
        [self.SecureBtn setImage:[UIImage imageNamed:@"密码可见icon"] forState:0];
}
@end
