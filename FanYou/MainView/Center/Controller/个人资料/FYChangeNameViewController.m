//
//  FYChangeNameViewController.m
//  FanYou
//
//  Created by apple on 2018/6/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYChangeNameViewController.h"

@interface FYChangeNameViewController ()<UITextFieldDelegate>

@end

@implementation FYChangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑昵称";
    self.view.backgroundColor = UIColorFromRGB(0xeef1f2);
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 44)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    self.nameTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 7, SCREEN_WIDTH - 20, 30)];
    self.nameTF.borderStyle = UITextBorderStyleNone;
    self.nameTF.placeholder = @"";
    self.nameTF.textColor = UIColorFromRGB(0x333333);
    self.nameTF.font = [UIFont systemFontOfSize:15];
    if (self.nickname.length >0 ) {
        self.nameTF.placeholder = self.nickname;
    }else
        self.nameTF.placeholder = @"请输入您的昵称";
    
    [view addSubview:self.nameTF];
    
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
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入新昵称"];
        return;
    }
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    [paraDic setObject:self.nameTF.text forKey:@"nickname"];
    
    [NetWorkManager requestWithMethod:POST Url:SetnickName Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"修改昵称成功"];
            [weakself.navigationController popViewControllerAnimated:YES];
        }else
            [SVProgressHUD showErrorWithStatus:[responseObject safeObjectForKey:@"errmsg"]];
    } requestRrror:^(id requestRrror) {
        
    }];
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

@end
