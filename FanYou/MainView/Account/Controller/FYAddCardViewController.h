//
//  FYAddCardViewController.h
//  FanYou
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYAddCardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *NameTF;

@property (weak, nonatomic) IBOutlet UITextField *NumTF;

- (IBAction)add:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end
