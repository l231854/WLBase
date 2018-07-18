//
//  UIIMage+Empress.h
//  CommunityService
//
//  Created by VincentDeng on 15/6/22.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIIMage_Empress)

-(UIImage*)getEmpressImge;

//压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
