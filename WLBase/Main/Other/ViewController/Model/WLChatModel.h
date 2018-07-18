//
//  WLChatModel.h
//  WLBase
//
//  Created by 雷王 on 2018/6/10.
//  Copyright © 2018年 WL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLChatModel : NSObject
//角色1=自己 2=机器人
@property (nonatomic,copy) NSString *role;
//头像
@property (nonatomic,copy) NSString *headImage;
//内容
@property (nonatomic,copy) NSString *content;

@end
