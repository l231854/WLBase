//
//  PublicNavViewController.m
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#import "PublicNavViewController.h"
#import "UIView+Extension.h"
#import "UINavigationBar+Awesome.h"
@interface PublicNavViewController ()

@end

@implementation PublicNavViewController

+ (void)initialize
{
    
    
    [self setupItemTheme];
}



/**
 * 设置导航栏按钮主题
 */
+ (void)setupItemTheme
{
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    
    textAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(0x333333, 1.0);
    
    
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionary];
    highTextAttrs.dictionary = textAttrs;
    
    highTextAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(0x333333, 1.0);
    [item setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs.dictionary = textAttrs;
    
    disableTextAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(0x999999, 1.0);
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
    self.view.backgroundColor = UIColorFromRGB(0xefefef, 1.0);
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.tabBarController.hidesBottomBarWhenPushed = YES;
        UIImage *img =   [UIImage imageNamed:@"back"];
        UIButton *btn = [[UIButton alloc] init];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn setBackgroundImage:img forState:UIControlStateHighlighted];
        btn.frame = CGRectMake(0, 0, img.size.width, img.size.height);
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.tabBarController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        
    }
    [super pushViewController:viewController animated:animated];
    
}



- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
