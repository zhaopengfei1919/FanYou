//
//  FYOrderTableViewCell.h
//  FanYou
//
//  Created by apple on 2018/6/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYHomeModel.h"

@interface FYOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *GoodsImage;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *SevenImage;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;

@property (strong,nonatomic) FYHomeModel * model;


@end
