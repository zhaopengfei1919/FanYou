//
//  FYLoginViewController.h
//  FanYou
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYLoginViewController : UIViewController
- (IBAction)returnHome:(id)sender;
- (IBAction)gotoregsite:(id)sender;
- (IBAction)login:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *PwdTF;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonTop;

- (IBAction)isSecure:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SecureBtn;


@end
