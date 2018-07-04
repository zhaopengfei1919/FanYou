//
//  FYHomeStoreModel.h
//  FanYou
//
//  Created by apple on 2018/6/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYHomeStoreModel : NSObject

@property (strong ,nonatomic) NSNumber *shop_id;
@property (nonatomic, copy) NSString *shop_name;
@property (nonatomic, copy) NSString *desc;
@property (strong ,nonatomic) NSNumber *is_mine;
@property (strong ,nonatomic) NSNumber *is_hot;
@property (nonatomic, copy) NSString * shop_logo;
@end
