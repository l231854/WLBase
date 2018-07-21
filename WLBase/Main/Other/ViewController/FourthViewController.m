//
//  FourthViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/3/5.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "FourthViewController.h"
#define KCellHeight1 135.0/375*WIDTH
#define KCellHeight2 55.0/375*WIDTH
#define KCellHeight3 120.0/375*WIDTH
#define KCellHeight4 45.0/375*WIDTH

@interface FourthViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *arrayOfData;

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arrayOfData=[[NSMutableArray alloc] initWithObjects:@"1", @"我的店铺",@"3",@"打印设备",@"打印记录",@"打印标签",@"门店信息",@"联系客服",@"设置",nil];
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
    CGFloat heigth=KCellHeight4;
    if (indexPath.row==0) {
        heigth=KCellHeight1;
    }
    if (indexPath.row==2) {
        heigth=KCellHeight3;
    }
    if (indexPath.row==1||indexPath.row==3||indexPath.row==6) {
        heigth=KCellHeight2;

    }
    
   
    return heigth;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    if (indexPath.row==0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell1:cell AtIndexPath:indexPath];
    }
    else if (indexPath.row==1||indexPath.row==3||indexPath.row==6) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell2:cell AtIndexPath:indexPath];
    }
    else if (indexPath.row==2) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self createCell3:cell AtIndexPath:indexPath];
        }
    else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell4:cell AtIndexPath:indexPath];
    }
  
    return cell;
}
#pragma mark --创建cell
- (void)createCell1:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0,0, WIDTH, KCellHeight1);
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds=YES;
    view.layer.borderWidth=1.0;
    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [cell.contentView addSubview:view];
    
    UIImageView *imageView =[[UIImageView alloc] init];
    imageView.frame=CGRectMake(WLsize(10.0),(view.frame.size.height-WLsize(60.0))/2.0, WLsize(60.0), WLsize(60.0));
    imageView.image=[UIImage imageNamed:@""];
    imageView.backgroundColor=[UIColor grayColor];
    imageView.layer.masksToBounds=YES;
    imageView.layer.cornerRadius=imageView.frame.size.height/2.0;
    [view addSubview:imageView];
    UILabel *lbOfTitle = [[UILabel alloc] init];
    lbOfTitle.frame=CGRectMake(CGRectGetMaxX(imageView.frame)+WLsize(12.0), WLsize(45.0), WLsize(80.0), WLsize(26.0));
    lbOfTitle.textColor=WLTEXTCOLOR;
    lbOfTitle.font=[UIFont systemFontOfSize:WLsize(18.0)];
    lbOfTitle.textAlignment=NSTextAlignmentCenter;
    lbOfTitle.text=@"申请人名";
    [view addSubview:lbOfTitle];
    UIImageView *imageviewOfPhone = [[UIImageView alloc] init];
    imageviewOfPhone.frame= CGRectMake(lbOfTitle.frame.origin.x,CGRectGetMaxY(lbOfTitle.frame)+WLsize(11.0), WLsize(20.0), WLsize(20.0));
    imageviewOfPhone.image=[UIImage imageNamed:@""];
    imageviewOfPhone.backgroundColor=[UIColor grayColor];
    [view addSubview:imageviewOfPhone];
    
    UILabel *lbOfPhone = [[UILabel alloc] init];
    lbOfPhone.frame=CGRectMake(CGRectGetMaxX(imageviewOfPhone.frame), imageviewOfPhone.frame.origin.y, WLsize(100.0), WLsize(23.0));
    lbOfPhone.textColor=WLTEXTCOLOR;
    lbOfPhone.font=[UIFont systemFontOfSize:WLsize(14.0)];
    lbOfPhone.textAlignment=NSTextAlignmentCenter;
    NSString *showPhone  = @"13912340000";
    if (showPhone.length > 7) {
        
        showPhone = [showPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    lbOfPhone.text=showPhone;
    [view addSubview:lbOfPhone];
    
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.frame= CGRectMake(view.frame.size.width-WLsize(15)-8,(view.frame.size.height-13.0)/2.0, 8, 13);
    imageview.image=[UIImage imageNamed:@"dyp101"];
    [view addSubview:imageview];
}

- (void)createCell2:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, WLsize(10.0), WIDTH, KCellHeight2-WLsize(10.0));
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds=YES;
    view.layer.borderWidth=1.0;
    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [cell.contentView addSubview:view];
    UILabel *lbOfContent =[[UILabel alloc] init];
    lbOfContent.frame=CGRectMake(WLsize(10.0),0, WLsize(220.0), view.frame.size.height);
    lbOfContent.textColor=UIColorFromRGB(0x030303, 1);
//    lbOfContent.textAlignment=NSTextAlignmentCenter;
    lbOfContent.font=[UIFont systemFontOfSize:WLsize(17.0)];
    lbOfContent.text=[self.arrayOfData objectAtIndex:indexPath.row];
    [view addSubview:lbOfContent];
    
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.frame= CGRectMake(WIDTH-WLsize(15)-WLsize(8), (view.frame.size.height-WLsize(13.0))/2.0, WLsize(8), WLsize(13));
    imageview.image=[UIImage imageNamed:@"dyp101"];
    [view addSubview:imageview];
    UILabel *lbOfSee =[[UILabel alloc] init];
    lbOfSee.frame=CGRectMake(imageview.frame.origin.x-WLsize(40.0), 0, WLsize(33.0), view.frame.size.height);
    lbOfSee.textColor=UIColorFromRGB(0x999999, 1);
    lbOfSee.font=[UIFont systemFontOfSize:WLsize(14.0)];
    lbOfSee.text=@"预览";
    if (indexPath.row==1) {
        lbOfSee.hidden=NO;
    }
    else{
        lbOfSee.hidden=YES;

    }
    [view addSubview:lbOfSee];
}
- (void)createCell3:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, WLsize(10.0), WIDTH, KCellHeight3-WLsize(10.0));
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds=YES;
    view.layer.borderWidth=1.0;
    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [cell.contentView addSubview:view];
    CGFloat ww =WIDTH/4.0;
    NSArray *temp = [[NSArray alloc] initWithObjects:@"分类管理",@"智能推荐",@"员工管理",@"评价管理", nil];
    for (int i=0; i<4; i++) {
        UIView *view1 = [[UIView alloc] init];
        view1.frame=CGRectMake(ww*i, 0, ww, view.frame.size.height);
        view1.userInteractionEnabled=YES;
        view1.tag=i+1;
        UITapGestureRecognizer *ges =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCategory:)];
        [view1 addGestureRecognizer:ges];
        [view addSubview:view1];
        UIImageView *imageView =[[UIImageView alloc] init];
        imageView.frame=CGRectMake((view1.frame.size.width-WLsize(60.0))/2.0,WLsize(8.0), WLsize(60.0), WLsize(60.0));
        imageView.image=[UIImage imageNamed:@""];
        imageView.backgroundColor=[UIColor grayColor];
        imageView.layer.masksToBounds=YES;
        imageView.layer.cornerRadius=imageView.frame.size.height/2.0;
        [view1 addSubview:imageView];
        UILabel *lbOfTitle = [[UILabel alloc] init];
        lbOfTitle.frame=CGRectMake(0,CGRectGetMaxY(imageView.frame)+WLsize(8.0), view1.frame.size.width, WLsize(23.0));
        lbOfTitle.textColor=WLTEXTCOLOR;
        lbOfTitle.font=[UIFont systemFontOfSize:WLsize(14.0)];
        lbOfTitle.textAlignment=NSTextAlignmentCenter;
        lbOfTitle.text=[temp objectAtIndex:i];
        [view1 addSubview:lbOfTitle];
    }
}

- (void)createCell4:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, 0, WIDTH, KCellHeight4);
    view.backgroundColor=[UIColor whiteColor];
//    view.layer.masksToBounds=YES;
//    view.layer.borderWidth=1.0;
//    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [cell.contentView addSubview:view];
    UILabel *lbOfContent =[[UILabel alloc] init];
    lbOfContent.frame=CGRectMake(WLsize(10.0),0, WLsize(220.0), view.frame.size.height);
    lbOfContent.textColor=UIColorFromRGB(0x030303, 1);
    lbOfContent.font=[UIFont systemFontOfSize:WLsize(17.0)];
    lbOfContent.text=[self.arrayOfData objectAtIndex:indexPath.row];
    [view addSubview:lbOfContent];
    
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.frame= CGRectMake(WIDTH-WLsize(15)-WLsize(8), (view.frame.size.height-WLsize(13.0))/2.0, WLsize(8), WLsize(13));
    imageview.image=[UIImage imageNamed:@"dyp101"];
    [view addSubview:imageview];
    
    UILabel *seplb =[[UILabel alloc] init];
    seplb.frame=CGRectMake(0, KCellHeight4-1, WIDTH, 1.0);
    seplb.backgroundColor=UIColorFromRGB(0xBBBBBB, 1);
    [view addSubview:seplb];
}


#pragma mark --
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            NSLog(@"0");
            break;
        case 1:
            NSLog(@"1");
            break;
        case 3:
            NSLog(@"3");
            break;
        case 4:
            NSLog(@"4");
            break;
        case 5:
            NSLog(@"5");
            break;
        case 6:
            NSLog(@"6");
            break;
        case 7:
            NSLog(@"7");
            break;
        case 8:
            NSLog(@"8");
            break;
        default:
            break;
    }
    
}

#pragma mark --点击第三个cell
- (void)clickCategory:(UIGestureRecognizer *)ges
{
    NSInteger tag =[ges view].tag;
    NSLog(@"%ld",tag);
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
