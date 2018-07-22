//
//  ServerHostName.m
//  CommunityService
//
//  Created by dengyechang on 15/3/4.
//  Copyright (c) 2015年 movitech. All rights reserved.
//

#import "ServerHostName.h"

@implementation ServerHostName

+ (ServerHostName *)shareInstance
{
    static ServerHostName *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[ServerHostName alloc] init];
        [_sharedInstance initBaseServer];
    });
    return _sharedInstance;
}

////服务器环境选择
//#define XCCM_OnlinePackage  //线上环境 http://mobile.xcfamily.cn:19988
////#define XCCM_PreOnlinePackage //预发布环境 http://122.144.135.81:19988
////#define XCCM_testPackage    //测试环境 122.144.135.79

-(void)initBaseServer
{
    _onlineServerUrl = KOnlineServerUrl;
    _preOnlineServerUrl = KPreOnlineServerUrl;
    _testServerUrl = KTestServerUrl;
    

#ifdef XCCM_OnlinePackage
    self.baseServerUrl = KOnlineServerUrl;
#endif
    
#ifdef XCCM_PreOnlinePackage
    self.baseServerUrl = KPreOnlineServerUrl;
#endif
    
#ifdef XCCM_testPackage
    self.baseServerUrl = KTestServerUrl;
    NSString *strUrl=[[NSUserDefaults standardUserDefaults] objectForKey:@"baseServerUrl"];
    if (strUrl.length>0) {
        self.baseServerUrl=strUrl;
    }
    
#endif
    
    //如果设置过URL，覆盖默认的URL
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* baseUrlFromDisk = [defaults objectForKey:ServerHostUrlKey];
    
    if ( baseUrlFromDisk && baseUrlFromDisk.length )
    {
        self.baseServerUrl = baseUrlFromDisk;
    }
}

-(NSString*)currentServerHostName
{
    if ( [_baseServerUrl compare:KOnlineServerUrl] == 0 )
    {
        return @"线上服务器";
    }
    else if( [_baseServerUrl compare:KPreOnlineServerUrl] == 0 )
    {
        return @"预发布服务器";
    }
    else if( [_baseServerUrl compare:KTestServerUrl] == 0 )
    {
        return @"测试服务器";
    }
    return nil;
}


@end
