//
//  MainViewController.m
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#import "MainViewController.h"
#import "WLLocationViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "WLFlyViewController.h"
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
    
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.frame=CGRectMake(0, CGRectGetMaxY(btn.frame)+30, WIDTH, 44);
    [btn1 setTitle:@"语音播报" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(flyStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}


#pragma mark -click
- (void)clickBtn:(UIButton *)btn
{
    WLLocationViewController *vc = [[WLLocationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --语音合成
-(void)flyStart
{
    WLFlyViewController *vc = [[WLFlyViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
    [self createRigthBtn];
}

#pragma mark --createRight
- (void)createRigthBtn
{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame=CGRectMake(0, 0, 45, 45);
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromRGB(0x333333, 1) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickShare) forControlEvents:UIControlEventTouchUpInside];
    self.tabBarController.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
}
#pragma mark --分享
- (void)clickShare
{
    //1、创建分享参数
    //    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    NSArray* imageArray= @[@"http://img2.imgtn.bdimg.com/it/u=3588772980,2454248748&fm=27&gp=0.jpg"];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://img2.imgtn.bdimg.com/it/u=3588772980,2454248748&fm=27&gp=0.jpg"]）
    //    if (imageArray) {
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:nil
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    //大家请注意：4.1.2版本开始因为UI重构了下，所以这个弹出分享菜单的接口有点改变，如果集成的是4.1.2以及以后版本，如下调用：
    //    NSArray *customItems = @[@"1",@"6",@"22",@"23"];
    [ShareSDK showShareActionSheet:nil customItems:nil shareParams:shareParams sheetConfiguration:nil onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@",error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            default:
                break;
        }
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
