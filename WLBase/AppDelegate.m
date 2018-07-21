//
//  AppDelegate.m
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#import "AppDelegate.h"
#import "PublicNavViewController.h"
#import "ViewController.h"
#import "LoadingViewController.h"
#import "JPUSHService.h"
#import "IFlyMSC/IFlyMSC.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//新浪微博SDK头文件<
#import "WeiboSDK.h"
BMKMapManager *_mapManager;

@interface AppDelegate ()<BMKGeneralDelegate,JPUSHRegisterDelegate>

@end

@implementation AppDelegate

- (void)resignBaiduLocation {
 
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"B0SzrFwaR5a09GC30w56sdIxAMuYEjA8" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    
    //初始化推送
    [self initPushLaunchOptions:launchOptions];
    //初始化网络监听
    [self initReachibility];
    [self resignBaiduLocation];

    
    //初始化微信
//    [WXApi registerApp:WEIXIN_APPKEY withDescription:@"0744"];
    [self createShareSDK];
    //初始化科大讯飞语音
    //Set log level
    [IFlySetting setLogFile:LVL_ALL];
    
    //Set whether to output log messages in Xcode console
    [IFlySetting showLogcat:YES];
    
    //Set the local storage path of SDK
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];
    
    //Set APPID
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];

    //Configure and initialize iflytek services.(This interface must been invoked in application:didFinishLaunchingWithOptions:)
    [IFlySpeechUtility createUtility:initString];

    
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [UIColor whiteColor];
//    self.window.rootViewController = [[PublicNavViewController alloc] initWithRootViewController:[[ViewController alloc] init]];;
//    [self.window makeKeyAndVisible];
    LoadingViewController* loadingViewController = [[LoadingViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loadingViewController];
    [nav setNavigationBarHidden:YES animated:YES];
    [nav setToolbarHidden:YES animated:YES];
    self.window.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}


#pragma mark --创建shareSDK
-(void)createShareSDK
{
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeWechat),@(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeQQ),] onImport:^(SSDKPlatformType platformType) {
                                            switch (platformType)
                                            {
                                                case SSDKPlatformTypeWechat:
                                                    [ShareSDKConnector connectWeChat:[WXApi class]];
                                                    break;
                                                case SSDKPlatformTypeQQ:
                                                    [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                                    break;
                                                case SSDKPlatformTypeSinaWeibo:
                                                    [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                                    break;
                                                default:
                                                    break;
                                            }
                                        } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                            switch (platformType)
                                            {
                                                case SSDKPlatformTypeSinaWeibo:
                                                    //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                                                    [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243" appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3" redirectUri:@"http://www.sharesdk.cn" authType:SSDKAuthTypeBoth];
                                                    break;
                                                case SSDKPlatformTypeWechat:
                                                    [appInfo SSDKSetupWeChatByAppId: @"wx4868b35061f87885" appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                                                    break;
                                                case SSDKPlatformTypeQQ:
                                                    [appInfo SSDKSetupQQByAppId:@"100371282"appKey:@"aed9b0303e3ed1e27bae87c33761161d" authType:SSDKAuthTypeBoth];
                                                    break;
                                                default:
                                                    break;
                                            }
                                            
                                        }];
}
#pragma mark 监听网络状态
-(void)initReachibility
{
    self.networkStatus = -1;
    
    self.autoDismissAlertCount = 0;
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    
    self.reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.reach startNotifier];
}
// 连接改变
- (void) reachabilityChanged: (NSNotification* )note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
    //    [self performSelector:@selector(updateInterfaceWithReachability:) withObject:nil afterDelay:5.0];
}

-(void) performDismiss:(NSTimer *)timer
{
    
    [self.autoDismissAlert dismissWithClickedButtonIndex:0 animated:YES];
    self.autoDismissAlertCount = 0;
    
}

//检测真正的网络是否畅通，而不仅仅是检测是否有wifi或者数据流量
-(void)tryDetectRealNetworkIsAvailable
{
    NSString* url = [NSString stringWithFormat:@"%@", @"http://www.baidu.com"];
    
    NSDictionary *param = nil;
    
    [HttpRequest getWebData:param path:url method:@"POST" ishowLoading:NO success:^(id object)
     {
         NSLog(@"%@", object);
         self.networkStatus = ReachableViaWiFi;//有网，不管它是什么网，不重要
     } fail:^(NSString *msg)
     {
         if (self.tryDetectNetworkTimesCount<2)//重试2次依然ping不通www.baidu.com就认为网络丢失
         {
             self.tryDetectNetworkTimesCount++;
             [self tryDetectRealNetworkIsAvailable];
         }
         else
         {
             self.tryDetectNetworkTimesCount = 0;//reset
             
             self.networkStatus = NotReachable;//网络此时为不畅通状态，不管有无wifi或者数据流量
         }
         
         NSLog(@"%@", msg);
     } isNeedCache:NO cacheExpireTime:0 httpTimeout:3];
}

//处理连接改变后的情况
- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
    //对连接改变做出响应的处理动作。
    self.networkStatus = [curReach currentReachabilityStatus];
    
    if ( self.networkStatus == NotReachable)
    {
        //没有连接到网络就弹出提实况
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络连接失败，请检查网络" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        if (self.autoDismissAlertCount<1) {
            [alert show];
            self.autoDismissAlert = alert;
            self.autoDismissAlertCount +=1;
            [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
        }
    }
}


#pragma mark------------------------微信登陆后的回调----------------------------
//微信授权登录后的回调。我们获得code，根据code去请求token
-(void) onResp:(BaseResp*)resp
{
    NSLog(@"resp");
    if ([resp isKindOfClass:[PayResp class]]) {
        // 微信支付结束远程通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:kOrderDidEndPayWithWeixinNotification object:resp userInfo:nil];
        // 取消该远程通知
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"kOrderDidEndPayUseWeixinNotification" object:resp userInfo:nil];
        
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"kGGSYJFNotification" object:resp userInfo:nil];
        
    }
    else if([resp isKindOfClass:[SendMessageToWXResp class]])//分享微信的行为结束回调
    {
        NSLog(@"%@",resp);
        NSLog(@"errStr %@",[resp errStr]);
        NSLog(@"errCode %d",[resp errCode]);
        NSLog(@"type %d",[resp type]);
        
        if ( [resp errCode] == 0 )//分享成功
        {
            //TODO
            //            KShareWeixinFriendSuccessfulNotification;
            //
            //            KShareWeixinFriendSuccessfulNotification;
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:KShareWeixinFriendSuccessfulNotification object:nil];//TODO
            NSLog(@"微信分享成功");
        }
        else
        {
            NSLog(@"发布失败!");
        }
        
    }else
    {
//        [[LoginSingleton sharedInstance]  receiveWeixinResponseWith:resp];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"weixinLogin" object:resp];//TODO

    }
    
    
}
#pragma mark-----------------------------------------------------------------
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSLog(@"application");
    return [WXApi handleOpenURL:url delegate:self];

}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"application");
//    return [self application:application openURL:url options:nil];
    return [WXApi handleOpenURL:url delegate:self];

}
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//
//    return [WXApi handleOpenURL:url delegate:self];
//
//}

#pragma mark 初始化推送
-(void)initPushLaunchOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    
    
    
    
    
    //JPush 2.1.6 版本
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_APPKEY
                          channel:PACKAGE_CHINNLE
                 apsForProduction:YES
            advertisingIdentifier:nil];
    // [2-EXT]: 获取启动时收到的APN
    self.pushMessage = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (self.pushMessage)
    {
        //NSString *payloadMsg = [message objectForKey:@"payload"];
        
        NSLog(@"获取启动时收到的APN = %@", self.pushMessage);
        
        
    }
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Required
    //注册到极光
    [JPUSHService registerDeviceToken:deviceToken];
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString* tarDeviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceToken:%@", deviceToken);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    NSLog(@"在didReceiveRemoteNotification收到的APN = %@", userInfo);
    
    
    // Required
    [JPUSHService handleRemoteNotification:userInfo];
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"在fetchCompletionHandler收到的APN = %@", userInfo);
    
    NSLog(@"application.applicationState=%d", (int)application.applicationState);
    
    
    //应用程序在前台
    if (application.applicationState == UIApplicationStateActive)
    {
        self.pushMessage = userInfo;
        
        NSDictionary* apsDic = userInfo[@"aps"];
        
    }
    else
    {
        
        
        // IOS 7 Support Required
        if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
        {
            // [2-EXT]: 在后台收到的APN
            self.pushMessage = userInfo;
            if (self.pushMessage)
            {
                //NSLog(@"在后台收到的APN = %@", self.pushMessage);
                
                [[NSNotificationCenter defaultCenter] postNotificationName:KReceivedRemoteNotificationFromBackgroundToForegroundNotification object:nil];
            }
            
            // use registerUserNotificationSettings
            [JPUSHService handleRemoteNotification:userInfo];
            completionHandler(UIBackgroundFetchResultNewData);
        } else {
            // use registerForRemoteNotifications
            
            if ([application respondsToSelector:@selector(registerForRemoteNotificationTypes:)]) {
                self.pushMessage = userInfo;
                if (self.pushMessage)
                {
                    //NSLog(@"在后台收到的APN = %@", self.pushMessage);
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:KReceivedRemoteNotificationFromBackgroundToForegroundNotification object:nil];
                }
                
                // use registerUserNotificationSettings
                [JPUSHService handleRemoteNotification:userInfo];
                completionHandler(UIBackgroundFetchResultNewData);
            }
            //TODO, 7.0的推送
        }
    }
    
    
}
#ifdef NSFoundationVersionNumber_iOS_9_x_Max

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler
{
    
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    self.pushMessage = notification.request.content.userInfo;
    
    NSDictionary* apsDic = userInfo[@"aps"];
    if ( [apsDic isKindOfClass:[NSDictionary class]]  )
    {
        NSDictionary* alertDic = apsDic[@"alert"];
        
        
        
    }
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler
{
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    self.pushMessage = userInfo;
    if (self.pushMessage)
    {
        //NSLog(@"在后台收到的APN = %@", self.pushMessage);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:KReceivedRemoteNotificationFromBackgroundToForegroundNotification object:nil];
    }
    
    // use registerUserNotificationSettings
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
#endif

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //检验网络
    [self tryDetectRealNetworkIsAvailable];

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
