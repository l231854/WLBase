//
//  ServerHostName.h
//  CommunityService
//
//  Created by dengyechang on 15/3/4.
//  Copyright (c) 2015年 movitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CoreTelephonyDefines.h>

//家里使用，
//#define HomeUse

#define ServerHostUrlKey @"ServerHostUrlKey"

#define KOnlineServerUrl  @"https://xcs-mobile.xincheng.com:20899/"//@"http://122.144.135.93:19999/"//@"http://mobile.xcfamily.cn:19988"

#define KPreOnlineServerUrl @"http://pre-xcapi.xcfamily.cn/"

///新的预发 http://mobile.xcfamily.cn/

#ifdef HomeUse
//家里使用的测试服务器
#define KTestServerUrl  @"http://124.74.40.86:38080/"//home use
#else

#define KTestServerUrl  @"http://61.132.109.16:8088/"//  @"http://10.1.151.23:8083/"

#endif
@interface ServerHostName : NSObject

@property (nonatomic, strong) NSString* baseServerUrl;

@property (nonatomic, strong) NSString* onlineServerUrl;
@property (nonatomic, strong) NSString* preOnlineServerUrl;
@property (nonatomic, strong) NSString* testServerUrl;

+ (ServerHostName *)shareInstance;

-(NSString*)currentServerHostName;

@end
