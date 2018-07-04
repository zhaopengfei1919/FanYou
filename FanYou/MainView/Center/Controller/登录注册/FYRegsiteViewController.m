//
//  FYRegsiteViewController.m
//  FanYou
//
//  Created by apple on 2018/6/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYRegsiteViewController.h"
#import "XWCountryCodeController.h"

@interface FYRegsiteViewController ()<UITextViewDelegate,UITextFieldDelegate>

@end

@implementation FYRegsiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupUI{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x8dd6fd).CGColor, (__bridge id)UIColorFromRGB(0x5bc1fc).CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH-24, 37);
    [self.registeBtn.layer addSublayer:gradientLayer];
    if ([self.titleStr isEqualToString:@"忘记密码"]) {
        [self.registeBtn setTitle:@"设置密码" forState:0];
    }
    self.registeBtn.layer.cornerRadius = 4;
    
    NSMutableAttributedString * aString = [[NSMutableAttributedString alloc] initWithString:@"遇到问题？联系客服"];
    [aString addAttribute:NSLinkAttributeName
                             value:@"fanyou://"
                             range:NSMakeRange(5,aString.length - 5)];
    [aString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x666666) range:NSMakeRange(0,5)];
    [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12]range:NSMakeRange(0, 5)];
    [aString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x1ba3f2) range:NSMakeRange(5,aString.length - 5)];
    [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12]range:NSMakeRange(5, aString.length - 5)];
    [aString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(5, aString.length - 5)];

    self.textview.attributedText = aString;
    self.textview.delegate=self;
    self.textview.editable=NO;
    self.textview.selectable=YES;
    
    self.PhoneView.layer.borderWidth = 0.5;
    self.PhoneView.layer.borderColor =UIColorFromRGB(0xdddddd).CGColor;
    self.CodeView.layer.borderWidth = 0.5;
    self.CodeView.layer.borderColor =UIColorFromRGB(0xdddddd).CGColor;
    self.CodeBtn.layer.borderWidth = 0.5;
    self.CodeBtn.layer.borderColor =UIColorFromRGB(0xdddddd).CGColor;
    self.PwView.layer.borderWidth = 0.5;
    self.PwView.layer.borderColor =UIColorFromRGB(0xdddddd).CGColor;
}
- (BOOL)textView:(UITextView*)textView shouldInteractWithURL:(NSURL*)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"fanyou"]) {
        NSLog(@"点击响应---------------");
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneTF resignFirstResponder];
    [self.PwdTf resignFirstResponder];
    [self.CodeTF resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)chosenCountry:(id)sender {
    XWCountryCodeController *CountryCodeVC = [[XWCountryCodeController alloc] init];
    //CountryCodeVC.deleagete = self;
    //block
    [CountryCodeVC toReturnCountryCode:^(NSString *countryCodeStr) {
        //在此处实现最终选择后的界面处理
        NSRange range = [countryCodeStr rangeOfString:@"+"];
        NSString * str = [countryCodeStr substringFromIndex:range.location];
        [self.CountryLabel setText:str];
    }];
    [self presentViewController:CountryCodeVC animated:YES completion:nil];
}
//获取验证码点击事件
- (IBAction)Code:(id)sender {
    if ([self.phoneTF.text length] != 11 || ![[FYUser userInfo] isphonenumberwoth:self.phoneTF.text]){
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:self.phoneTF.text forKey:@"mobile"];
    
    
    
    [NetWorkManager requestWithMethod:POST Url:Sendcode Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            NSDictionary * result = [responseObject objectForKey:@"result"];
            self.sign = [result objectForKey:@"sign"];
            [SVProgressHUD showSuccessWithStatus:@"验证码发送成功"];
            weakself.CodeBtn.layer.borderColor =UIColorFromRGB(0xf82f4b).CGColor;
            
            weakself.daojishu = 60;
            weakself.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daoshu) userInfo:nil repeats:YES];
            [weakself.timer fire];
            weakself.CodeBtn.userInteractionEnabled = NO;
        }else
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
    } requestRrror:^(id requestRrror) {
        
    }];
}
- (void)daoshu
{
    self.daojishu --;
    
    if (self.daojishu == 0) {
        self.CodeBtn.layer.borderColor =UIColorFromRGB(0xdddddd).CGColor;
        [self.CodeBtn setTitle:@"获取验证码" forState:0];
        self.CodeBtn.userInteractionEnabled = YES;
        [self.timer invalidate];
        self.timer = nil;
    }else{
        [self.CodeBtn setTitle:[NSString stringWithFormat:@"%dS",self.daojishu] forState:0];
    }
}
//切换密码输入框可见不可见状态
- (IBAction)isSecure:(id)sender {
    static BOOL issecure = NO;
    self.PwdTf.secureTextEntry = issecure;
    issecure = !issecure;
    if (issecure) {
        [self.SecureBtn setImage:[UIImage imageNamed:@"密码不可见"] forState:0];
    }else
        [self.SecureBtn setImage:[UIImage imageNamed:@"密码可见icon"] forState:0];
}
- (IBAction)registe:(id)sender {
    if ([self.phoneTF.text length] != 11 || ![[FYUser userInfo] isphonenumberwoth:self.phoneTF.text]){
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    if ([self.CodeTF.text length] == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if ([self.PwdTf.text length] == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:self.phoneTF.text forKey:@"mobile"];
    [paraDic setObject:self.CodeTF.text forKey:@"code"];
    [paraDic setObject:self.PwdTf.text forKey:@"pwd"];
//    [paraDic setObject:self.sign forKey:@"sign"];
    NSString * strURL;
    if ([self.titleStr isEqualToString:@"忘记密码"]) {
        strURL = Findpwd;
    }else
        strURL = Register;
    [NetWorkManager requestWithMethod:POST Url:strURL Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            if ([self.titleStr isEqualToString:@"忘记密码"]) {
                [SVProgressHUD showSuccessWithStatus:@"重置密码成功"];
            }else
                [SVProgressHUD showSuccessWithStatus:@"注册成功"];
        }else
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
        [weakself.navigationController popViewControllerAnimated:YES];
    } requestRrror:^(id requestRrror) {
        
    }];
}
@end
