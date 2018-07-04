//
//  FYOrderListModel.h
//  FanYou
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYOrderListModel : NSObject

@property (strong ,nonatomic) NSNumber *order_id;//订单ID
@property (nonatomic, copy) NSString *order_status;//订单状态
@property (strong ,nonatomic) NSNumber *goods_id;//商品id
@property (nonatomic, copy) NSString *goods_name;//商品名称
@property (nonatomic, copy) NSString * goods_icon;//商品icon
@property (nonatomic, copy) NSString *shop_name;//店铺名称
@property (nonatomic, copy) NSString *goods_price;//价格
@property (strong ,nonatomic) NSNumber *is_seven;//是否7天可退换
@property (strong ,nonatomic) NSNumber *total_price;//订单金额
@property (strong ,nonatomic) NSNumber *goods_count;//商品数量
@property (strong ,nonatomic) NSNumber *express_fee;//快递费
@property (strong ,nonatomic) NSNumber * hint_deliver;//是否已提醒发货

@end
