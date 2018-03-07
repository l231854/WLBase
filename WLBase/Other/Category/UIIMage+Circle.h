//
//  UIIMage+Circle.h
//  CommunityService
//
//  Created by VincentDeng on 15/10/4.
//  Copyright © 2015年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (UIIMage_Circle)

//获取圆形image
-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset;

//获取圆角image
-(UIImage*) circleImage:(UIImage*) image withRadius:(CGFloat)radius;

@end