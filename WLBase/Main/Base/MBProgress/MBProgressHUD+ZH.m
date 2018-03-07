//
//  MBProgressHUD+ZH.m
//
//  Created by zmm on 15-4-18.
//  Copyright (c) 2015年 zmm.  All rights reserved.
//

#import "MBProgressHUD+ZH.h"

@implementation MBProgressHUD (ZH)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
//    if (view == nil)
//    {
//        UIViewController *result = nil;
//        UIWindow * window        = [[UIApplication sharedApplication] keyWindow];
//        if (window.windowLevel != UIWindowLevelNormal) {
//            NSArray *windows = [[UIApplication sharedApplication] windows];
//            for(UIWindow * tmpWin in windows) {
//                if (tmpWin.windowLevel == UIWindowLevelNormal) {
//                    window = tmpWin;
//                    break;
//                }
//            }
//        }
//
//        UIView *frontView = [[window subviews] objectAtIndex:0];
//        id nextResponder  = [frontView nextResponder];
//
//        if ([nextResponder isKindOfClass:[UIViewController class]]){
//            result = nextResponder;
//        }
//        else{
//            result = window.rootViewController;
//        }
//        view = result.view;
//    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    // 设置图片
//    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
  
    hud.mode = MBProgressHUDModeCustomView;
    
  
    hud.removeFromSuperViewOnHide = YES;
    
    // 1.5秒之后再消失
    [hud hide:YES afterDelay:1.5];
}

+ (void)showWithMessage:(NSString *)message
{
    [self show:message icon:nil view:nil];
}

@end
