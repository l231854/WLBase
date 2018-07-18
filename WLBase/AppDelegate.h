//
//  AppDelegate.h
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
//推送消息
@property (strong, nonatomic) NSDictionary* pushMessage;
//网络状态
@property (strong, nonatomic) Reachability *reach;
@property (nonatomic) NetworkStatus networkStatus;
@property (nonatomic, assign) int autoDismissAlertCount;
@property (nonatomic) int tryDetectNetworkTimesCount;
@property (nonatomic, strong) UIAlertView* autoDismissAlert;

@end

