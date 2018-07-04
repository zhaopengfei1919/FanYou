//
//  FYCardTableViewCell.h
//  FanYou
//
//  Created by apple on 2018/6/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYCardModel.h"

@interface FYCardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *EmptyView;

@property (weak, nonatomic) IBOutlet UIView *InforView;
@property (weak, nonatomic) IBOutlet UIImageView *BackImage;
@property (weak, nonatomic) IBOutlet UIImageView *BankImage;
@property (weak, nonatomic) IBOutlet UILabel *BankName;
@property (weak, nonatomic) IBOutlet UILabel *CardType;
@property (weak, nonatomic) IBOutlet UILabel *CardNumber;

@property (strong,nonatomic) FYCardModel * model;
@end
