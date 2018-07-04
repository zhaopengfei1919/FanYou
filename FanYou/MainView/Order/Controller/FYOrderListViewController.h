//
//  FYOrderListViewController.h
//  FanYou
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYOrderListViewController : UIViewController{
    NSInteger page_number;
}

@property (nonatomic, strong) NSMutableArray *dataSourse;
@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) UIButton * rememberBtn;
@property (strong,nonatomic) UIView * line;

@property (strong,nonatomic) NSString * type;

@end
