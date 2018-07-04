//
//  FYStoreListViewController.h
//  FanYou
//
//  Created by apple on 2018/6/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYStoreListViewController : UIViewController{
    NSInteger page_number;
}

@property (nonatomic, strong) NSMutableArray *dataSourse;
@property (strong, nonatomic) UITableView *table;

@end
