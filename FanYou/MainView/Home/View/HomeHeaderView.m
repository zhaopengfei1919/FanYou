//
//  HomeHeaderView.m
//  FanYou
//
//  Created by apple on 2018/6/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "HomeHeaderView.h"

@implementation HomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    [self setUI];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:140/255.0 green:214/255.0 blue:253/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:92/255.0 green:193/255.0 blue:252/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.bounds;
    [self.backImage.layer addSublayer:gradientLayer];
    
    self.ViewTop.constant = StatusHeight;
}
-(void)setUI{
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH/2+StatusHeight))];
    image.backgroundColor = UIColorFromRGB(0xf3f3f3);
    [self addSubview:image];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor];
    gradientLayer.locations = @[@0.2, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = image.frame;
    [image.layer addSublayer:gradientLayer];
    
    UIButton * center = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:center];
    center.backgroundColor = f3f5f7;
    [center mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(StatusHeight+10);
        make.left.offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UIButton * search = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:search];
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(center.mas_top);
        make.left.equalTo(center.mas_right).offset(10);
        make.right.offset(-10);
        make.height.offset(20);
    }];
    
    
    

    
    
}

- (IBAction)btnClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(homeheaderviewClick:)]) {
        [self.delegate homeheaderviewClick:btn.tag];
    }
}
@end
