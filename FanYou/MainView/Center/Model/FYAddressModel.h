//
//  FYAddressModel.h
//  FanYou
//
//  Created by apple on 2018/6/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYAddressModel : NSObject
@property (strong ,nonatomic) NSNumber * addr_id;
@property (strong,nonatomic) NSString * acc_name;//收货人姓名
@property (strong,nonatomic) NSString * acc_mobile;//收货人手机号
@property (strong,nonatomic) NSString * prov;//省
@property (strong,nonatomic) NSString * city;//市
@property (strong,nonatomic) NSString * country;//区
@property (strong,nonatomic) NSString * addr;//收货人姓名
@property (assign) int is_default;//是否默认

@end
