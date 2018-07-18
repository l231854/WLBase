//
//  HomeBannerModel.h
//  WLBase
//
//  Created by 雷王 on 2018/6/2.
//  Copyright © 2018年 WL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeBannerModel : NSObject
@property (nonatomic,strong) NSString *headImageUrl;
//：情景ID
@property (nonatomic,strong) NSString *processId;
//情景状态
@property (nonatomic,strong) NSString *status;
//情景显示名称
@property (nonatomic,strong) NSString *title;
//情景模式
@property (nonatomic,strong) NSString *mode;
@end
