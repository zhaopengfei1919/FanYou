//
//  FYCardModel.h
//  FanYou
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYCardModel : NSObject

@property (strong,nonatomic) NSNumber * card_id;//银行卡id
@property (strong,nonatomic) NSString * bank_name;//银行名称
@property (strong,nonatomic) NSString * card_type;//银行卡类型
@property (strong,nonatomic) NSString * card_no;//银行卡后四位

//暂定参数，以后可能会添加
@property (strong,nonatomic) NSString * card_icon;//银行卡icon
@property (strong,nonatomic) NSString * back_icon;//银行卡背景icon

@end
