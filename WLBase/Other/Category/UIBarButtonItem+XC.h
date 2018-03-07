//
//  CUIBarButtonItem+XC.h
//  CommunityService
//
//  Created by zhangmm on 15/5/11.
//  Copyright (c) 2015年 movitech. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XC)
/**
 *  通过图片创建item
 *
 *  @param image     图片
 *  @param highImage 高亮图片
 *  @param action    点击后调用的方法
 */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
