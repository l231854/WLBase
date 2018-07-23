//
//  ViewController.m
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
#import "SecondViewController.h"
#import "AppDelegate.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "OtherViewController.h"
#import "UIView+Extension.h"
#import "XCWebViewController.h"
#import "XCWebViewController2.h"
#import "XCWebViewController4.h"
#import "XCWebViewController5.h"

#define kTabbarBtnTag 1001
@interface ViewController ()<TabBarDelegate>


@property (nonatomic, weak) MainViewController *homePage;
@property(nonatomic, weak)SecondViewController *secondVC;
@property (nonatomic, weak) ThirdViewController *thirdVC;
@property(nonatomic, weak)FourthViewController *fourthVC;
@property(nonatomic, weak)OtherViewController *otherVC;
@property (nonatomic,weak) UIImageView *rectImageView;

@end


@implementation ViewController

-(void)dealloc
{
    NSLog(@"%s",__func__);
}


#pragma mark - 初始化方法
- (TabBar *)customTabBar
{
    float space = 0;
    if (HEIGHT == 812) {
        space = 34;
    }

    if (!_customTabBar) {


                TabBar *customTabBar = [[TabBar alloc] init];
                customTabBar.frame = self.tabBar.bounds;
                customTabBar.delegate = self;
        [self.tabBar addSubview:customTabBar];
                self.customTabBar = customTabBar;


    }
    return _customTabBar;

}
#pragma mark init方法内部调用

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self setupAllChildVCs];
    }
    return self;
}

#pragma mark view加载完毕

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSwitchToFirstTab) name:KSwitchToFirstTabNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSwitchToSecondTab) name:KSwitchToSecondTabNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSwitchToThirdTab) name:KSwitchToThirdTabNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSwitchToFourthTab) name:KSwitchToFourthTabNotification object:nil];


}
#pragma mark --跳转到第几个
- (void)handleSwitchToFirstTab
{
    [self.customTabBar tabBarButtonClick:self.customTabBar.tabBarButtons[0]];

}
- (void)handleSwitchToSecondTab
{
    [self.customTabBar tabBarButtonClick:self.customTabBar.tabBarButtons[1]];

}
- (void)handleSwitchToThirdTab
{
    [self.customTabBar tabBarButtonClick:self.customTabBar.tabBarButtons[2]];

}
- (void)handleSwitchToFourthTab
{
    [self.customTabBar tabBarButtonClick:self.customTabBar.tabBarButtons[3]];

}
- (void)backHomepage
{
    [self.customTabBar tabBarButtonClick:self.customTabBar.tabBarButtons[0]];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 移除系统自动产生的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        // 私有API  UITabBarButton
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 移除系统自动产生的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        // 私有API  UITabBarButton
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    // 移除系统自动产生的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        // 私有API  UITabBarButton
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}


#pragma mark 初始化自己的所有子控制器
- (void)setupAllChildVCs
{
    // 首页
    MainViewController *home = [[MainViewController alloc] init];
    [self setupOneChildVC:home title:@"首页" imageName:@"tab_home_normal_icon" selectedImageName:@"tab_home_click_icon"];
    self.homePage = home;
    SecondViewController *second = [[SecondViewController alloc] init];
    [self setupOneChildVC:second title:@"订单管理" imageName:@"tab_ordermanagement_normal_icom" selectedImageName:@"tab_ordermanagement_click_icon"];
    self.secondVC = second;

    //
    ThirdViewController *third = [[ThirdViewController alloc] init];
    [self setupOneChildVC:third title:@"运营管理" imageName:@"tab_operationsmanagement_normal_icon" selectedImageName:@"tab_perationsmanagement_click_icon"];
    self.thirdVC = third;

    FourthViewController *fourth = [[FourthViewController alloc] init];
    [self setupOneChildVC:fourth title:@"我的" imageName:@"tab_mine_normal_icon" selectedImageName:@"tab_mine_click_icon"];
    self.fourthVC=fourth;

//    OtherViewController *other = [[OtherViewController alloc] init];
//    [self setupOneChildVC:other title:@"更多" imageName:@"icon5 copy" selectedImageName:@"icon5"];
//    self.otherVC=other;
    

}

#pragma mark 初始化一个子控制器

- (void)setupOneChildVC:(UIViewController *)child title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    child.title = title;
    
    child.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
//    if (IOS7) { // 如果是iOS7, 不需要渲染图片
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    }
    
    child.tabBarItem.selectedImage = selectedImage;
    
    
    [self addChildViewController:child];
    
    [self.customTabBar addTabBarButton:child.tabBarItem];
}

#pragma mark -XCTabBarDelegate
- (void)tabBar:(TabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
    

}


//自定义tabbar
#pragma mark----------------------------------创建tabbar-------------------------------------------
- (void)creatTabbar
{
    
 
    
}
- (void)setIsTabBarHidden:(BOOL)isTabBarHidden
{
    self.tabBar.hidden  = isTabBarHidden;
    self.customTabBar.hidden = isTabBarHidden;
    self.rectImageView.hidden = isTabBarHidden;
}



#pragma mark-----------------------------------------------------------------------------

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
