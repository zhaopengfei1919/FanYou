//
//  HomeHeaderView.m
//  FanYou
//
//  Created by apple on 2018/6/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView() <SDCycleScrollViewDelegate>

@end

@implementation HomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    [self setUI];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x8dd6fd).CGColor, (__bridge id)UIColorFromRGB(0x5bc1fc).CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 197+StatusHeight);
    [self.backImage.layer addSublayer:gradientLayer];
    

    
    self.ViewTop.constant = StatusHeight-20;
}
- (void)setImageUrl:(NSArray *)imageUrl{
    _imageUrl = imageUrl;
    self.AdScroll.imageURLStringsGroup = imageUrl;
    self.AdScroll.delegate = self;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(homeScrollViewClickWith:)]) {
        [self.delegate homeScrollViewClickWith:index];
    }
}

- (IBAction)btnClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(homeheaderviewClick:)]) {
        [self.delegate homeheaderviewClick:btn.tag];
    }
}
@end
