//
//  FYOrderFooterView.h
//  FanYou
//
//  Created by apple on 2018/6/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYOrderFooterView : UIView
@property (weak, nonatomic) IBOutlet UIButton *jianBtn;
@property (weak, nonatomic) IBOutlet UIButton *jiaBtn;

@property (weak, nonatomic) IBOutlet UILabel *CountLabel;

@property (weak, nonatomic) IBOutlet UILabel *Kuaidi;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;

- (IBAction)isNiming:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *NimingBtn;

@property (strong,nonatomic) NSString * price;
@property (assign) BOOL isniming;
@end
