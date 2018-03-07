//
//  TabBar.m
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#import "TabBar.h"
@interface TabBar()<UIAlertViewDelegate>
@property (nonatomic, weak) UIButton *plusButton;

@property (nonatomic, weak) TabBarButton *selectedTabBarButton;
@end

@implementation TabBar
- (NSMutableArray *)tabBarButtons
{
    if (!_tabBarButtons) {
        self.tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}



- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupBg];
        //        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

/**
 *  添加一个选项卡按钮
 *
 *  @param item 选项卡按钮对应的模型数据(标题\图标\选中的图标)
 */
- (void)addTabBarButton:(UITabBarItem *)item
{
    
    TabBarButton *button = [[TabBarButton alloc] init];
    button.item = item;
    [button addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchDown];
    button.tag = self.tabBarButtons.count;
    [self addSubview:button];
    
    
    [self.tabBarButtons addObject:button];
    
    // 默认让最前面的按钮选中
    if (self.tabBarButtons.count == 1) {
        [self tabBarButtonClick:button];
    }
    
    
}

/**
 *  点击选项卡按钮
 */
- (void)tabBarButtonClick:(TabBarButton *)button
{
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        NSInteger from = self.selectedTabBarButton.tag;
        NSInteger to = button.tag;
        [self.delegate tabBar:self didSelectButtonFrom:from to:to];
    }
    
    
    
    self.selectedTabBarButton.selected = NO;
    button.selected = YES;
    self.selectedTabBarButton = button;
}

/**
 *  设置背景
 */
- (void)setupBg
{
//    if (!IOS7) {
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
//    }
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [self setupTabBarButtonFrame];
}

/**
 *  设置选项卡按钮的位置和尺寸
 */
- (void)setupTabBarButtonFrame
{
    NSInteger count = self.tabBarButtons.count;
    CGFloat buttonW = self.frame.size.width / (count);
    CGFloat buttonH = self.frame.size.height;
    for (int i = 0; i < count; i++) {
        TabBarButton *button = self.tabBarButtons[i];
        button.frame = CGRectMake(buttonW * i, 0, buttonW, buttonH);
    }
}

#pragma mark UIAlertView协议方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001)     //绑定手机号
    {
        if (buttonIndex == 1)
        {
          
        }
    }
}


@end

