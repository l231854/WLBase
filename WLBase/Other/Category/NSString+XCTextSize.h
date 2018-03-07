//
//  NSString+XCTextSize.h
//  CommunityService
//
//  Created by 索晓晓 on 15/8/28.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (XCTextSize)
/**
 *  获取一行字符串所占宽度
 *
 *  @param text 字符串
 *  @param font 字体
 *
 *  @return 宽度
 */
- (CGFloat)getWidthFont:(UIFont *)font;
/**
 *  获取一行字符串所占高度
 *
 *  @param text 字符串
 *  @param font 字体
 *
 *  @return 高度
 */
- (CGFloat)getHeightFont:(UIFont *)font;
@end
