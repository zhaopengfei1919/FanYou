//
//  FYOrderDetailModel.h
//  FanYou
//
//  Created by apple on 2018/7/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYOrderDetailModel : NSObject

@property (strong ,nonatomic) NSNumber *order_id;//订单ID
@property (strong ,nonatomic) NSNumber *goods_id;//商品ID
@property (nonatomic, copy) NSString *shop_name;//商铺名
@property (nonatomic, copy) NSString *order_status;//订单状态
@property (strong ,nonatomic) NSNumber *order_no;//订单ID
@property (nonatomic, copy) NSString *goods_name;//商品名称
@property (nonatomic, copy) NSString *goods_icon;//商品icon
@property (strong ,nonatomic) NSNumber *goods_price;//商品价格
@property (strong ,nonatomic) NSNumber *goods_count;//商品数量
@property (strong ,nonatomic) NSNumber *is_seven;//是否7天无理由退货
@property (strong ,nonatomic) NSNumber *express_fee;//快递费用
@property (strong ,nonatomic) NSNumber *total_price;//支付金额
@property (nonatomic, copy) NSString *acc_name;//用户名
@property (nonatomic, copy) NSString *acc_mobile;//用户手机号

@property (nonatomic, copy) NSString *acc_addr;//用户地址

@property (nonatomic, copy) NSString *crt_at;//创建时间
@property (nonatomic, copy) NSString *pay_at;//付款时间
@property (nonatomic, copy) NSString *delicer_at;//发货时间
@property (nonatomic, copy) NSString *receive_at;//成交时间


@end
