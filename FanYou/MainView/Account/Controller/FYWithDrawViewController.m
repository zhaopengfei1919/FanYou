//
//  FYWithDrawViewController.m
//  FanYou
//
//  Created by apple on 2018/6/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYWithDrawViewController.h"
#import "FYMyCardViewController.h"
#import "FYCardModel.h"

@interface FYWithDrawViewController ()<UITextFieldDelegate>
@property (strong,nonatomic) FYCardModel * model;
@end

@implementation FYWithDrawViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)getcard{
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:[FYUser userInfo].userId forKey:@"user_id"];
    [paraDic setObject:[NSNumber numberWithInteger:0] forKey:@"page_number"];
    
    [NetWorkManager requestWithMethod:POST Url:CardList Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            NSArray * array = [FYCardModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"result"][@"items"]];
            if (array.count > 0) {
                weakself.model = array[0];
                [weakself setupUI];
            }else
                self.BankName.text = @"点击选择提现银行卡";
        }else{
            self.BankName.text = @"点击选择提现银行卡";
        }
    } requestRrror:^(id requestRrror) {

    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额提现";
    [self getcard];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x8dd6fd).CGColor, (__bridge id)UIColorFromRGB(0x5bc1fc).CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH-24, 37);
    [self.withdrawBtn.layer addSublayer:gradientLayer];
    
    self.PriceLabel.text = [NSString stringWithFormat:@"可提现金额%.2f",[self.balance floatValue]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeValue:) name:UITextFieldTextDidChangeNotification object:self.PriceTF];
    // Do any additional setup after loading the view from its nib.
}
- (void)textFieldDidChangeValue:(NSNotification *)notification
{
    UITextField *sender = (UITextField *)[notification object];
    NSString *pricetf = sender.text;
    int price = [pricetf intValue];
    int bala = [self.balance intValue];
    if (price > bala) {
        self.TishiLabel.hidden = NO;
    }else
        self.TishiLabel.hidden = YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.PriceTF resignFirstResponder];
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

- (IBAction)ChosenBank:(id)sender {
    WS(weakself);
    FYMyCardViewController * card = [[FYMyCardViewController alloc]init];
    card.ischosen = YES;
    [self.navigationController pushViewController:card animated:YES];
    card.chosen = ^(FYCardModel *model) {
        weakself.model = model;
        [weakself setupUI];
    };
}
-(void)setupUI{
    if ([self.model.bank_name isEqualToString:@"工商银行"]) {
        self.BankImage.image = [UIImage imageNamed:@"工行icon-"];
    }else if ([self.model.bank_name isEqualToString:@"农业银行"]){
        self.BankImage.image = [UIImage imageNamed:@"农行icon-"];
    }else if ([self.model.bank_name isEqualToString:@"招商银行"]){
        self.BankImage.image = [UIImage imageNamed:@"招行icon-"];
    }else{
        [self.BankImage sd_setImageWithURL:[NSURL URLWithString:self.model.back_icon]];
    }
    
    if (self.model.card_type == nil) {
        self.BankName.text = [NSString stringWithFormat:@"%@(%@)",self.model.bank_name,self.model.card_no];
    }else
        self.BankName.text = [NSString stringWithFormat:@"%@%@(%@)",self.model.bank_name,self.model.card_type,self.model.card_no];
}

- (IBAction)withdraw:(id)sender {
    if (self.PriceTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入提现金额"];
        return;
    }
    WS(weakself);
    NSMutableDictionary *paraDic = @{}.mutableCopy;
    [paraDic setObject:self.model.card_id forKey:@"card_id"];
    [paraDic setObject:self.PriceTF.text forKey:@"amount"];
    
    [NetWorkManager requestWithMethod:POST Url:Withdraw Parameters:paraDic success:^(id responseObject) {
        NSString * succeeded = [responseObject objectForKey:@"succeeded"];
        if ([succeeded intValue] == 1) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
        }
    } requestRrror:^(id requestRrror) {
        
    }];
}
@end
