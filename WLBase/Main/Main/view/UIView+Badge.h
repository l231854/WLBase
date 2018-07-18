//
//  UIView+Badge.h
//  CommunityService
//
//  Created by 雷王 on 16/8/4.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Badge)

//显示数字
-(void)setBadge:(NSString *)badgeString;
//显示红点
-(void)setRedBadge:(BOOL)flag isInt:(BOOL)isint;

-(void)setBadge:(NSString *)badgeString andColor:(UIColor *)color andTextColor:(UIColor *)textColor andRadius:(CGFloat)r;
//画空心圆
-(void)setBadgeandColor:(UIColor *)color;

@end
