//
//  NSString+contains.h
//  CommunityService
//
//  Created by Martin.Liu on 14-10-11.
//  Copyright (c) 2014年 movitech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (contains)
/**
 当obj是NSNull类或者，用方法isNull判断是空时候，自身设置为defaultString，如果defaultString也为空也设置为@""
 */
+ (instancetype) defaultStringWhenisNull : (NSString*)defaultString withStringObj:(id)obj;
/**
 当是［NSNull class］ 或者是nil 或者是@"" 返回YES ， 否则NO
 */
- (BOOL) isNull;
/**
 当自身用方法isNull判断是空时候，自身设置为defaultString，如果defaultString也为空也设置为@""
 此方法需要确认该对象不是NSNull，如果不确认可以用类方法defaultStringWhenisNull：withStringObj：
 */
- (id) defaultStringWhenisNull : (NSString*)defaultString;
/**
 当自身和比较字符串不为空时候 , 并且自身包含比较字符串返回YES ， 否则返回NO,
 */
- (BOOL) contains : (NSString*) otherString;
//判断空字符串
-(BOOL) isEmpty:(NSString *) str ;

//判断字符串是否包含空格
- (BOOL)isContainSpace:(NSString *)string;
/**判断字符串是否包含表情*/
+ (BOOL)stringContainsEmoji:(NSString *)string;

//提取字符串中的int 数字
+ (int)stringtoNumberWithString:(NSString *)string;
@end
