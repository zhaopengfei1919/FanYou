//
//  AddressTableViewCell1.h
//  FanYou
//
//  Created by apple on 2018/6/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYAddressModel.h"

@interface AddressTableViewCell1 : UITableViewCell

@property (strong,nonatomic) FYAddressModel * model;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;

@end
