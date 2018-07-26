//
//  WLHelpDish2Model.h
//  WLBase
//
//  Created by 雷王 on 2018/7/22.
//  Copyright © 2018年 WL. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    WLSignTypeRecommend,
    WLSignTypeHot,
    WLSignTypeDiscount,
    WLSignTypeNew,
} WLSignType;

typedef enum {
    WLSignTypeOfRightHot,
    WLSignTypeOfRightNew,
} WLSignTypeOfRight;
@interface WLHelpDish2Model : NSObject
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *Sign;
@property (nonatomic,copy) NSString *SignOfRight;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *strText;
//已经卖的
@property (nonatomic,copy) NSString *salesNumber;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *Oldprice;
//剩余数量
@property (nonatomic,copy) NSString *remainingNmuber;
//是否选中
@property (nonatomic,copy) NSString *SelectNumber;

@end
