//
//  FYWithDrawViewController.h
//  FanYou
//
//  Created by apple on 2018/6/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYWithDrawViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *BankImage;
@property (weak, nonatomic) IBOutlet UILabel *BankName;
- (IBAction)ChosenBank:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *PriceTF;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *TishiLabel;

- (IBAction)withdraw:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *withdrawBtn;

@property (strong ,nonatomic) NSNumber * balance;

@end
