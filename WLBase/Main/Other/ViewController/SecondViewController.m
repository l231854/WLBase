//
//  SecondViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/3/5.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "SecondViewController.h"
#import "WLShopInformationViewController.h"
#define KCellHeight WLsize(90.0)
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *arrayOfData;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arrayOfData=[[NSMutableArray alloc] initWithObjects:@"订单管理", @"资金管理",nil];
    [self createUI];
    
    
}
#pragma mark --createUI
#pragma mark--- 创建UI
- (void)createUI
{
    if (self.tableview==nil) {
        self.tableview=[[UITableView alloc] init];
    }
    self.tableview.frame=CGRectMake(0, XCStatusBar, WIDTH, HEIGHT-XCStatusBar-XCTbaBar);
    self.tableview.backgroundColor=[UIColor whiteColor];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigth=KCellHeight;
 
    return heigth;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self createCell1:cell AtIndexPath:indexPath];
    return cell;
}
#pragma mark --创建cell
- (void)createCell1:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(WLsize(10.0), WLsize(10.0), WIDTH-WLsize(20.0), KCellHeight-WLsize(10.0));
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds=YES;
    view.layer.borderWidth=1.0;
    view.layer.cornerRadius=10.0;
    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [cell.contentView addSubview:view];
    UIImageView *imageView =[[UIImageView alloc] init];
    imageView.frame=CGRectMake(WLsize(20.0),(view.frame.size.height-WLsize(60.0))/2.0, WLsize(60.0), WLsize(60.0));
    imageView.image=[UIImage imageNamed:@""];
    imageView.backgroundColor=[UIColor grayColor];
    imageView.layer.masksToBounds=YES;
    imageView.layer.cornerRadius=imageView.frame.size.height/2.0;
    [view addSubview:imageView];
    UILabel *lbOfTitle = [[UILabel alloc] init];
    lbOfTitle.frame=CGRectMake(CGRectGetMaxX(imageView.frame)+WLsize(10.0), 0, WLsize(70.0), view.frame.size.height);
    lbOfTitle.textColor=WLTEXTCOLOR;
    lbOfTitle.font=[UIFont systemFontOfSize:WLsize(14.0)];
    lbOfTitle.textAlignment=NSTextAlignmentCenter;
    lbOfTitle.text=[self.arrayOfData objectAtIndex:indexPath.row];
    [view addSubview:lbOfTitle];
    
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.frame= CGRectMake(view.frame.size.width-WLsize(15)-8,(view.frame.size.height-13.0)/2.0, 8, 13);
    imageview.image=[UIImage imageNamed:@"dyp101"];
    [view addSubview:imageview];
}

#pragma mark --
 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        WLShopInformationViewController *vc =[[WLShopInformationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
    
    self.tabBarController.title =@"订单管理";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{
       NSForegroundColorAttributeName :[UIColor blackColor],
       NSFontAttributeName : [UIFont systemFontOfSize:36/2]
       }];
    //    [self createNavigationItem];
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
