//
//  MBProgressHUD+_WL.m
//  WLBase
//
//  Created by 雷王 on 17/3/1.
//  Copyright © 2017年 WL. All rights reserved.
//

#import "MBProgressHUD+_WL.h"

@implementation MBProgressHUD (_WL)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    // 设置图片
    //    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    
    hud.removeFromSuperViewOnHide = YES;
    
    // 1.5秒之后再消失
    [hud hideAnimated:YES afterDelay:1.5];
}

+ (void)showWithMessage:(NSString *)message
{
    [self show:message icon:nil view:nil];
}


@end
