//
//  FYOrderListTableViewCell.h
//  FanYou
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYOrderListModel.h"
#import "FYOrderDetailModel.h"

@interface FYOrderListTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *GoodsImage;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *SevenImage;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *CountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *NameLabelHeight;

@property (strong,nonatomic) FYOrderListModel * model;
@property (strong,nonatomic) FYOrderDetailModel * detailmodel;
@end
