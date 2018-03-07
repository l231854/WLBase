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


#define kTabbarBtnTag 1001
@interface ViewController ()<TabBarDelegate>


@property (nonatomic, weak) MainViewController *homePage;
@property(nonatomic, weak)SecondViewController *secondVC;
@property (nonatomic, weak) ThirdViewController *thirdVC;
@property(nonatomic, weak)FourthViewController *fourthVC;
@end


@implementation ViewController

-(void)dealloc
{
    NSLog(@"%s",__func__);
}
//ViewController 是继承 UITabBarController的

#pragma mark - 初始化方法
- (TabBar *)customTabBar
{
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
    [self setupOneChildVC:home title:@"首页" imageName:@"homepage_normal" selectedImageName:@"homepage_selected"];
    self.homePage = home;
    SecondViewController *second = [[SecondViewController alloc] init];
    [self setupOneChildVC:second title:@"发现" imageName:@"橙管家_hover" selectedImageName:@"橙管家"];
    self.secondVC = second;
    
    //
    ThirdViewController *third = [[ThirdViewController alloc] init];
    [self setupOneChildVC:third title:@"问问" imageName:@"community_normal" selectedImageName:@"community_selected"];
    self.thirdVC = third;
    
    FourthViewController *fourth = [[FourthViewController alloc] init];
    [self setupOneChildVC:fourth title:@"我的" imageName:@"mine_normal" selectedImageName:@"mine_selected"];
    
    
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
    
//    if (to == 0) {
//        [MobClick event:KUmengEvent_home_page];
//    }
//    else if (to == 1)
//    {
//        [MobClick event:UmengChengManagerTabBar_event];
//    }
//    else if (to == 2) {
//        [MobClick event:KUmengEvent_neighbours];
//    }else if (to == 3) {
//        [MobClick event:KUmengEvent_me];
//    }
}


//自定义tabbar
#pragma mark----------------------------------创建tabbar-------------------------------------------
- (void)creatTabbar
{
    
 
    
}




#pragma mark-----------------------------------------------------------------------------

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
