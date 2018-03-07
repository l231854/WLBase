//
//  ArrayDicToJson.m
//  CommunityService
//
//  Created by dengyechang on 15/5/15.
//  Copyright (c) 2015年 lee. All rights reserved.
//
//
//  NSString+HXAddtions.h
//  HXWeb
//
//  Created by hufeng on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//
//  NSString+HXAddtions.m
//  HXWeb
//
//  Created by hufeng on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NSString+HXAddtions.h"

@implementation NSString (HXAddtions)


+(NSString *) jsonStringWithString:(NSString *) string{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

+(NSString *) jsonStringWithArray:(NSArray *)array{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary{
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}

+(NSString *) jsonStringWithObject:(id) object{
    NSString *value = nil;
    if (!object) {
        return value;
        
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [NSString jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [NSString jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [NSString jsonStringWithArray:object];
    }
    return value;
}

- (CGRect)getTextWidthAndHeightWithBoldFont:(float)fontSize  withWidth:(float)width
{
    return [self getTextWidthAndHeightWithBoldFont:(float)fontSize  withWidth:width height:2000];
}

- (CGRect)getTextWidthAndHeightWithFont:(float)fontSize  withWidth:(float)width
{
    return [self getTextWidthAndHeightWithFont:(float)fontSize  withWidth:width height:2000];
}

- (CGRect)getTextWidthAndHeightWithBoldFont:(float)fontSize  withWidth:(float)width height:(float)height
{
    UIFont *font = [UIFont boldSystemFontOfSize:fontSize];
    
    CGSize size = CGSizeMake(width, height);
    
    //适配
//    if(IOS7)
//    {
//        
        CGRect labelRect = [self boundingRectWithSize:size
                                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                           attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]
                                              context:nil];
        return labelRect;
//    }
//    
//    else
//    {
//        NSAttributedString*attriStr=[[NSAttributedString alloc]initWithString:self attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]];
//        CGRect lableRect=[attriStr boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
//        return lableRect;
//        
//    }
    
    return CGRectZero;
}

//label自适应大小。传入参数：字体大小,宽度
- (CGRect)getTextWidthAndHeightWithFont:(float)fontSize  withWidth:(float)width height:(float)height
{
   
        UIFont *font = [UIFont systemFontOfSize:fontSize];
        
        CGSize size = CGSizeMake(width, height);
    
        //适配
//        if(IOS7)
//        {
    
            CGRect labelRect = [self boundingRectWithSize:size
                                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]
                                                 context:nil];
            return labelRect;
//        }
//        
//        else
//        {
//            NSAttributedString*attriStr=[[NSAttributedString alloc]initWithString:self attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]];
//            CGRect lableRect=[attriStr boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
//            return lableRect;
//            
//        }
    
        return CGRectZero;
    
}

- (CGSize)sizeOfTextWidthAndHeightWithFont:(float)fontSize  withWidth:(float)width
{
    
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    CGSize size = CGSizeMake(width,2000);
    
    //适配
//    if(IOS7)
//    {
    
        CGRect labelRect = [self boundingRectWithSize:size
                                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                           attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]
                                              context:nil];
        return labelRect.size;
//    }
//    
//    else
//    {
//        NSAttributedString*attriStr=[[NSAttributedString alloc]initWithString:self attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]];
//        CGRect lableRect=[attriStr boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
//        return lableRect.size;
//        
//    }
    
    return CGSizeZero;
    
}
@end
