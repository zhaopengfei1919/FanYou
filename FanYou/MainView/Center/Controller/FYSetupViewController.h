//
//  FYSetupViewController.h
//  FanYou
//
//  Created by apple on 2018/6/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYSetupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *HuanCunLabel;
- (IBAction)clearHuancun:(id)sender;

- (IBAction)About:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *AboutLabel;


@property (weak, nonatomic) IBOutlet UIButton *SignOutBtn;
- (IBAction)SignOut:(id)sender;


@end
