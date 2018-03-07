//
//  UIImage+JSH.h
//  CommunityService
//
//  Created by zxl on 15-4-14.
//  Copyright (c) 2015年 movitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JSH)
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/**
 *  返回一张压缩的图片
 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
