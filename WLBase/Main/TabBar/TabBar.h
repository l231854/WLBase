//
//  TabBar.h
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarButton.h"

@class TabBar;
@protocol TabBarDelegate <NSObject>
@optional
- (void)tabBar:(TabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to;
@end

@interface TabBar : UIView
/**
 *  添加一个选项卡按钮
 *
 *  @param item 选项卡按钮对应的模型数据(标题\图标\选中的图标)
 */
- (void)addTabBarButton:(UITabBarItem *)item;

- (void)tabBarButtonClick:(TabBarButton *)button;

@property (nonatomic, strong) NSMutableArray *tabBarButtons;

@property (nonatomic, weak) id<TabBarDelegate> delegate;
@end
