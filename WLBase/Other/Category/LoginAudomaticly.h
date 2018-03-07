//
//  LoginAudomaticly.h
//  CommunityService
//
//  Created by zhangmm on 15/4/15.
//  Copyright (c) 2015年 movitech. All rights reserved.
// 自动登录

#import <Foundation/Foundation.h>

@interface LoginAudomaticly : NSObject
/**
 *  静默登录, 如果成功，更新积分token，如果失败，不做任何处理
 *
 *  @param userName 用户名（电话）
 *  @param pwd      密码
 */
+(void)loginAudomaticlyWithUserName:(NSString*)userName password:(NSString *)pwd;

/**
 *  静默登录, 如果成功，更新积分token，如果失败，自动跳转到登录页面，进行手动登录（一般情况下，使用该方法）
 *
 *  @param userName   用户名（电话）
 *  @param pwd        密码
 *  @param controller 当前的控制器
 */
+(void)loginAudomaticlyWithUserName:(NSString*)userName password:(NSString *)pwd controller:(UIViewController *)controller;
@end
