//
//  ArrayDicToJson.h
//  CommunityService
//
//  Created by dengyechang on 15/5/15.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HXAddtions)

+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;

+(NSString *) jsonStringWithArray:(NSArray *)array;

+(NSString *) jsonStringWithString:(NSString *) string;

+(NSString *) jsonStringWithObject:(id) object;

+(void) jsonTest;
- (CGRect)getTextWidthAndHeightWithFont:(float)fontSize  withWidth:(float)width;
- (CGRect)getTextWidthAndHeightWithFont:(float)fontSize  withWidth:(float)width height:(float)height;

- (CGRect)getTextWidthAndHeightWithBoldFont:(float)fontSize  withWidth:(float)width height:(float)height;

- (CGRect)getTextWidthAndHeightWithBoldFont:(float)fontSize  withWidth:(float)width;

- (CGSize)sizeOfTextWidthAndHeightWithFont:(float)fontSize  withWidth:(float)width;
@end

