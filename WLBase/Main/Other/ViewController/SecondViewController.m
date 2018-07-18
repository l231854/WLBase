//
//  SecondViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/3/5.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "SecondViewController.h"
#import "OtherViewController.h"
#define WLPageIndex 20
#import "HomeBannerModel.h"
#import "HomeBannerView.h"
#import "HomeHeadTitleModel.h"
#import "XCJDTopListHeadView.h"
#define KHeadTitleHeight 65
#define KHeadImageHeight 300

#define KBannerHeight 130.0/375*WIDTH
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UIScrollView *scrolView;

@property (strong,nonatomic) UIView *headViewTitle;
@property (strong,nonatomic) UIView *headViewOfImage;

@property (strong,nonatomic) UIView *bannerView;
//最上面的
@property (strong,nonatomic) NSMutableArray *arrayOfDataTitle;
//场景豆腐块
@property (strong,nonatomic) NSMutableArray *arrayOfDataImage;
@property (strong,nonatomic) NSMutableArray *arrayOfDataContent;

//当前选中的
@property (nonatomic,assign)     NSInteger                            isSelectType;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arrayOfDataImage=[[NSMutableArray alloc] initWithObjects:@"icon111",@"icon22",@"icon32",@"icon42",@"icon52",@"icon62",@"icon72",@"icon82",@"tj2", nil];
    self.arrayOfDataContent=[[NSMutableArray alloc] initWithObjects:@"打开卧室灯",@"关闭客厅吊灯",@"打开吊灯",@"关闭吊灯",@"打开筒灯",@"关闭筒灯",@"打开背景灯",@"关闭背景灯",@"tj2", nil];

    self.isSelectType=1;
    self.arrayOfDataTitle = [[NSMutableArray alloc] init];
    HomeHeadTitleModel *mt1 = [[HomeHeadTitleModel alloc] init];
    mt1.title=@"一键场景";
    mt1.strID=@"1";
    [self.arrayOfDataTitle addObject:mt1];
    HomeHeadTitleModel *mt2 = [[HomeHeadTitleModel alloc] init];
    mt2.title=@"定制场景";
    mt2.strID=@"2";
    [self.arrayOfDataTitle addObject:mt2];
    HomeHeadTitleModel *mt3 = [[HomeHeadTitleModel alloc] init];
    mt3.title=@"联动场景";
    mt3.strID=@"3";
    [self.arrayOfDataTitle addObject:mt3];

    [self sendRequest];
    
}





#pragma mark -- createUI
- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrolView = [[UIScrollView alloc] init];
    if (self.scrolView==nil) {
        self.scrolView = [[UIScrollView alloc] init];
        
    }
 
        self.scrolView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-XCTbaBar);
    self.scrolView.backgroundColor = [UIColor whiteColor];
    self.scrolView.scrollEnabled=YES;
    self.scrolView.userInteractionEnabled=YES;
    [self.view addSubview:self.scrolView];
    if (self.headViewTitle==nil) {
        self.headViewTitle = [[UIView alloc] init];
        
    }
    else{
        for (UIView *v in [self.headViewTitle subviews]) {
            [v removeFromSuperview];
        }
    }
    
    self.headViewTitle.frame=CGRectMake(0, XCStatusBar+20, WIDTH, KHeadTitleHeight);
    self.headViewTitle.backgroundColor = [UIColor redColor];
    [self.scrolView addSubview:self.headViewTitle];
    XCJDTopListHeadView *headView = [[XCJDTopListHeadView alloc] init];
    headView.frame = CGRectMake(0, 0, self.headViewTitle.frame.size.width, self.headViewTitle.frame.size.height);
    headView.count=3;
    headView.selectIndex=self.isSelectType;
    headView.arrayOfData = self.arrayOfDataTitle;
    __weak typeof(self)weakSelf = self;
    headView.clickCategory = ^(id strTitle, NSInteger tag) {
        NSLog(@"%ld",tag);
        //        weakSelf.isSelectType=tag;
        //        weakSelf.pageIndexpage=1;
        //        [weakSelf sendRequestOfData:weakSelf.isSelectType];
    };
    [self.headViewTitle addSubview:headView];
    
 
    
    
}
#pragma mark -- 请求数据
- (void)sendRequest
{
    [self createUI];
    [self createBannerView];
}

#pragma mark--创建bannerView
- (void)createBannerView
{
    NSInteger Count = self.arrayOfDataContent.count/3+self.arrayOfDataContent.count%3>0?1:0;
    if (self.bannerView==nil) {
        self.bannerView = [[UIView alloc] init];
    }
    else{
        for (UIView *v in [self.bannerView subviews]) {
            [v removeFromSuperview];
        }
    }
    self.bannerView.frame = CGRectMake(0, CGRectGetMaxY(self.headViewTitle.frame), WIDTH, Count*KBannerHeight);
    CGFloat width = WIDTH/3.0;
    __weak typeof(self)weakSelf = self;
    for (int i=0; i<self.arrayOfDataContent.count;i++) {
        NSString *content =[self.arrayOfDataContent objectAtIndex:i];
        NSString *image = [self.arrayOfDataImage objectAtIndex:i];
        UIView *view1 = [[UIView alloc] init];
        view1.frame=CGRectMake(i%3*width, i/3*KBannerHeight, width, KBannerHeight);
        view1.tag=i;
        view1.userInteractionEnabled=YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
        [view1 addGestureRecognizer:ges];
        [self.bannerView addSubview:view1];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame=CGRectMake(10, 10, width-20, KBannerHeight-20);
        [imageView setImage:[UIImage imageNamed:image]];
        [view1 addSubview:imageView];
        UILabel *lbOfContent = [[UILabel alloc] init];
        lbOfContent.frame = CGRectMake(10, KBannerHeight-40, width-20, 30);
        lbOfContent.font=[UIFont systemFontOfSize:14];
        lbOfContent.textAlignment=NSTextAlignmentCenter;
        lbOfContent.textColor=[UIColor whiteColor];
        lbOfContent.text=content;
        [view1 addSubview:lbOfContent];
        
    }
    [self.scrolView addSubview:self.bannerView];
    if (IOS11) {
        self.scrolView.contentSize = CGSizeMake(WIDTH, CGRectGetMaxY(self.bannerView.frame)+TabBarHeight+XCStatusBar*2);
        
    }
    else{
        self.scrolView.contentSize = CGSizeMake(WIDTH, CGRectGetMaxY(self.bannerView.frame)+XCStatusBar*2);
        
    }
    
}

#pragma mark --点击view的手势
- (void)clickView:(UIGestureRecognizer *)ges
{
    NSLog(@"%ld",[ges view].tag);
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

    self.tabBarController.title =@"场景客厅";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{
       NSForegroundColorAttributeName :[UIColor blackColor],
       NSFontAttributeName : [UIFont systemFontOfSize:36/2]
       }];
    [self createNavigationItem];
}
#pragma mark---UI
- (void)createNavigationItem{
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame=CGRectMake(0, 0, 40, 40);
//    [right setTitle:@"right" forState:UIControlStateNormal];
    [right setImage:[UIImage imageNamed:@"icon11"] forState:UIControlStateNormal];
    [right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(clickLeft) forControlEvents:UIControlEventTouchUpInside];
    self.tabBarController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
}


#pragma mark --- 方法
- (void)clickLeft
{
    OtherViewController *vc = [[OtherViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.title =nil;
    self.tabBarController.navigationItem.rightBarButtonItem =nil;

}


@end
