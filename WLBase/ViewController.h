//
//  ViewController.h
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBar.h"
@interface ViewController : UITabBarController

@property (nonatomic, weak) TabBar *customTabBar;
@property (nonatomic,assign) BOOL  isTabBarHidden;

@end

