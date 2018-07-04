//
//  FYHomeTableViewCell.h
//  FanYou
//
//  Created by apple on 2018/6/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYHomeModel.h"

@interface FYHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *BuyBtn;

@property (strong,nonatomic) FYHomeModel * Model;

@end
