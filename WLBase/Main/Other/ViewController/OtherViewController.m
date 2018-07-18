//
//  OtherViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/3/7.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "OtherViewController.h"
#define KCELLHEIGHT 60
@interface OtherViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrayOfData;
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arrayOfData = [[NSMutableArray alloc] initWithObjects:@"房间管理",@"安全锁", @"数据备份", @"数据分享", @"消息记录", @"固件升级管理", @"网络测试", @"关于我们", nil];
    [self createUI];
   
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

    self.tabBarController.title =@"我的";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{
       NSForegroundColorAttributeName :[UIColor blackColor],
       NSFontAttributeName : [UIFont systemFontOfSize:36/2]
       }];
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

#pragma mark --createUI
- (void)createUI
{
    if (self.tableView==nil) {
        self.tableView = [[UITableView alloc] init];
    }
    self.tableView.frame = CGRectMake(0, XCStatusBar, WIDTH, HEIGHT-XCStatusBar-XCTbaBar);
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count=9;

    
    return count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=KCELLHEIGHT;
    if (indexPath.row==0) {
        height=70;
    }
   
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        [self createCell1:cell cellForRowAtIndexPath:indexPath];

    }
    else{
        [self createCell2:cell cellForRowAtIndexPath:indexPath];

    }
    return cell;
    
}
-(NSString *)numberSuitScanf:(NSString*)number{
    
        NSString *numberString = [number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        
        return numberString;
        
}
#pragma mark -- createCell
- (void)createCell1:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *lb1 =[[UILabel alloc] init];
    lb1.text=[MobileData sharedInstance].custNickName;
    lb1.frame=CGRectMake(15, 0, 200, 35);
    lb1.textColor=UIColorFromRGB(0x333333, 1);
    lb1.font=[UIFont systemFontOfSize:18 weight:18];
    lb1.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:lb1];
    
    UILabel *lb2 =[[UILabel alloc] init];
    lb2.text=[self numberSuitScanf:[MobileData sharedInstance].custPhone];
    lb2.frame=CGRectMake(lb1.frame.origin.x, CGRectGetMaxY(lb1.frame), 200, 35);
    lb2.textAlignment=NSTextAlignmentLeft;
    lb2.textColor=UIColorFromRGB(0x999999, 1);
    lb2.font=[UIFont systemFontOfSize:15];
    [cell.contentView addSubview:lb2];
    
    
}
- (void)createCell2:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view1 =[[UIView alloc] init];
    view1.frame = CGRectMake(10,(KCELLHEIGHT-44)/2.0, 44, 44);
    view1.layer.masksToBounds=YES;
    view1.layer.cornerRadius=view1.frame.size.width/2.0;
    //    view1.backgroundColor = WLTabbarSelectedColor;
    [cell.contentView addSubview:view1];
    UIImageView *imageView1=[[UIImageView alloc] init];
    imageView1.frame=CGRectMake(9.0/2, 9.0/2, 35, 35);
    imageView1.image = [UIImage imageNamed:@"icon1p10"];
    [view1 addSubview:imageView1];
    
    UILabel *lbOfContent = [[UILabel alloc] init];
    lbOfContent.frame=CGRectMake(CGRectGetMaxX(view1.frame)+10, 0, 150, KCELLHEIGHT);
    lbOfContent.text=[self.arrayOfData objectAtIndex:indexPath.row-1];
    lbOfContent.textColor=[UIColor blackColor];
    lbOfContent.font=[UIFont systemFontOfSize:16];
    [cell.contentView addSubview:lbOfContent];
    
    
    UIImageView *imageView2=[[UIImageView alloc] init];
    imageView2.frame=CGRectMake(WIDTH-30, (60-15)/2.0, 9, 15);
    imageView2.image = [UIImage imageNamed:@"dyp101"];
    [cell.contentView addSubview:imageView2];
    
    
    
    UILabel *lbOfSep = [[UILabel alloc] init];
    lbOfSep.frame=CGRectMake(view1.frame.origin.x, 59, WIDTH-view1.frame.origin.x*2, 1.0);
    lbOfSep.backgroundColor=UIColorFromInt(210, 210, 210, 1);

    [cell.contentView addSubview:lbOfSep];
}
- (void)didReceiveMemoryWarning {
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
