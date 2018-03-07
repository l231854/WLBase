//
//  NavigationController.h
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#import <UIKit/UIKit.h>
#undef UINavigationController

@interface NavigationController : UINavigationController
@property (nonatomic,strong) UIView  *removeView;

@property (nonatomic,strong) UIGestureRecognizer *popRemoveRecognizer;


@end
