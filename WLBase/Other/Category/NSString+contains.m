//
//  NSString+contains.m
//  CommunityService
//
//  Created by Martin.Liu on 14-10-11.
//  Copyright (c) 2014年 movitech. All rights reserved.
//

#import "NSString+contains.h"

#define defaultNullString @""

@implementation NSString (contains)

+ (instancetype) defaultStringWhenisNull : (NSString*)defaultString withStringObj:(NSString*)obj
{
    if ([obj isKindOfClass:[NSNull class]] || !obj || ([obj isKindOfClass:[NSString class]] && [obj isNull])) {
        if ([defaultString isNull]) {
            return (id)defaultNullString;
        }
        return defaultString;
    }
    else
    {
        return obj;
//        return [NSString stringWithFormat:@"%@", obj];
    }
}

- (BOOL) isNull
{
    if (![self isKindOfClass:[NSString class]] || self == nil || [@"" isEqualToString:[self description]]) {
        return YES;
    }
    return NO;
}

- (id) defaultStringWhenisNull : (NSString*)defaultString
{
    if ([self isNull]) {
        if ([defaultString isNull]) {
            return (id)defaultNullString;
        }
        return (id)[NSString stringWithString:defaultString];
    }
    return self;
}

- (BOOL) contains : (NSString*) otherString{
    if ([self isNull] || [otherString isNull]) {
        return NO;
    }
    NSRange range = [self rangeOfString:otherString];
    if (range.length > 0) {
        return YES;
    }
    return NO;
}

-(BOOL) isEmpty:(NSString *) str {
    
    if (!str) {
        return YES;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            NSLog(@"%d",trimedString.length);
            return YES;
        } else {
            return NO;
        }
    }
}


- (BOOL)isContainSpace:(NSString *)string
{
    if ([string contains:@" "]) {
        return YES;
    }
    
    return NO;
}



+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

+ (int)stringtoNumberWithString:(NSString *)string
{

   
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number;
    [scanner scanInt:&number];
    
    return number;
}
@end
