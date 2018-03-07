//
//  UIBarButtonItem+XC.m
//  CommunityService
//
//  Created by zhangmm on 15/5/11.
//  Copyright (c) 2015年 movitech. All rights reserved.
//

#import "UIBarButtonItem+XC.h"

@implementation UIBarButtonItem (XC)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];

    btn.bounds = CGRectMake(0,0,20, 20);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
   
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
