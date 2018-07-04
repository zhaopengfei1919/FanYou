//
//  FYOrderFooterView.m
//  FanYou
//
//  Created by apple on 2018/6/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FYOrderFooterView.h"

@implementation FYOrderFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)isNiming:(id)sender {
    _isniming = !_isniming;
    if (_isniming) {
        [self.NimingBtn setImage:[UIImage imageNamed:@"开关-开-"] forState:0];
    }else
        [self.NimingBtn setImage:[UIImage imageNamed:@"开关-关-"] forState:0];
}
@end
