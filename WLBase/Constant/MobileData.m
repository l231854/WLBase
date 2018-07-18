//
//  MobileData.m
//  CommunityService
//
//  Created by VincentDeng on 15/5/14.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import "MobileData.h"

@implementation MobileData

+ (MobileData *) sharedInstance
{
    static MobileData *__sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[MobileData alloc] init];
        
    
        
    });
    
    return __sharedInstance;
}




@end
