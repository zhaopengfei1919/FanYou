//
//  FYAddOrderViewController.h
//  FanYou
//
//  Created by apple on 2018/6/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYHomeModel.h"

@interface FYAddOrderViewController : UIViewController

@property (strong,nonatomic) NSNumber * goods_id;
@property (strong,nonatomic) UITableView * table;
@property (strong,nonatomic) FYHomeModel * model;

@property (strong,nonatomic) UILabel * priceLabel;
@end
