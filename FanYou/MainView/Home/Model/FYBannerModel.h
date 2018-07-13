//
//  FYBannerModel.h
//  FanYou
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYBannerModel : NSObject
@property (strong ,nonatomic) NSNumber *id;
@property (nonatomic, copy) NSString *img;//
@property (strong ,nonatomic) NSNumber *is_use;//是否可用
@property (nonatomic, copy) NSString *url;//
@end
