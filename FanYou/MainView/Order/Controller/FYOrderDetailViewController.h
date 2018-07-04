//
//  FYOrderDetailViewController.h
//  FanYou
//
//  Created by apple on 2018/7/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYOrderDetailModel.h"

@interface FYOrderDetailViewController : UIViewController

@property (strong ,nonatomic) NSNumber * order_id;
@property (strong,nonatomic) FYOrderDetailModel * model;

@property (weak, nonatomic) IBOutlet UIView *BackView;

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *AreaLabel;

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (weak, nonatomic) IBOutlet UILabel *GoodPrice;
@property (weak, nonatomic) IBOutlet UILabel *Yunfei;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;


@property (weak, nonatomic) IBOutlet UILabel *Label1;
@property (weak, nonatomic) IBOutlet UILabel *Label2;
@property (weak, nonatomic) IBOutlet UILabel *Label3;
@property (weak, nonatomic) IBOutlet UILabel *Label4;
@property (weak, nonatomic) IBOutlet UILabel *Label5;

@property (weak, nonatomic) IBOutlet UIButton *Btn1;
@property (weak, nonatomic) IBOutlet UIButton *Btn2;

@end
