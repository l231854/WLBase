//
//  XCNavigationModalViewController.M
//  CommunityService
//
//  Created by zhangmm on 15/5/12.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import "XCNavigationModalViewController.h"
#import "UIView+Extension.h"
@interface XCNavigationModalViewController ()

@end

@implementation XCNavigationModalViewController

+ (void)initialize
{
    // 导航栏主题
    [self setupNavTheme];
//
//    // 导航栏按钮主题
    [self setupItemTheme];
}

/**
 * 设置导航栏主题
 */
+ (void)setupNavTheme
{
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    

        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    
        textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
//        // 去掉阴影
//        textAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
  
        textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
        [navBar setTitleTextAttributes:textAttrs];
    
}

/**
 * 设置导航栏按钮主题
 */
+ (void)setupItemTheme
{
 
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
   
    // 按钮文字
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
   
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
 
//    textAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
  
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionary];
    highTextAttrs.dictionary = textAttrs;
    // 设置文字颜色
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs.dictionary = textAttrs;
    // 设置文字颜色
    disableTextAttrs[NSForegroundColorAttributeName] = COLOR_Black_TextGray;
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
 
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 如果push的不是根控制器(不是栈底控制器)

        UIImage *img =   [UIImage imageNamed:@"back"];
        UIButton *btn = [[UIButton alloc] init];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn setBackgroundImage:img forState:UIControlStateHighlighted];
        btn.frame = CGRectMake(0, 0, img.size.width, img.size.height);
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

  
    }else
    {
        UIImage *img =   [UIImage imageNamed:@"back"];
        UIButton *btn = [[UIButton alloc] init];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn setBackgroundImage:img forState:UIControlStateHighlighted];
        btn.frame = CGRectMake(0, 0, img.size.width, img.size.height);
        [btn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//         viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"  取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    }
    [super pushViewController:viewController animated:animated];
    
}



- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)cancel
{

    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
