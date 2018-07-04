//
//  HomeHeaderView.h
//  FanYou
//
//  Created by apple on 2018/6/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol homeHeaderViewDelegate <NSObject>

-(void)homeheaderviewClick:(NSInteger)btntag;

@end
@interface HomeHeaderView : UIView

@property (weak,nonatomic) id<homeHeaderViewDelegate>delegate;

@property (strong,nonatomic) UIImageView * headImage;
@property (strong,nonatomic) UILabel * nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewTop;

- (IBAction)btnClick:(id)sender;

@property (weak, nonatomic) IBOutlet SDCycleScrollView *AdScroll;
@property (weak, nonatomic) IBOutlet UIButton *headerBtn;
@property (weak, nonatomic) IBOutlet UILabel *tishiLabel;


@end
