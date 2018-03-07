//
//  NSString+StringSize.h
//  UILabelDemo2
//
//
//  Created by duanzongdi on 15-1-13.
//  Copyright (c) 2015年 duanzongdi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (StringSize)

/**
 *  计算显示文字所需的大小，该方法会自动根据不同版本用不同的方法来进行计算
 *
 *  @param font          显示文字的字体
 *  @param size          文字约束的大小
 *  @param lineBreakMode 换行模式
 *  @param options       描绘选项
 *  @param context       描绘上下文
 *
 *  @return 显示文字所需的最合适的大小
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode options:(NSStringDrawingOptions)options  context:(NSStringDrawingContext *)context;

@end
