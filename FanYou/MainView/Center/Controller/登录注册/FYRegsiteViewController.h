//
//  FYRegsiteViewController.h
//  FanYou
//
//  Created by apple on 2018/6/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYRegsiteViewController : UIViewController

@property (strong,nonatomic) NSString * titleStr;
@property (assign) int daojishu;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString * sign;

- (IBAction)chosenCountry:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *CountryLabel;

@property (weak, nonatomic) IBOutlet UIView *PhoneView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UIView *CodeView;
@property (weak, nonatomic) IBOutlet UITextField *CodeTF;
- (IBAction)Code:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *CodeBtn;

@property (weak, nonatomic) IBOutlet UIView *PwView;
@property (weak, nonatomic) IBOutlet UITextField *PwdTf;

- (IBAction)isSecure:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SecureBtn;

- (IBAction)registe:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *registeBtn;

@property (weak, nonatomic) IBOutlet UITextView *textview;


@end
