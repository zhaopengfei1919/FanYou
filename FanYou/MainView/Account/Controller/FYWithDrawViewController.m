//
//  FYWithDrawViewController.m
//  FanYou
//
//  Created by apple on 2018/6/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYWithDrawViewController.h"

@interface FYWithDrawViewController ()<UITextFieldDelegate>

@end

@implementation FYWithDrawViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额提现";
    
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
}

- (IBAction)withdraw:(id)sender {
}
@end
