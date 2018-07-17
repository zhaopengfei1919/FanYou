//
//  FYCenterViewController.h
//  FanYou
//
//  Created by apple on 2018/6/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYCenterViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopScroll;
@property (weak, nonatomic) IBOutlet UIView *MainView;
@property (weak, nonatomic) IBOutlet UIImageView *BackImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *LevelBtn;
@property (weak, nonatomic) IBOutlet UIImageView *HeadImage;
@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet UILabel *BalanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *Label1;
@property (weak, nonatomic) IBOutlet UILabel *Label2;
@property (weak, nonatomic) IBOutlet UILabel *Label3;



- (IBAction)returnCenter:(id)sender;

- (IBAction)orderClick:(id)sender;

- (IBAction)btnClick:(id)sender;

@property (strong,nonatomic) NSNumber * balance;
@end
