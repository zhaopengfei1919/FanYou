//
//  FYMyCardViewController.h
//  FanYou
//
//  Created by apple on 2018/6/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYMyCardViewController : UIViewController{
    NSInteger page_number;
}

@property (strong,nonatomic) UITableView * table;
@property (strong,nonatomic) NSMutableArray * dataSourse;

@end
