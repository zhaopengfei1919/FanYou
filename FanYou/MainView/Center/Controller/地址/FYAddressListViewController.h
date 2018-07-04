//
//  FYAddressListViewController.h
//  FanYou
//
//  Created by apple on 2018/6/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYAddressModel.h"

typedef void(^chosenAddress)(FYAddressModel * model);

@interface FYAddressListViewController : UIViewController{
    BOOL isedit;
    NSInteger page_number;
}
@property (nonatomic,copy) chosenAddress addressBlock;

@property (strong,nonatomic) UITableView * table;
@property (strong,nonatomic) NSMutableArray * dataSourse;
@property (strong,nonatomic) UIButton *rightButton;

@property (assign) BOOL isfromOrder;
@end
