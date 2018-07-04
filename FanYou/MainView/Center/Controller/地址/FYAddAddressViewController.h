//
//  FYAddAddressViewController.h
//  FanYou
//
//  Created by apple on 2018/6/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYAddressModel.h"

@interface FYAddAddressViewController : UIViewController{
    BOOL ismoren;
}
@property (nonatomic, strong) FYAddressModel * model;

@property (nonatomic, strong) NSNumber *deliveryId;
@property (assign) BOOL isedit;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *PhoneTF;

@property (weak, nonatomic) IBOutlet UILabel *CityLabel;
- (IBAction)chosenCity:(id)sender;

- (IBAction)ismoren:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *morenBtn;

@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *AreaTextView;


- (IBAction)sure:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;


@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *area;

@property (nonatomic, strong) NSString *provinceid;
@property (nonatomic, strong) NSString *cityid;
@property (nonatomic, strong) NSString *areaid;
@end
