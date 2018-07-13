//
//  FYCertificationViewController.m
//  FanYou
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYCertificationViewController.h"

@interface FYCertificationViewController ()<UITextFieldDelegate>

@end

@implementation FYCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名验证";
    self.view.backgroundColor = UIColorFromRGB(0xeef1f2);
    
    [self setUI];
    // Do any additional setup after loading the view.
}
-(void)setUI{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 88)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(12, 14, 70, 16)];
    label1.textColor = UIColorFromRGB(0x333333);
    label1.font = [UIFont systemFontOfSize:15];
    label1.text = @"真实姓名";
    [view addSubview:label1];
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(12, 58, 70, 16)];
    label2.textColor = UIColorFromRGB(0x333333);
    label2.font = [UIFont systemFontOfSize:15];
    label2.text = @"身份证号";
    [view addSubview:label2];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(12, 44, SCREEN_WIDTH - 12, 0.5)];
    line.backgroundColor = UIColorFromRGB(0xdddddd);
    [view addSubview:line];
    
    self.NameTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 7, SCREEN_WIDTH - 122, 30)];
    self.NameTF.borderStyle = UITextBorderStyleNone;
    self.NameTF.placeholder = @"请输入真实姓名";
    self.NameTF.delegate = self;
    self.NameTF.textColor = UIColorFromRGB(0x333333);
    self.NameTF.font = [UIFont systemFontOfSize:15];
    self.NameTF.textAlignment = NSTextAlignmentRight;
    [view addSubview:self.NameTF];
    
    self.NumTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 51, SCREEN_WIDTH - 122, 30)];
    self.NumTF.borderStyle = UITextBorderStyleNone;
    self.NumTF.placeholder = @"请输入身份证号";
    self.NumTF.delegate = self;
    self.NumTF.textColor = UIColorFromRGB(0x333333);
    self.NumTF.font = [UIFont systemFontOfSize:15];
    self.NumTF.textAlignment = NSTextAlignmentRight;
    [view addSubview:self.NumTF];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 50, 22);
    [backButton setTitleColor:UIColorFromRGB(0xf82f4b) forState:0];
    backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [backButton addTarget:self action:@selector(surechange) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"保存" forState:0];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.rightBarButtonItem = backItem;
}
-(void)surechange{
    if (self.NameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"真实姓名不能为空"];
        return;
    }
    if (self.NumTF.text.length != 18 && self.NumTF.text.length != 15) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的身份证号"];
        return;
    }
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    [paraDic setObject:self.NameTF.text forKey:@"real_name"];
    [paraDic setObject:self.NumTF.text forKey:@"card_no"];
    
    [NetWorkManager requestWithMethod:POST Url:VerifyIdCard Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
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
    [self.NameTF resignFirstResponder];
    [self.NumTF resignFirstResponder];
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
