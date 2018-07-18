//
//  ThirdViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/3/5.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "ThirdViewController.h"
#import "WLChatViewController.h"
@interface ThirdViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *arrayOfData;
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arrayOfData = [[NSMutableArray alloc] initWithObjects:@"1",@"1",@"1",@"1",@"1", nil];
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;

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

    self.tabBarController.title =@"小智机器人";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{
       NSForegroundColorAttributeName :[UIColor blackColor],
       NSFontAttributeName : [UIFont systemFontOfSize:36/2]
       }];
}

#pragma mark --createUI
- (void)createUI{
    self.scrollView =[[UIScrollView alloc] init];
    self.scrollView.delegate=self;
    self.scrollView.frame=CGRectMake(0, 0, WIDTH, HEIGHT-XCTbaBar);
    self.scrollView.contentSize = CGSizeMake(WIDTH*self.arrayOfData.count, 0);
    //设置在拖拽的时候是否锁定其在水平或者垂直的方向
    self.scrollView.directionalLockEnabled = NO;
    //设置是否可以进行画面切换
    self.scrollView.pagingEnabled = YES;

    //隐藏滚动条设置（水平、跟垂直方向）
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    for (int i=0; i<self.arrayOfData.count; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame=CGRectMake(WIDTH*i, 0, WIDTH, self.scrollView.frame.size.height);
        view.backgroundColor=DEFAULT_BackgroundView_COLOR;
        UIView *view1 = [[UIView alloc] init];
        view1.backgroundColor = [UIColor whiteColor];
        view1.frame = CGRectMake(10, 10, WIDTH-20, view.frame.size.height-20);
        [view addSubview:view1];
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.frame = CGRectMake((view1.frame.size.width-124)/2.0, 150/667.0*HEIGHT, 124, 184);
        imageview.image =[UIImage imageNamed:@"jqrp64"];
        [view1 addSubview:imageview];
        
        UIButton *btn1 =[[UIButton alloc] init];
        btn1.frame=CGRectMake(50, CGRectGetMaxY(imageview.frame)+60.0/667*HEIGHT, WIDTH-100, 44);
        [btn1 setTitle:[NSString stringWithFormat:@"机器人小智%d号",i+1] forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn1 setBackgroundImage:[UIImage imageNamed:@"bntp64"] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        btn1.tag=i;
        [view1 addSubview:btn1];
        [self.scrollView addSubview:view];
    }
}
#pragma mark --点击button
-(void)clickButton:(UIButton *)btn
{
    NSLog(@"%ld",btn.tag);
    WLChatViewController *vc = [[WLChatViewController alloc] init];
    vc.title=btn.titleLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    self.tabBarController.navigationItem.titleView = nil;
    self.tabBarController.title = nil;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
