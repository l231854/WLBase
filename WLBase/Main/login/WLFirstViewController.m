//
//  WLFirstViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/19.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLFirstViewController.h"
#import "WLRegisterViewController.h"
#import "WLLoginViewController.h"
#define KCellHeight1 140.0/375*WIDTH
#define KCellHeight2 161.0/375*WIDTH
#define KCellHeight3 159.0/375*WIDTH
#define KCellHeight4 94.0/375*WIDTH
#define KCellHeight5 211.0/375*WIDTH
#define KCellHeight6 49.0/375*WIDTH
@interface WLFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) BannerView *banner;

@end

@implementation WLFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationItem];
//    self.view.backgroundColor=[UIColor whiteColor];
    [self createUI];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavigationItem];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
//    [self.navigationController.navigationBar lt_reset];
}
- (void)initNavigationItem
{
    
    self.isNeedWhite = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
//    self.tabBarController.navigationItem.leftBarButtonItem = nil;
//    self.tabBarController.navigationItem.rightBarButtonItem = nil;
//    self.tabBarController.navigationItem.titleView = nil;
//    self.tabBarController.title = nil;
//    UINavigationController *nav = self.tabBarController.navigationController;
//    UIColor *color = DEFAULT_BackgroundView_COLOR;
//    [nav.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
//    [nav.navigationBar hideLineOfNavtionBar];

}
#pragma mark--- 创建UI
- (void)createUI
{
    if (self.tableview==nil) {
        self.tableview=[[UITableView alloc] init];
    }
    self.tableview.frame=CGRectMake(0, 20, WIDTH, HEIGHT-20);
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
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigth=0;
    switch (indexPath.row) {
        case 0:
            heigth=KCellHeight1;
            break;
        case 1:
            heigth=KCellHeight2;
            break;
        case 2:
            heigth=KCellHeight3;
            break;
        case 3:
            heigth=KCellHeight4;
            break;
        case 4:
            heigth=KCellHeight5;
            break;
        case 5:
            heigth=KCellHeight6;
            break;
        default:
            break;
    }
    return heigth;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    switch (indexPath.row) {
        case 0:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self createCell1:cell AtIndexPath:indexPath];
            break;
        case 1:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self createCell2:cell AtIndexPath:indexPath];
            break;
        case 2:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self createCell3:cell AtIndexPath:indexPath];
            break;
        case 3:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self createCell4:cell AtIndexPath:indexPath];
            break;
        case 4:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self createCell5:cell AtIndexPath:indexPath];
            break;
        case 5:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self createCell6:cell AtIndexPath:indexPath];
            break;
        
            
        default:
            break;
    }
    return cell;
}

#pragma mark --创建cell
- (void)createCell1:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor=DEFAULT_BackgroundView_COLOR;
    UILabel *lb1 =[[UILabel alloc] init];
    lb1.frame=CGRectMake(WLsize(10.0), 7.0/375*WIDTH, WIDTH, 23.0/375*WIDTH);
    lb1.font=[UIFont systemFontOfSize:14.0/375*WIDTH];
    lb1.textColor=UIColorFromRGB(0x101010, 1);
    lb1.text=@"欢迎使用我家餐厅商家后台";
    [cell.contentView addSubview:lb1];
    CGFloat w1=WIDTH/3.0;
    CGFloat h1=100.0/375*WIDTH;
    CGFloat seph1=KCellHeight1-h1;
    for (int i=0; i<3; i++) {
        UIView *view =[[UIView alloc] init];
        view.frame=CGRectMake(w1*i, seph1, w1, h1);
        [cell.contentView addSubview:view];
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.frame=CGRectMake(49.0/375*WIDTH, 30.0/375*WIDTH, 30.0/375*WIDTH,30.0/375*WIDTH);
        imageview.image=[UIImage imageNamed:@""];
        imageview.backgroundColor=[UIColor whiteColor];
        [view addSubview:imageview];
        UILabel *lbOfText = [[UILabel alloc]init];
        lbOfText.frame=CGRectMake(0, CGRectGetMaxY(imageview.frame)+3.0/375*WIDTH,w1 ,23.0/375*WIDTH);
        lbOfText.font=[UIFont systemFontOfSize:WLsize(14.0)];
        lbOfText.textColor=UIColorFromRGB(0x101010, 1);
        NSString *strContent=@"";
        switch (i) {
            case 0:
                strContent=@"买单收款";
                break;
            case 1:
                strContent=@"订单管理";
                break;
            case 2:
                strContent=@"帮客点餐";
                break;
            default:
                break;
        }
        lbOfText.text=strContent;
        lbOfText.textAlignment=NSTextAlignmentCenter;
        [view addSubview:lbOfText];
    }
}
- (void)createCell2:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, WLsize(11.0), WIDTH, KCellHeight2-WLsize(11.0));
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds=YES;
    view.layer.borderWidth=1.0;
    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [cell.contentView addSubview:view];
    NSMutableArray *arrofData = [[NSMutableArray alloc] init];
    HomeBannerModel *model1 = [[HomeBannerModel alloc] init];
    model1.headImageUrl=@"http://img.zcool.cn/community/0142135541fe180000019ae9b8cf86.jpg@1280w_1l_2o_100sh.png";
    model1.processId=@"1";
    [arrofData addObject:model1];
    HomeBannerModel *model2 = [[HomeBannerModel alloc] init];
    model2.headImageUrl=@"http://img05.tooopen.com/images/20150820/tooopen_sy_139205349641.jpg";
    model2.processId=@"1";

    [arrofData addObject:model2];
    
    self.banner =  [[BannerView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, view.frame.size.height) andDataOfHomePageMedel:arrofData withViewController:self isNeedSeparator:NO];
    [view addSubview:self.banner];

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
    CGFloat rw=44.0/375*WIDTH;
    CGFloat ballD=WLsize(20.0);
    CGFloat linew=(WIDTH-ballD*3-rw*2)/2.0;
    CGFloat rh=WLsize(24.0);
    CGFloat lbW = WLsize(100.0);
    for (int i=0; i<3; i++) {
        UIView *viewOfBall = [[UIView alloc] init];
        viewOfBall.frame=CGRectMake(rw+(ballD+linew)*i,rh,ballD, ballD);
        viewOfBall.layer.masksToBounds=YES;
        viewOfBall.layer.cornerRadius=ballD/2.0;
        viewOfBall.layer.borderWidth=1.0;
        viewOfBall.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
        [view addSubview:viewOfBall];
        if (i<2) {
            UILabel *lbOfLine = [[UILabel alloc] init];
            lbOfLine.frame=CGRectMake(CGRectGetMaxX(viewOfBall.frame), viewOfBall.frame.origin.y+ballD/2.0-1.0/2,linew, 1.0);
            lbOfLine.backgroundColor=UIColorFromRGB(0xBBBBBB, 1);
            [view addSubview:lbOfLine];
        }
        UILabel *lbOfTitle = [[UILabel alloc] init];
        lbOfTitle.frame=CGRectMake(viewOfBall.center.x-lbW/2.0, CGRectGetMaxY(viewOfBall.frame)+WLsize(9.0), lbW, WLsize(23.0));
        lbOfTitle.textAlignment=NSTextAlignmentCenter;
        lbOfTitle.textColor=UIColorFromRGB(0x101010, 1);
        lbOfTitle.font=[UIFont systemFontOfSize:WLsize(14.0)];
        NSString *strContent=@"";
        switch (i) {
            case 0:
                strContent=@"注册账号";
                break;
            case 1:
                strContent=@"认领门店";
                break;
            case 2:
                strContent=@"提交资质";
                break;
            default:
                break;
        }
        lbOfTitle.text=strContent;
        [view addSubview:lbOfTitle];
       
        
    }
    UIButton *btnOfRegister =[[UIButton alloc] init];
    btnOfRegister.frame=CGRectMake((WIDTH-WLsize(80.0))/2.0, WLsize(106.0), WLsize(80.0), WLsize(30.0));
    btnOfRegister.layer.masksToBounds=YES;
    btnOfRegister.layer.cornerRadius=WLsize(4.0);
    btnOfRegister.layer.borderWidth=1.0;
    btnOfRegister.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [btnOfRegister setTitle:@"立即注册" forState:UIControlStateNormal];
    [btnOfRegister setTitleColor:UIColorFromRGB(0x101010, 1) forState:UIControlStateNormal];
    btnOfRegister.titleLabel.font=[UIFont systemFontOfSize:WLsize(14.0)];
    [btnOfRegister addTarget:self action:@selector(clickRegister) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnOfRegister];
}
#pragma mark ---点击立即注册
- (void)clickRegister
{
    WLRegisterViewController *vc = [[WLRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)createCell4:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, WLsize(12.0), WIDTH, KCellHeight4-WLsize(12.0));
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds=YES;
    view.layer.borderWidth=1.0;
    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [cell.contentView addSubview:view];
    
    UILabel *lb1 = [[UILabel alloc] init];
    lb1.frame=CGRectMake(WLsize(10.0),0, WLsize(170.0),WLsize(38.0));
    lb1.textColor=UIColorFromRGB(0x101010, 1);
    lb1.font=[UIFont systemFontOfSize:WLsize(16.0)];
    lb1.text=@"全网流量，多渠道获客";
    [view addSubview:lb1];
    UILabel *lb2 = [[UILabel alloc] init];
    lb2.frame=CGRectMake(WLsize(10.0),CGRectGetMaxY(lb1.frame)+WLsize(5.0), WLsize(200.0),WLsize(23.0));
    lb2.textColor=UIColorFromRGB(0x101010, 1);
    lb2.font=[UIFont systemFontOfSize:WLsize(12.0)];
    lb2.text=@"我家餐厅帮餐厅品牌在全网曝光与引流";
    [view addSubview:lb2];
    
    UIImageView *imageview1 = [[UIImageView alloc] init];
    imageview1.frame=CGRectMake(WIDTH-WLsize(33.0), 0, WLsize(24.0), WLsize(24.0));
    imageview1.image=[UIImage imageNamed:@""];
    imageview1.backgroundColor=[UIColor grayColor];
    [view addSubview:imageview1];
    UIImageView *imageview2 = [[UIImageView alloc] init];
    imageview2.frame=CGRectMake(WIDTH-WLsize(58.0), CGRectGetMaxY(imageview1.frame), WLsize(48.0), WLsize(48.0));
    imageview2.image=[UIImage imageNamed:@""];
    imageview2.backgroundColor=[UIColor grayColor];
    [view addSubview:imageview2];
    
}
- (void)createCell5:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, WLsize(10.0), WIDTH, KCellHeight5-WLsize(10.0));
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds=YES;
    view.layer.borderWidth=1.0;
    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [cell.contentView addSubview:view];
    
    CGFloat ww = WIDTH/3.0;
    CGFloat hh = view.frame.size.height/2.0;
    for (int i=0; i<6; i++) {
        int row = i/3;
        int column=i%3;
        UIView *view1 = [[UIView alloc] init];
        view1.frame=CGRectMake(ww*column, row*hh, ww, hh);
        view1.backgroundColor=[UIColor whiteColor];
        view1.layer.masksToBounds=YES;
//        view1.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
//        view1.layer.borderWidth=1.0;
//        view1.layer.shadowColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
        //右边框
        CALayer *rightLayer = [CALayer layer];
        rightLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
        rightLayer.frame = CGRectMake(view1.frame.size.width-1.0, 0, 1.0, view1.frame.size.height);
        [view1.layer addSublayer:rightLayer];
        //下边框
        CALayer *bottomLayer = [CALayer layer];
        bottomLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
        bottomLayer.frame = CGRectMake(0,view1.frame.size.height-1.0, view1.frame.size.width, 1.0);
        [view1.layer addSublayer:bottomLayer];

        [view addSubview:view1];
        UIImageView *imageview1 =[[UIImageView alloc] init];
        imageview1.frame=CGRectMake(WLsize(22.0), WLsize(11.0), WLsize(80.0), WLsize(60.0));
        imageview1.image = [UIImage imageNamed:@""];
        imageview1.backgroundColor=[UIColor grayColor];
        [view1 addSubview:imageview1];
        UILabel *lb1 = [[UILabel alloc] init];
        lb1.frame=CGRectMake(0, CGRectGetMaxY(imageview1.frame)+WLsize(2.0), view1.frame.size.width, WLsize(23.0));
        lb1.font=[UIFont systemFontOfSize:WLsize(12.0)];
        lb1.textColor=UIColorFromRGB(0x999999, 1);
        lb1.text=@"合作商家名称";
        lb1.textAlignment=NSTextAlignmentCenter;
        [view1 addSubview:lb1];
    }
    
}
- (void)createCell6:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, 0, WIDTH, KCellHeight6);
    view.backgroundColor=UIColorFromRGB(0xF7F7F7, 1);
    [cell.contentView addSubview:view];
    
    UIButton *btnOflogin =[[UIButton alloc] init];
    btnOflogin.frame=CGRectMake(WLsize(42.0), WLsize(9.0), WLsize(111.0), WLsize(30.0));
    btnOflogin.layer.masksToBounds=YES;
    btnOflogin.layer.cornerRadius=WLsize(4.0);
    btnOflogin.layer.borderWidth=1.0;
    btnOflogin.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [btnOflogin setTitle:@"立即登陆" forState:UIControlStateNormal];
    [btnOflogin setTitleColor:UIColorFromRGB(0x101010, 1) forState:UIControlStateNormal];
    btnOflogin.titleLabel.font=[UIFont systemFontOfSize:WLsize(14.0)];
    [btnOflogin addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnOflogin];
    
    UIButton *btnOfLocated =[[UIButton alloc] init];
    btnOfLocated.frame=CGRectMake(WLsize(208.0), WLsize(9.0), WLsize(111.0), WLsize(30.0));
    btnOfLocated.layer.masksToBounds=YES;
    btnOfLocated.layer.cornerRadius=WLsize(4.0);
    btnOfLocated.layer.borderWidth=1.0;
    btnOfLocated.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [btnOfLocated setTitle:@"快速入驻" forState:UIControlStateNormal];
    [btnOfLocated setTitleColor:UIColorFromRGB(0x101010, 1) forState:UIControlStateNormal];
    btnOfLocated.titleLabel.font=[UIFont systemFontOfSize:WLsize(14.0)];
    [btnOfLocated addTarget:self action:@selector(clickLocated) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnOfLocated];
}

#pragma mark --立即登陆
-(void)clickLogin
{
    WLLoginViewController *vc = [[WLLoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --快速入驻
-(void)clickLocated
{
    WLRegisterViewController *vc = [[WLRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
