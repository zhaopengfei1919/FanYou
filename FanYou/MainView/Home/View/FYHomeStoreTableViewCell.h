//
//  FYHomeStoreTableViewCell.h
//  FanYou
//
//  Created by apple on 2018/6/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYHomeStoreModel.h"

@interface FYHomeStoreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *LogoImage;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *DescLabel;


@property (strong,nonatomic) FYHomeStoreModel * model;
@end
