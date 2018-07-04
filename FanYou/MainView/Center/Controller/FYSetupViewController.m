//
//  FYSetupViewController.m
//  FanYou
//
//  Created by apple on 2018/6/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYSetupViewController.h"
#import "EGOCache.h"

@interface FYSetupViewController ()

@end

@implementation FYSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统设置";
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x8dd6fd).CGColor, (__bridge id)UIColorFromRGB(0x5bc1fc).CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH - 24, 37);
    [self.SignOutBtn.layer addSublayer:gradientLayer];
    
    NSMutableData *data = [[EGOCache currentCache] getCacheData];
    float mmm = data.length/(1024.0*1024.0);
    self.HuanCunLabel.text = [NSString stringWithFormat:@"%.2fM",mmm];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)clearHuancun:(id)sender {
    self.HuanCunLabel.text = @"0.00M";
    [[EGOCache currentCache] clearCache];
}

- (void)clearCacheSuccess{
    NSLog(@"清理成功");
}

- (IBAction)About:(id)sender {
}

- (IBAction)SignOut:(id)sender {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:UserInfo];
    [defaults setObject:@"" forKey:UserID];
    [defaults setObject:@"" forKey:@"sign"];
    [defaults synchronize];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
