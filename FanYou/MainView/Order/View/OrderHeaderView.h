//
//  OrderHeaderView.h
//  FanYou
//
//  Created by apple on 2018/6/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYAddressModel.h"

@interface OrderHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PhoneLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *AreaLabelHeight;
@property (weak, nonatomic) IBOutlet UILabel *AreaLabel;
@property (weak, nonatomic) IBOutlet UIButton *AddressBtn;
- (IBAction)chosenAddress:(id)sender;


@property (strong,nonatomic) FYAddressModel * model;
@end
