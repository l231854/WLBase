//
//  LoadingViewController.M 引导页
//  CommunityService
//
//  Created by 邓业昌 on 11/18/14.
//  Copyright (c) 2014 movitech. All rights reserved.
//

#import "LoadingViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "WZGuideViewController.h"
#import "PublicNavViewController.h"
#import "XCNavigationModalViewController.h"
//#import "MyKeyChainHelper.h"
#import "XCLoginViewController.h"
#import "XCWebViewController.h"
#import "WLFirstViewController.h"
//#import "XCAutomaticlyLogin.h"
//#import "XCChooseCityViewController.h"
//#import "XCBeforeLoginViewController.h"
//#import "DataOfHomePageMedel.h"
//#import "BannerView.h"
@interface LoadingViewController ()
{
    UIButton *_jumpBtn;
    
    BOOL isShowLoadingImage;
}
//开屏轮播
@property (nonatomic, strong) UIView *FunctionView;
@property (nonatomic, strong) NSMutableArray *dataArray;//轮播豆腐块数组
@property (nonatomic, strong) dispatch_source_t _time;
@end

@implementation LoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"LoadingViewController"];
    self.isDontNeedToCal = YES;
    
  
    isShowLoadingImage = NO;
    
    [self performSelector:@selector(exitLoadingVC:) withObject:self afterDelay:0];//暂时注释到广告业
    
    // Do any additional setup after loading the view.
//    [self loadImage];
}

-(void)exitLoadingVC:(id)params
{
    //TODO
    
    // title color
    //TODO
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
//        [WZGuideViewController show];
        [self performSelector:@selector(gotoFirstVC) withObject:nil afterDelay:0.2];

    }
    else
    {
        [self performSelector:@selector(gotoFirstVC) withObject:nil afterDelay:0.2];

//        [self performSelector:@selector(gotoLoginViewController) withObject:nil afterDelay:0.2];


    }
}

#pragma mark --进入第一个页面
- (void)gotoFirstVC
{
    WLFirstViewController *firstVC = [[WLFirstViewController alloc] init];
    XCNavigationModalViewController *navLogin = [[XCNavigationModalViewController alloc] initWithRootViewController:firstVC];
    [self presentViewController:navLogin animated:YES completion:nil];
}

#pragma mark - 监听textField
- (void)setupObserver
{
    //登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessfulAnddismissInLoading) name:KLoginSuccessfulNotification object:nil];
    
    //登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFail) name:KLoginFailNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    NSString *strLoadingViewController = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoadingViewController"];
//    if (strLoadingViewController==nil) {
//        [self goToHomeVC];
//    }
    [self setupObserver];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if (self._time) {
        dispatch_source_cancel(self._time);
    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoadingViewController"];
    
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)loginSuccessfulAnddismissInLoading
{
    
    //启动数据统计
//    [[NSNotificationCenter defaultCenter] postNotificationName:KAfterLoadUserInfoNotification object:nil userInfo:nil];
//    [self gotoLoginViewController];
        AppDelegate* appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"loginCreateHome"];
    appDelegate.window.rootViewController =
    [[PublicNavViewController alloc] initWithRootViewController:[[ViewController alloc] init]];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:KLoginSuccessfulNotification object:nil];

    
}



- (void)gotoLoginViewController
{
    //        XCBeforeLoginViewController *loginVC = [[XCBeforeLoginViewController alloc] init];
    XCLoginViewController *loginVC = [[XCLoginViewController alloc] init];
    XCNavigationModalViewController *navLogin = [[XCNavigationModalViewController alloc] initWithRootViewController:loginVC];
    [self presentViewController:navLogin animated:YES completion:nil];
    
}

-(void)loadImage
{
   
        //load default png
        NSLog(@"服务器欢迎页图片不存在,读取本地图片");
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        
        UIImageView* loadingImageView = nil;
        if ( (int)screenSize.height == 2208/3 )//6 plus
        {
            loadingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default1242"]];
        }
        else if ( (int)screenSize.height == 1334/2 )//6
        {
            loadingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default750"]];
        }
        else if ( (int)screenSize.height == 1136/2 )//5 5s
        {
            loadingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default1136"]];
        }
        else if ( (int)screenSize.height == 960/2 )//4 4s
        {
            loadingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default960"]];
        }
        
        loadingImageView.frame = self.view.bounds;
        loadingImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:loadingImageView];
    }


- (void)createJumpBtn
{
    _jumpBtn = [[UIButton alloc] init];
    
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳过"] forState:0];
    
    [_jumpBtn setTitleColor:[UIColor whiteColor] forState:0];
    
    _jumpBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [_jumpBtn setBackgroundColor:UIColorFromRGB(0x333333, 0.1)];
    
    _jumpBtn.frame = CGRectMake(WIDTH - 70, 20, 50, 25);
    
    _jumpBtn.layer.cornerRadius = _jumpBtn.bounds.size.width * 0.2;
    
    _jumpBtn.layer.masksToBounds = YES;
    
    [_jumpBtn addTarget:self action:@selector(jumpLoginView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_jumpBtn];
}

- (void)jumpLoginView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(exitLoadingVC:) object:self];//取消固定时长跳转界面
    [self exitLoadingVC:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
