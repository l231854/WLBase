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
//        UIImageView *imageView2 = [[UIImageView alloc] init];
//
//        imageView2.frame = CGRectMake(WIDTH/2-30, self.tabBar.frame.origin.y-35 - space, 60, 60);
//        [imageView2 setBackgroundColor:[UIColor whiteColor]];
//        [self.view addSubview:imageView2];
//        [self.view insertSubview:imageView2 atIndex:0];
//
//        self.rectImageView = imageView2;
//        imageView2.clipsToBounds = YES;
//        imageView2.layer.cornerRadius = 30;
//        imageView2.layer.borderWidth = 0.5;
//        imageView2.layer.borderColor = [UIColor colorWithRed:167.0/255.0 green:167.0/255.0 blue:167.0/255.0 alpha:1.0].CGColor;

                TabBar *customTabBar = [[TabBar alloc] init];
                customTabBar.frame = self.tabBar.bounds;
                customTabBar.delegate = self;
        [self.tabBar addSubview:customTabBar];
                self.customTabBar = customTabBar;


    }
    return _customTabBar;
//    if (!_customTabBar) {
//        TabBar *customTabBar = [[TabBar alloc] init];
//        customTabBar.frame = self.tabBar.bounds;
//        customTabBar.delegate = self;
//        [self.tabBar addSubview:customTabBar];
//        self.customTabBar = customTabBar;
//
//    }
//    return _customTabBar;
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
    [self setupOneChildVC:home title:@"首页" imageName:@"icon1 copy" selectedImageName:@"icon1"];
    self.homePage = home;
    SecondViewController *second = [[SecondViewController alloc] init];
    [self setupOneChildVC:second title:@"订单管理" imageName:@"icon2 copy" selectedImageName:@"icon2"];
    self.secondVC = second;

    //
    ThirdViewController *third = [[ThirdViewController alloc] init];
    [self setupOneChildVC:third title:@"运营管理" imageName:@"icon5 copy" selectedImageName:@"icon5"];
    self.thirdVC = third;

    FourthViewController *fourth = [[FourthViewController alloc] init];
    [self setupOneChildVC:fourth title:@"我的" imageName:@"icon4 copy" selectedImageName:@"icon4"];
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
