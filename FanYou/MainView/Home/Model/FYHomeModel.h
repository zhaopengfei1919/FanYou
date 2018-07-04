//
//  FYHomeModel.h
//  FanYou
//
//  Created by apple on 2018/6/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYHomeModel : NSObject

@property (strong ,nonatomic) NSNumber *goods_id;//商品ID
@property (nonatomic, copy) NSString *goods_name;//名称
@property (nonatomic, copy) NSString *goods_desc;//介绍
@property (nonatomic, copy) NSString *goods_price;//价格
@property (nonatomic, copy) NSString *goods_icon;//图片
@property (strong ,nonatomic) NSNumber *shop_id;//店铺ID
@property (nonatomic, copy) NSString * shop_name;//店铺名称
@property (strong ,nonatomic) NSNumber *is_seven;//是否7天可退换
@property (strong ,nonatomic) NSNumber *is_hot;//是否为热销商品

@end
