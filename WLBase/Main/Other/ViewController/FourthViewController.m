//
//  FourthViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/3/5.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "FourthViewController.h"
#import "WLDrivceModel.h"
#define KCELLHEIGHT 60
@interface FourthViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrayOfData;
@property (nonatomic,strong) NSMutableArray *arrayOfData1;
@property (nonatomic,strong) NSMutableArray *arrayOfDataClick;

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"小智主机",@"小智机器人",@"摄像头",@"小智分机",@"物联中继器",@"智能魔镜",@"智能净水器",@"红外控制器",@"智能单火开关",@"智能零火开关",@"智能插座",@"智能窗帘",@"情景面板",@"情景遥控器",@"推窗器",@"智能门锁",@"智能猫眼",@"门窗感应器",@"人体探测器",@"燃气报警器",@"烟雾报警器",@"一氧化碳报警器",@"水渍报警器",@"声光报警器",@"智能机械手",@"温湿度传感器",@"风雨传感器",@"PM2.5检测器",@"其他设备", nil];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (int i=0; i<array.count; i++) {
        WLDrivceModel *model = [[WLDrivceModel alloc] init];
        model.title=[array objectAtIndex:i];
        model.imageUrl=[NSString stringWithFormat:@"icon%dp10",i+1];
        model.number=[NSString stringWithFormat:@"%d",i];
        [temp addObject:model];
    }
    self.arrayOfData=[[NSMutableArray alloc] initWithArray:temp];
    self.arrayOfDataClick=[[NSMutableArray alloc] init];

    [self createUI];
    [self sendRequest];
    
}
- (void)createNavigationItem{
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame=CGRectMake(0, 0, 40, 40);
    [right setImage:[UIImage imageNamed:@"tjp7"] forState:UIControlStateNormal];
    [right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
}


#pragma mark --- 方法
- (void)clickRight
{
    NSLog(@"clickRight");
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

    self.tabBarController.title =@"设备列表";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{
       NSForegroundColorAttributeName :[UIColor blackColor],
       NSFontAttributeName : [UIFont systemFontOfSize:36/2]
       }];
    [self createNavigationItem];
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
#pragma mark --请求数据
- (void)sendRequest
{
    [self.tableView reloadData];
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
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count=0;
    if (section==0) {
        count=7;
    }else if (section==1)
    {
        count=8;
    }
    else if (section==2)
    {
        count=10;
    }
    else if (section==3)
    {
        count=3;
    }
    else if (section==4)
    {
        count=1;
    }
    if (self.arrayOfDataClick.count>0) {
        for (NSString *str in self.arrayOfDataClick) {
            if (section==[str integerValue]) {
                count=0;
            }
        }
    }

    return count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=KCELLHEIGHT;
    
    if (self.arrayOfDataClick.count>0) {
        for (NSString *str in self.arrayOfDataClick) {
            if (indexPath.section==[str integerValue]) {
                height=0;
            }
        }
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat heigth=0;
    if (section>0) {
        heigth=44;
    }
    return heigth;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView;
    if (section>0) {
        NSString *strContent=@"";
        switch (section) {
            case 1:
                strContent=@"控制类（18）";
                break;
            case 2:
                strContent=@"安防类（18）";
                break;
            case 3:
                strContent=@"环境采样（9）";
                break;
            case 4:
                strContent=@"其他（2）";
                break;
                
            default:
                break;
        }
        
        headView = [[UIView alloc] init];
        headView.frame = CGRectMake(0, 0, WIDTH, 44);
        headView.backgroundColor = [UIColor whiteColor];
        UILabel *lbOfType = [[UILabel alloc] init];
        lbOfType.frame=CGRectMake(10, 0, 200, 44);
        lbOfType.textColor = UIColorFromRGB(0x999999, 1);
        lbOfType.font=[UIFont systemFontOfSize:16];
        lbOfType.text=strContent;
        [headView addSubview:lbOfType];
        
        UIView *view1 = [[UIView alloc] init];
        view1.frame=CGRectMake(WIDTH-95, 0, 80, 44);
        view1.userInteractionEnabled=YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPackup:)];
        view1.tag=section;
        [view1 addGestureRecognizer:ges];
        [headView addSubview:view1];
        UIImageView *imageView1 = [[UIImageView alloc] init];
        imageView1.frame=CGRectMake(view1.frame.size.width-14, (view1.frame.size.height-9)/2.0, 14, 9);
        imageView1.image=[UIImage imageNamed:@"slp10"];
        [view1 addSubview:imageView1];
        UILabel *lb1 = [[UILabel alloc] init];
        lb1.frame=CGRectMake(0, 0, view1.frame.size.width-imageView1.frame.size.width, view1.frame.size.height);
        lb1.textColor=WLTabbarSelectedColor;
        lb1.font =[UIFont systemFontOfSize:14];
        lb1.text=@"收起";
        lb1.textAlignment=NSTextAlignmentRight;
        [view1 addSubview:lb1];
    }
    return headView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self createCell1:cell cellForRowAtIndexPath:indexPath];
    return cell;
    
}
#pragma mark -- createCell
- (void)createCell1:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count =0;
    switch (indexPath.section) {
        case 0:
            count=indexPath.row;
            break;
        case 1:
            count=indexPath.row+7;

            break;
        case 2:
            count=indexPath.row+15;

            break;
        case 3:
            count=indexPath.row+25;

            break;
        case 4:
            count=indexPath.row+28;

            break;
            
        default:
            break;
    }
    WLDrivceModel *model =[self.arrayOfData objectAtIndex:count];
    UIView *view1 =[[UIView alloc] init];
    view1.frame = CGRectMake(10,(KCELLHEIGHT-44)/2.0, 44, 44);
    view1.layer.masksToBounds=YES;
    view1.layer.cornerRadius=view1.frame.size.width/2.0;
//    view1.backgroundColor = WLTabbarSelectedColor;
    [cell.contentView addSubview:view1];
    UIImageView *imageView1=[[UIImageView alloc] init];
    imageView1.frame=CGRectMake(9.0/2, 9.0/2, 35, 35);
    imageView1.image = [UIImage imageNamed:model.imageUrl];
    [view1 addSubview:imageView1];
    
    UILabel *lbOfContent = [[UILabel alloc] init];
    lbOfContent.frame=CGRectMake(CGRectGetMaxX(view1.frame)+10, 0, 150, KCELLHEIGHT);
    lbOfContent.text=model.title;
    lbOfContent.textColor=[UIColor blackColor];
    lbOfContent.font=[UIFont systemFontOfSize:16];
    [cell.contentView addSubview:lbOfContent];
    
    
    UIImageView *imageView2=[[UIImageView alloc] init];
    imageView2.frame=CGRectMake(WIDTH-30, (60-15)/2.0, 9, 15);
    imageView2.image = [UIImage imageNamed:@"dyp101"];
    [cell.contentView addSubview:imageView2];
    
    UILabel *lbOfNumber = [[UILabel alloc] init];
    lbOfNumber.frame=CGRectMake(imageView2.frame.origin.x-60, 0, 50, 60);
    lbOfNumber.textColor=UIColorFromRGB(0x999999, 1);
    lbOfNumber.font=[UIFont systemFontOfSize:14];
    lbOfNumber.text=model.number;
    lbOfNumber.textAlignment=NSTextAlignmentRight;
    [cell.contentView addSubview:lbOfNumber];
    
    UILabel *lbOfSep = [[UILabel alloc] init];
    lbOfSep.frame=CGRectMake(view1.frame.origin.x, 59, WIDTH-view1.frame.origin.x*2, 1.0);
    lbOfSep.backgroundColor=UIColorFromInt(210, 210, 210, 1);
   
    [cell.contentView addSubview:lbOfSep];
}


#pragma mark --点击收起按钮
- (void)clickPackup:(UIGestureRecognizer *)ges
{
    NSInteger tag = [ges view].tag;
    for (NSString *str in self.arrayOfDataClick) {
        if ([str integerValue]==tag) {
            [self.arrayOfDataClick removeObject:str];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:tag] withRowAnimation:UITableViewRowAnimationNone];
            return;
        }
    }
    [self.arrayOfDataClick addObject:[NSString stringWithFormat:@"%ld",tag]];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:tag] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
