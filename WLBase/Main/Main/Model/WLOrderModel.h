//
//  WLOrderModel.h
//  WLBase
//
//  Created by 雷王 on 2018/7/23.
//  Copyright © 2018年 WL. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WLOrderModel;
@interface WLOrderModel : NSObject
@property (nonatomic,copy) NSString *shopName;
@property (nonatomic,strong) WLOrderModel *order;
//茶位费
@property (nonatomic,copy) NSString *price;
//商品合计
@property (nonatomic,copy) NSString *goodPrice;
//订单合计
@property (nonatomic,copy) NSString *orderPrice;
//类型
@property (nonatomic,copy) NSString *type;
//订单号
@property (nonatomic,copy) NSString *orderNumber;
//下单时间
@property (nonatomic,copy) NSString *orderTime;
//桌台
@property (nonatomic,copy) NSString *orderLocated;
//支付状态
@property (nonatomic,copy) NSString *orderStatus;
//人数
@property (nonatomic,copy) NSString *peopleNumber;
@end
