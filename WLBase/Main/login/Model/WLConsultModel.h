//
//  WLConsultModel.h
//  WLBase
//
//  Created by 雷王 on 2018/7/20.
//  Copyright © 2018年 WL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLConsultModel : NSObject
//文章名字
@property (nonatomic,copy) NSString *name;
//时间
@property (nonatomic,copy) NSString *time;
//图片
@property (nonatomic,copy) NSString *imageUrl;
//文字
@property (nonatomic,copy) NSString *content;


@end
