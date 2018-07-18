//
//  BaseViewController.m
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#import "BaseViewController.h"
#import "NSString+HXAddtions.h"
#import "NSString+StringSize.h"
#import "XCNavigationModalViewController.h"
//#import "XCLoginViewController.h"
#define kDeltaHeight XCStatusBar

#define LeftNavBarItemOffset ( KGetSizeFromScreen(-3, -3, -6) )

@interface BaseViewController ()<UIGestureRecognizerDelegate>


@property (nonatomic, retain) UIImageView* naviCopyImgView;

@end

@implementation BaseViewController

-(void)setTitleBarTitleStyle
{
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{
       NSForegroundColorAttributeName :[UIColor colorWithRed:45/255.0f green:45/255.0f blue:45/255.0f alpha:1.0],
       NSFontAttributeName : [UIFont systemFontOfSize:36/2]
       }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (IOS11) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeUITabBarButton" object:nil];
    }
    
    [self setNaviBarTransParent:YES];
    
    [self setTitleBarTitleStyle];
    
    if ( ![self.parentViewController isKindOfClass:[XCNavigationModalViewController class]] )//非model视图，才需要做, 否则前后不一致透明的视图手势返回会有bug
    {
        //暂时注释掉，会造成modal的视图弹出过程导航栏消失透明的错误
        [self.navigationController.navigationBar lt_reset];
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
        [self.navigationController.navigationBar lt_setContentAlpha:0];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self changeStatusBarStyle];
    
    [self dragBackOpen];
    
    if ( ![self.parentViewController isKindOfClass:[XCNavigationModalViewController class]] )//非model视图，才需要做, 否则前后不一致透明的视图手势返回会有bug
    {
        [self.navigationController.navigationBar lt_setContentAlpha:1];//IOS7 model试图会产生蓝色返回键的图像
    }
    
    [self setNaviBarTransParent:YES];
    
    //复制系统导航栏到self.view
    [self copyNavBarLayerToFakeNav];
    
    if ( !self.isDontNeedToCal )
    {
        //友盟统计 进入页面
        NSString* className = [NSString stringWithUTF8String:object_getClassName(self)];
//        [MobClick beginLogPageView:className];
    }
}

// Duplicate UIView
- (UIView*)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

-(void)buildFakeNav
{
    if (self.isNeedTrans
        || self.navigationController.viewControllers.count == 1
        || self.navigationController.navigationBarHidden == YES
        
        )//不透明 或者 不是第二层的视图控制器 或者导航栏已经隐藏
        return;
    
    if ( [self.parentViewController isKindOfClass:[XCNavigationModalViewController class]] )
    {
        return;//
    }
    
    self.fakeNavView = [[UIView alloc] initWithFrame:CGRectMake(0, -(TITLEVIEWHEIGHT+StatusBarHeight), WIDTH, TITLEVIEWHEIGHT+StatusBarHeight)];
    self.fakeNavView.backgroundColor = KNormalNavBarBgColor;
    self.fakeNavView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    [self.view addSubview:self.fakeNavView];
    
    //加入分割线
    UIView* separatorLineWidth = [[UIView alloc] init];
    separatorLineWidth.frame = CGRectMake(0, TITLEVIEWHEIGHT+StatusBarHeight-KSeparatorLineHeight, WIDTH, KSeparatorLineHeight);
    separatorLineWidth.backgroundColor = KSeparatorLineColor;
    [self.fakeNavView addSubview:separatorLineWidth];
}

- (UIImage *)ViewRenderImageBy:(UIView*)view
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake( WIDTH, StatusBarHeight+TITLEVIEWHEIGHT), view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//复制系统导航栏的截图，
-(void)copyNavBarLayerToFakeNav
{
    if (self.isNeedTrans || self.navigationController.viewControllers.count == 1 || self.navigationController.navigationBarHidden == YES)//不透明 或者 不是第二层的视图控制器 或者导航栏已经隐藏
        return;
    
    //[self.fakeNavView addSubview:[self duplicate:self.navigationController.navigationBar]];
    
    UIImage* img = [self ViewRenderImageBy:self.navigationController.view];
    self.naviCopyImgView = [[UIImageView alloc] initWithImage:img];
    self.naviCopyImgView.frame = self.fakeNavView.bounds;
    [self.fakeNavView addSubview:self.naviCopyImgView];
    
    [self.view bringSubviewToFront:self.fakeNavView];
    
    //    [self.fakeNavView.layer addSublayer:[self duplicate:self.navigationController.navigationBar.layer]];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if ( !self.isDontNeedToCal )
    {
        //退出页面
        NSString* className = [NSString stringWithUTF8String:object_getClassName(self)];
//        [MobClick endLogPageView:className];
    }
}

-(void)dragBackOpen
{
    //设置导航栏支持，滑动返回
    //适配
    
    if (IOS7)
    {
        
        if (self.navigationController.viewControllers.count>1)
            
            self.navigationController.interactivePopGestureRecognizer.enabled = !self.isCloseLeftPanBackGes;
        else
            self.navigationController.interactivePopGestureRecognizer.enabled = self.isCloseLeftPanBackGes;
        
        
    }
    
    //开启iOS7的滑动返回效果
    //适配
    if(IOS7)
    {
        if (self.navigationController.viewControllers.count>1 && !self.isCloseLeftPanBackGes)
        {
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            }
        }
    }
}


//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    /**
//     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
//     */
//    return self.navigationController.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
//}

-(void)setNaviBarTransParent:(BOOL)isFromDidAppaer
{
    if (self.navigationController.navigationBarHidden == YES)//如果导航栏已经隐藏，不进行设置导航栏是否透明
    {
        return;
    }
    
    if (!self.isNeedTrans)//不透明
    {
        [self setNavBarWhiteAndUntransparent];
        self.automaticallyAdjustsScrollViewInsets = YES;
        
        if (isFromDidAppaer) {
            [self.navigationController.navigationBar showLineOfNavtionBar:self.isShowLine];
        }
    }
    else
    {
        //导航栏透明
        [self.navigationController.navigationBar hideLineOfNavtionBar];
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.automaticallyAdjustsScrollViewInsets = NO;
        //        [self.navigationController.navigationBar lt_reset];
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
        //self.extendedLayoutIncludesOpaqueBars = YES;
    }
}

-(void)changeStatusBarStyle
{
    if ( self.isNeedWhite )
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    }
}



//-(void)setTitleBarStyle
//{
//    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:KDefaultTitleViewTitleColor, NSForegroundColorAttributeName,
//                                               KDefaultTitleViewTitleFont, NSFontAttributeName, nil];
//
//    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
////    [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
//}

-(void)setNavBarWhiteAndUntransparent
{
    [self.navigationController.navigationBar lt_reset];
    [self.navigationController.navigationBar lt_setBackgroundColor:KNormalNavBarBgColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self buildCustomNavBar];
    
    self.view.backgroundColor = DEFAULT_BackgroundView_COLOR;
    ////    self.automaticallyAdjustsScrollViewInsets = NO;
    //
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //[self.navigationController.navigationBar showLineOfNavtionBar];
    [self setTitleBarTitleStyle];
    
    //默认自动加入灰色返回按钮
    [self buildBackBarButtonItemGrayCoolr];
    //[self setTitleBarStyle];
    
    [self buildFakeNav];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backHomepage) name:@"backHomepage" object:nil];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        
    }
    
}

- (void)backHomepage
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

//-(void)buildCustomNavBar
//{
//    self.navigationController.navigationBar.hidden = YES;
//
//    self.myNavBar = [[MyNavBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
//    [self.view addSubview:self.myNavBar];
//    [self.myNavBar.backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    self.myNavBar.barTintColor = [UIColor whiteColor];
//}

-(void)buildBackBarButtonItemWhiteColor
{
    UIImage* img = [UIImage imageNamed:@"backw"];
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:img forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //    //往左移动
    //    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
    //                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
    //                                       target:nil action:nil];
    //    negativeSpacer.width = LeftNavBarItemOffset;
    
    btn.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:img forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = nil;
    //    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:btn], nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    //适配
    if(IOS7)
    {
        if (self.navigationController.viewControllers.count > 1 )
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

-(void)buildBackBarButtonItemGrayCoolr
{
    self.navigationItem.leftBarButtonItem = nil;
    
    if ([self.parentViewController isKindOfClass:[XCNavigationModalViewController class]] && self.navigationController.viewControllers.count == 1) {
        UIImage* img = [UIImage imageNamed:@"nav_icon_back"];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, img.size.width, img.size.height);
        [btn setImage:img forState:UIControlStateNormal];
        [btn setImage:img forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        //self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:btn], nil];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }else
    {
        UIImage* img = [UIImage imageNamed:@"nav_icon_back"];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //btn.backgroundColor = [UIColor redColor];
        btn.frame = CGRectMake(0, 0, img.size.width, img.size.height);
        [btn setImage:img forState:UIControlStateNormal];
        [btn setImage:img forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:btn], nil];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    //适配
    if(IOS7)
    {
        if (self.navigationController.viewControllers.count > 1 && !self.isCloseLeftPanBackGes)
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)backBtnClicked:(id)param
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showNoDataView:(BOOL)isShow title:(NSString *)title inView:(UIView *)view
{
    CGSize size = [title sizeOfTextWidthAndHeightWithFont:15 withWidth:(WIDTH- 30)];
    if (isShow) {
        
        if (self.showImageViewbg) {
            self.showImageViewbg.hidden = NO;
            self.showImageView.image = [UIImage imageNamed:@"nodata"];
            self.lbshowTip.text = title;
            self.lbshowTip.frame = CGRectMake((WIDTH - size.width)/2, CGRectGetMaxY(self.showImageView.frame)+10, size.width, size.height);
        }else
        {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:view.bounds];
            imgView.image = nil;
            imgView.backgroundColor = [UIColor clearColor];
            self.showImageViewbg = imgView;
            self.showImageViewbg.hidden = NO;
            
            UIImageView *waitView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nodata"]];
            waitView.bounds = CGRectMake(0, 0, waitView.bounds.size.width/2, waitView.bounds.size.height/2);
            waitView.center = CGPointMake(imgView.center.x, imgView.center.y-kDeltaHeight);
            
            
            [imgView addSubview:waitView];
            [view addSubview:imgView];
            
            
            UILabel *lbLNoOrderTip = [[UILabel alloc] init];
            lbLNoOrderTip.frame = CGRectMake((imgView.bounds.size.width - size.width)/2, CGRectGetMaxY(waitView.frame)+10, size.width, size.height);
            lbLNoOrderTip.textColor = COLOR_Black_TextGray;
            lbLNoOrderTip.font = [UIFont systemFontOfSize:15];
            lbLNoOrderTip.textAlignment = NSTextAlignmentLeft;
            lbLNoOrderTip.numberOfLines = 0;
            lbLNoOrderTip.text = title;
            self.lbshowTip = lbLNoOrderTip;
            [imgView addSubview:lbLNoOrderTip];
            
        }
        
    }else{
        
        self.showImageViewbg.hidden = YES;
        
    }
    
    
}

- (void)showNoDataView:(BOOL)isShow title:(NSString *)title
{
    CGSize size = [title sizeOfTextWidthAndHeightWithFont:15 withWidth:(WIDTH- 30)];
    if (isShow) {
        if (self.showImageViewbg) {
            self.showImageViewbg.hidden = NO;
            self.showImageView.image = [UIImage imageNamed:@"nodata"];
            self.lbshowTip.text = title;
            
            self.lbshowTip.frame = CGRectMake((WIDTH - size.width)/2, CGRectGetMaxY(self.showImageView.frame)+10, size.width, size.height);
            
            [self.view bringSubviewToFront:self.showImageViewbg];
        }else
        {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
            imgView.image = nil;
            imgView.backgroundColor = [UIColor clearColor];
            self.showImageViewbg = imgView;
            self.showImageViewbg.hidden = NO;
            
            UIImageView *waitView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nodata"]];
            waitView.bounds = CGRectMake(0, 0, waitView.bounds.size.width/2, waitView.bounds.size.height/2);
            waitView.center = CGPointMake(imgView.center.x, imgView.center.y-kDeltaHeight);
            self.showImageView = waitView;
            [imgView addSubview:waitView];
            [self.view addSubview:imgView];
            
            UILabel *lbLNoOrderTip = [[UILabel alloc] init];
            lbLNoOrderTip.frame = CGRectMake((WIDTH - size.width)/2, CGRectGetMaxY(waitView.frame)+10, size.width, size.height);
            lbLNoOrderTip.textColor = COLOR_Black_TextGray;
            lbLNoOrderTip.font = [UIFont systemFontOfSize:15];
            lbLNoOrderTip.textAlignment = NSTextAlignmentLeft;
            lbLNoOrderTip.numberOfLines = 0;
            lbLNoOrderTip.text = title;
            self.lbshowTip = lbLNoOrderTip;
            [imgView addSubview:lbLNoOrderTip];
        }
        
    }else{
        
        self.showImageViewbg.hidden = YES;
        
        
    }
}

- (void)showFailRequestView:(BOOL)isShow  failBlock:(void(^)( id obj))failBlock
{
    NSString *title =  @"小橙刚才走神了，再试一次吧";
    CGSize size = [title sizeOfTextWidthAndHeightWithFont:15 withWidth:(WIDTH- 30)];
    if (isShow) {
        
        if (self.showImageViewbg)
        {
            self.showImageViewbg.hidden = NO;
            self.showImageView.image = [UIImage imageNamed:@"loadingfail"];
            self.lbshowTip.text =  title;
            self.lbshowTip.frame = CGRectMake((WIDTH - size.width)/2, CGRectGetMaxY(self.showImageView.frame)+10, size.width, size.height);
        }else
        {
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
            imgView.image = nil;
            imgView.backgroundColor = [UIColor whiteColor];
            self.showImageViewbg = imgView;
            [self.view addSubview:imgView];
            self.showImageViewbg.hidden = NO;
            
            UIImage *failImage = [UIImage imageNamed:@"loadingfail"];
            UIButton *btn = [[UIButton alloc] init];
            [btn setImage:failImage forState:UIControlStateNormal];
            btn.bounds = CGRectMake(0, 0, failImage.size.width/2, failImage.size.height/2);
            btn.center = CGPointMake(imgView.center.x, imgView.center.y-kDeltaHeight);
            
            
            [imgView addSubview:btn];
            
            
            UILabel *lbLNoOrderTip = [[UILabel alloc] init];
            lbLNoOrderTip.frame = CGRectMake((WIDTH - size.width)/2, CGRectGetMaxY(btn.frame)+10, size.width, size.height);
            lbLNoOrderTip.textColor = COLOR_Black_TextGray;
            lbLNoOrderTip.font = [UIFont systemFontOfSize:15];
            lbLNoOrderTip.textAlignment = NSTextAlignmentLeft;
            lbLNoOrderTip.numberOfLines = 0;
            lbLNoOrderTip.text = title;
            self.lbshowTip = lbLNoOrderTip;
            [imgView addSubview:lbLNoOrderTip];
            
            
            btn.block = ^(UIButton* btn){
                if (failBlock) {
                    failBlock(nil);
                }
            };
            
            
            
        }
    }
    else{
        self.showImageViewbg.hidden = YES;
        
    }
    
    
}


- (void)showWaitLoadingView:(BOOL)isShow
{
    NSString *title = @"小橙正在为你努力加载，请稍后...";
    CGSize size = [title sizeOfTextWidthAndHeightWithFont:15 withWidth:(WIDTH- 30)];
    if (isShow) {
        
        if (self.showImageViewbg) {
            self.showImageViewbg.hidden = NO;
            self.showImageView.image = [UIImage imageNamed:@"animation1"];
            self.lbshowTip.text =  title;
            self.lbshowTip.frame = CGRectMake((WIDTH - size.width)/2, CGRectGetMaxY(self.showImageView.frame)+10, size.width, size.height);
            [self.view bringSubviewToFront:self.showImageViewbg];
        }else
        {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
            imgView.image = nil;
            imgView.backgroundColor = [UIColor clearColor];
            self.showImageViewbg = imgView;
            self.showImageViewbg.hidden = NO;
            UIImageView *waitView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"animation1"]];
            waitView.bounds = CGRectMake(0, 0, waitView.bounds.size.width/2, waitView.bounds.size.height/2);
            waitView.center = CGPointMake(imgView.center.x, imgView.center.y-kDeltaHeight);
            self.showImageView = waitView;
            [imgView addSubview:waitView];
            [self.view addSubview:imgView];
            
            UILabel *lbLNoOrderTip = [[UILabel alloc] init];
            lbLNoOrderTip.frame = CGRectMake((WIDTH - size.width)/2, CGRectGetMaxY(waitView.frame)+10, size.width, size.height);
            lbLNoOrderTip.textColor = COLOR_Black_TextGray;
            lbLNoOrderTip.font = [UIFont systemFontOfSize:15];
            lbLNoOrderTip.textAlignment = NSTextAlignmentLeft;
            lbLNoOrderTip.numberOfLines = 0;
            lbLNoOrderTip.text = title;
            self.lbshowTip = lbLNoOrderTip;
            [imgView addSubview:lbLNoOrderTip];
            
        }
        [self runAnimationWithFileCount:16 andFileName:@"animation"];
        
    }else{
        [self.showImageView stopAnimating];
        self.showImageViewbg.hidden = YES;
        
        
    }
    
    
}

- (void)runAnimationWithFileCount:(NSInteger)count andFileName:(NSString *)name
{
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%@%d", name, i+1 ];
        //        NSBundle *bundle = [NSBundle mainBundle];
        //
        //        NSString *fullPath = [bundle pathForResource:fileName ofType:@"png"];
        UIImage *image = [UIImage imageNamed:fileName];
        
        [images addObject:image];
    }
    
    self.showImageView.animationImages = images;
    
    CGFloat delay = images.count * 0.05;
    self.showImageView.animationDuration = delay;
    self.showImageView.animationRepeatCount = 0;
    
    [self.showImageView startAnimating];
    
}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    //[view release];
}


-(void) performDismiss:(NSTimer *)timer
{
    [self.autoDismissAlert dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)showAutoDismissAlert:(NSString*)title
{
    self.autoDismissAlert = [[UIAlertView alloc] initWithTitle:@"" message:title delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [self.autoDismissAlert show];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    //    // Add code to clean up any of your own resources that are no longer necessary.
    //
    //    // 此处做兼容处理需要加上ios6.0的宏开关，保证是在6.0下使用的,6.0以前屏蔽以下代码，否则会在下面使用self.view时自动加载viewDidLoad
    //    if ([self.view window] == nil)// 是否是正在使用的视图
    //    {
    //        // Add code to preserve data stored in the views that might be
    //        // needed later.
    //
    //        // Add code to clean up other strong references to the view in
    //        // the view hierarchy.
    //        self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
    //    }
    
    //    [[SDImageCache sharedImageCache] cleanDisk];
    //    [[SDImageCache sharedImageCache] clearDisk];
    
    [[SDImageCache sharedImageCache] clearMemory];
}
/*
 
 订单相关调用的方法
 
 */
- (long)getTimesReturnTime:(NSString*)time
{
    NSArray *timeArr;
    if (time) {
        timeArr = [time componentsSeparatedByString:@"."];
    }
    
    //创建时间格式化器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    //获得当前的时间
    NSDate *date = [NSDate date];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //NSString *nowTime = [formatter stringFromDate:date];
    
    //把返回的时间转化为nsdate
    NSDate *returnTime = [formatter dateFromString:timeArr[0]];
    
    //获得返回时间的时间chou
    long returnTimeleght =  [returnTime timeIntervalSince1970];
    
    //获得当前的时间戳
    
    long nowTimeleght = [date timeIntervalSince1970];
    
    //获得时间戳差
    long a = returnTimeleght-nowTimeleght;
    //当前时间比返回的时间大
    //    if (a>0)
    //    {
    //        //如果送货
    //
    //    }else
    //    {
    //
    //    }
    return a;
    
}
//获得1小时时间的差多少
//- (BOOL)gettimeDiffence:(MyOrderItems*)item
//{
//    long timeDiffence = [self getTimesReturnTime:item.deliveryTimeStart];
//    //送货时间大于现在的时间
//    if (timeDiffence>0) {
//
//        if (timeDiffence/60>=60) {
//            return YES;
//        }else
//        {
//            return NO;
//        }
//
//
//    }else
//    {
//        return NO;
//    }
//}

//- (BOOL)getDaytimeDiffence:(MyOrderItems*)item withIsquit:(BOOL)isQuit
//
//{
//    NSString*time;
//
//    if (isQuit) {
//
//
//        if (item.deliveryTimeEnd&&![item.deliveryTimeEnd isEqualToString:@""]) {
//            time = item.deliveryTimeEnd;
//        }else
//        {
//            time = item.deliveryTimeStart;
//        }
//    } else
//    {
//        time = item.deliveryTimeStart;
//    }
//    long timeDiffence = [self getTimesReturnTime:time];
//
//    if (timeDiffence<0) {
//        //当前时间大于上门时间＋7
//        if (-timeDiffence/60>(7*24*60)) {
//
//            return NO;
//        }else{
//
//            return YES;
//        }
//    }else
//    {
//        return NO;
//    }
//
//}



//输入框是否输入表情的判断
- (BOOL)stringContainsEmoji:(NSString *)string andMsg:(NSString *)msg
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    if(returnValue){
        
        [MBProgressHUD showWithMessage:msg];
    }
    return returnValue;
}

@end



