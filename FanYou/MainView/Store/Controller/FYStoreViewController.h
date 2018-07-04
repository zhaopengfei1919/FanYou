//
//  FYStoreViewController.h
//  FanYou
//
//  Created by apple on 2018/6/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYHomeStoreModel.h"

@interface FYStoreViewController : UIViewController{
    NSInteger page_number;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *BackImage;
@property (weak, nonatomic) IBOutlet UIImageView *HeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *DescTextView;

- (IBAction)returnHome:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *AddViewHeight;
@property (weak, nonatomic) IBOutlet UIView *UploadView;
- (IBAction)UploadGoods:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *AddView;
- (IBAction)AddGoods:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (strong,nonatomic) NSMutableArray * dataSourse;

@property (weak, nonatomic) IBOutlet UIView *NoShopView;
@property (weak, nonatomic) IBOutlet UIButton *OPenShopBtn;
- (IBAction)openShop:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BackBtnTop;

@property (strong,nonatomic) FYHomeStoreModel * model;

@property(assign) BOOL ismyself;
@property(assign) BOOL NoShop;

@end
