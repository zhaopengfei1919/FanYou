//
//  Address2TableViewCell.h
//  FanYou
//
//  Created by apple on 2018/6/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYAddressModel.h"

@interface Address2TableViewCell : UITableViewCell

@property (strong,nonatomic) FYAddressModel * model;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;

@property (weak, nonatomic) IBOutlet UIImageView *isMorenImage;
@property (weak, nonatomic) IBOutlet UIButton *setMoren;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;



@end
