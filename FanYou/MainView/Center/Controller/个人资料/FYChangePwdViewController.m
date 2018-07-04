//
//  FYChangePwdViewController.m
//  FanYou
//
//  Created by apple on 2018/6/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYChangePwdViewController.h"

@interface FYChangePwdViewController ()<UITextFieldDelegate>

@end

@implementation FYChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码修改";
    self.view.backgroundColor = UIColorFromRGB(0xeef1f2);
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 88)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(12, 14, 70, 16)];
    label1.textColor = UIColorFromRGB(0x333333);
    label1.font = [UIFont systemFontOfSize:15];
    label1.text = @"原始密码";
    [view addSubview:label1];
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(12, 58, 70, 16)];
    label2.textColor = UIColorFromRGB(0x333333);
    label2.font = [UIFont systemFontOfSize:15];
    label2.text = @"新密码";
    [view addSubview:label2];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(12, 44, SCREEN_WIDTH - 12, 0.5)];
    line.backgroundColor = UIColorFromRGB(0xdddddd);
    [view addSubview:line];
    
    self.oldTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 7, SCREEN_WIDTH - 122, 30)];
    self.oldTF.borderStyle = UITextBorderStyleNone;
    self.oldTF.placeholder = @"请输入原始密码";
    self.oldTF.delegate = self;
    self.oldTF.textColor = UIColorFromRGB(0x333333);
    self.oldTF.font = [UIFont systemFontOfSize:15];
    self.oldTF.textAlignment = NSTextAlignmentRight;
    self.oldTF.secureTextEntry = YES;
    [view addSubview:self.oldTF];
    
    self.NewTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 51, SCREEN_WIDTH - 122, 30)];
    self.NewTF.borderStyle = UITextBorderStyleNone;
    self.NewTF.placeholder = @"请输入新密码";
    self.NewTF.delegate = self;
    self.NewTF.textColor = UIColorFromRGB(0x333333);
    self.NewTF.font = [UIFont systemFontOfSize:15];
    self.NewTF.textAlignment = NSTextAlignmentRight;
    [view addSubview:self.NewTF];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 50, 22);
    [backButton setTitleColor:UIColorFromRGB(0xf82f4b) forState:0];
    backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [backButton addTarget:self action:@selector(surechange) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"保存" forState:0];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.rightBarButtonItem = backItem;
    // Do any additional setup after loading the view.
}
-(void)surechange{
    if (self.oldTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"原始密码不能为空"];
        return;
    }
    if (self.NewTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"新密码不能为空"];
        return;
    }
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    [paraDic setObject:self.oldTF.text forKey:@"origin_pwd"];
    [paraDic setObject:self.NewTF.text forKey:@"new_pwd"];
    
    [NetWorkManager requestWithMethod:POST Url:UpdatePwd Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功，请重新登录！"];
            
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:nil forKey:UserInfo];
            [defaults setObject:@"" forKey:UserID];
            [defaults setObject:@"" forKey:@"sign"];
            [defaults synchronize];
            
            [weakself.navigationController popToRootViewControllerAnimated:YES];
        }else
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];

    } requestRrror:^(id requestRrror) {
        
    }];
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
    [self.oldTF resignFirstResponder];
    [self.NewTF resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
