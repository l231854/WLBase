//
//  NSString+XCTextSize.m
//  CommunityService
//
//  Created by 索晓晓 on 15/8/28.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import "NSString+XCTextSize.h"

@implementation NSString (XCTextSize)

- (CGFloat)getWidthFont:(UIFont *)font
{
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size.width;
}
- (CGFloat)getHeightFont:(UIFont *)font
{
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size.height;
}

@end
