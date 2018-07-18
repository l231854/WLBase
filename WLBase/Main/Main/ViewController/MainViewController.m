//
//  MainViewController.m
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    
}
#pragma mark --createUI
-(void)createUI
{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame=CGRectMake(0, 100, WIDTH, 44);
    [btn setTitle:@"门店信息" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
#pragma mark -click
- (void)clickBtn:(UIButton *)btn
{
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavigationItem];
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initNavigationItem];
    
}
- (void)initNavigationItem
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    self.tabBarController.navigationItem.titleView = nil;
    self.tabBarController.title = nil;
    
    self.tabBarController.title =@"首页";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{
       NSForegroundColorAttributeName :[UIColor blackColor],
       NSFontAttributeName : [UIFont systemFontOfSize:36/2]
       }];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.title =nil;
    self.tabBarController.navigationItem.rightBarButtonItem =nil;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
