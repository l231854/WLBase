//
//  AppDelegate.h
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//网络状态
@property (strong, nonatomic) Reachability *reach;
@property (nonatomic) NetworkStatus networkStatus;
@property (nonatomic, assign) int autoDismissAlertCount;
@property (nonatomic) int tryDetectNetworkTimesCount;
@property (nonatomic, strong) UIAlertView* autoDismissAlert;

@end

