//
//  MBProgressHUD+_WL.h
//  WLBase
//
//  Created by 雷王 on 17/3/1.
//  Copyright © 2017年 WL. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (_WL)
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

+ (void)showWithMessage:(NSString *)message;


@end
