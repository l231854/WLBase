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
#import "WLReceiptViewController.h"
#import "WLShopInformationViewController.h"
#import "WLShopServiceViewController.h"
#import "WLActivityManagerViewController.h"
#import "WLShopManagerViewController.h"
#define KCellHeight1 126.0/375*WIDTH
#define KCellHeight2 224.0/375*WIDTH
#define KCellHeight3 267.0/375*WIDTH
#define KCellHeight4 112.0/375*WIDTH
#define KCellHeight5 91.0/375*WIDTH
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) BannerView *banner;
//1=今天
@property (nonatomic,assign) NSInteger selectOfTime;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectOfTime=1;
    [self createUI];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.navigationController setNavigationBarHidden:YES animated:NO];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.navigationController setNavigationBarHidden:NO animated:NO];
    //    [self.navigationController.navigationBar lt_reset];
}
#pragma mark --createUI
#pragma mark--- 创建UI
- (void)createUI
{
    if (self.tableview==nil) {
        self.tableview=[[UITableView alloc] init];
    }
    self.tableview.frame=CGRectMake(0, 20, WIDTH, HEIGHT-20-XCTbaBar);
    self.tableview.backgroundColor=DEFAULT_BackgroundView_COLOR;
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
    return 5;
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
        view.userInteractionEnabled=YES;
        view.tag=i+1;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFirstCell:)];
        [view addGestureRecognizer:ges];
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
    view.frame=CGRectMake(0, WLsize(14.0), WIDTH, KCellHeight2-WLsize(14.0));
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds=YES;
    view.layer.borderWidth=1.0;
    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [cell.contentView addSubview:view];
    CGFloat ww = WIDTH/2.0;
    CGFloat hh = view.frame.size.height/2.0;
    for (int i=0; i<4; i++) {
        int row =i/2;
        int colum=i%2;
        UIView *view1 =[[UIView alloc] init];
        view1.frame=CGRectMake(ww*colum,hh*row, ww, hh);
        view1.userInteractionEnabled=YES;
        view1.tag=i+1;
        UITapGestureRecognizer *ges =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCell2View:)];
        [view1 addGestureRecognizer:ges];
        [view addSubview:view1];
        UIImageView *imageview1 =[[UIImageView alloc] init];
        imageview1.frame=CGRectMake((view1.frame.size.width-WLsize(24.0))/2.0, WLsize(37.0), WLsize(24.0), WLsize(24.0));
        imageview1.image=[UIImage imageNamed:@""];
        imageview1.backgroundColor=[UIColor grayColor];
        [view1 addSubview:imageview1];
        UILabel *lb1 =[[UILabel alloc] init];
        lb1.frame= CGRectMake(0, CGRectGetMaxY(imageview1.frame)+WLsize(7.0), view1.frame.size.width, WLsize(23.0));
        lb1.font=[UIFont systemFontOfSize:WLsize(14)];
        lb1.textColor=UIColorFromRGB(0x101010, 1);
        lb1.textAlignment=NSTextAlignmentCenter;
        [view1 addSubview:lb1];
        NSString *strText=@"";
        switch (i) {
            case 0:
                strText=@"店内服务";
                break;
            case 1:
                strText=@"营销活动";
                break;
            case 2:
                strText=@"店面管理";
                break;
            case 3:
                strText=@"财务管理";
                break;
                
            default:
                break;
        }
        lb1.text=strText;
        
    }
    UILabel *sep1 = [[UILabel alloc] init];
    sep1.frame=CGRectMake(view.frame.size.width/2.0, WLsize(20.0), 1.0, view.frame.size.height-WLsize(40.0));
    sep1.backgroundColor=UIColorFromRGB(0xBBBBBB, 1);
    [view addSubview:sep1];
    
    UILabel *sep2= [[UILabel alloc] init];
    sep2.frame=CGRectMake(WLsize(25.0), view.frame.size.height/2.0, WIDTH-WLsize(50.0), 1.0);
    sep2.backgroundColor=UIColorFromRGB(0xBBBBBB, 1);
    [view addSubview:sep2];
}
- (void)createCell3:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, WLsize(14.0), WIDTH, KCellHeight3-WLsize(14.0));
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds=YES;
    view.layer.borderWidth=1.0;
    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [cell.contentView addSubview:view];
    
    UIView *view1 = [[UIView alloc] init];
    view1.frame=CGRectMake(0, WLsize(15.0), WIDTH, WLsize(23.0));
    [view addSubview:view1];
    UILabel *lb1 = [[UILabel alloc] init];
    lb1.frame=CGRectMake(WLsize(15.0), 0, WLsize(70.0), WLsize(23.0));
    lb1.textColor=WLTEXTCOLOR;
    lb1.font=[UIFont systemFontOfSize:WLsize(16.0)];
    lb1.text=@"经营数据";
    [view1 addSubview:lb1];
    CGFloat ww=WLsize(55.0);
    CGFloat sepx=WIDTH-WLsize(10.0)-ww;
    for (int i=0; i<4; i++) {
        UIButton *btn1 =[[UIButton alloc] init];
        btn1.frame=CGRectMake(sepx, 0, ww, view1.frame.size.height);
        btn1.layer.masksToBounds=YES;
        btn1.layer.borderWidth=1.0;
        btn1.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
        [btn1 setTitleColor:WLTEXTCOLOR forState:UIControlStateNormal];
        btn1.titleLabel.font=[UIFont systemFontOfSize:WLsize(14.0)];
        btn1.tag=4-i;
        if ((4-i)==self.selectOfTime) {
            btn1.backgroundColor=UIColorFromRGB(0xAEACAC, 1);
        }
        else{
            btn1.backgroundColor=[UIColor whiteColor];

        }
        [btn1 addTarget:self action:@selector(clickTimeSection:) forControlEvents:UIControlEventTouchUpInside];
        NSString *strTitle =@"";
        switch (i) {
            case 0:
                strTitle=@"一月内";
                break;
            case 1:
                strTitle=@"两周内";
                break;
            case 2:
                strTitle=@"一周内";
                break;
            case 3:
                strTitle=@"今天";
                break;
                
            default:
                break;
        }
        [btn1 setTitle:strTitle forState:UIControlStateNormal];
        sepx=sepx-ww+1.0;
        [view1 addSubview:btn1];
    }
    UILabel *lbOfTotalText =[[UILabel alloc] init];
    lbOfTotalText.frame=CGRectMake(0, CGRectGetMaxY(view1.frame)+WLsize(12.0), WIDTH, WLsize(23.0));
    lbOfTotalText.textColor=WLTEXTCOLOR;
    lbOfTotalText.font=[UIFont systemFontOfSize:WLsize(14.0)];
    lbOfTotalText.textAlignment=NSTextAlignmentCenter;
    lbOfTotalText.text=@"总收入";
    [view addSubview:lbOfTotalText];
    
    UILabel *lbOfTotalAmount =[[UILabel alloc] init];
    lbOfTotalAmount.frame=CGRectMake(0, CGRectGetMaxY(lbOfTotalText.frame), WIDTH, WLsize(41.0));
    lbOfTotalAmount.textColor=WLTEXTCOLOR;
    lbOfTotalAmount.textAlignment=NSTextAlignmentCenter;
    lbOfTotalAmount.font=[UIFont systemFontOfSize:WLsize(28.0)];
    lbOfTotalAmount.text=[NSString stringWithFormat:@"¥529.87"];
    [view addSubview:lbOfTotalAmount];
    
    //当前选择天数的收入
    UILabel *lbOfSelectAmount =[[UILabel alloc] init];
    lbOfSelectAmount.frame=CGRectMake(0, CGRectGetMaxY(lbOfTotalAmount.frame), WIDTH, WLsize(23.0));
    lbOfSelectAmount.textColor=UIColorFromRGB(0x999999, 1);
    lbOfSelectAmount.font=[UIFont systemFontOfSize:WLsize(14.0)];
    lbOfSelectAmount.textAlignment=NSTextAlignmentCenter;
    NSString *strText1=@"今日收入";
    switch (self.selectOfTime) {
        case 1:
            strText1=@"今日收入";
            break;
        case 2:
            strText1=@"一周内收入";
            break;
        case 3:
            strText1=@"两周内收入";
            break;
        case 4:
            strText1=@"一月内收入";
            break;
            
        default:
            break;
    }
    lbOfSelectAmount.text=[NSString stringWithFormat:@"%@ ¥%@",strText1,@"300.00"];
    
    [view addSubview:lbOfSelectAmount];
    
    UIView *view2 =[[UIView alloc] init];
    view2.frame=CGRectMake(0, CGRectGetMaxY(lbOfSelectAmount.frame)+WLsize(10.0), WIDTH, WLsize(46.0));
    [view addSubview:view2];
    
    CGFloat wwj=WIDTH/3.0;
    CGFloat hhj =WLsize(23.0);
    for (int j=0; j<3; j++) {
        UILabel *lbOfj = [[UILabel alloc] init];
        lbOfj.frame=CGRectMake(wwj*j, 0, wwj, hhj);
        lbOfj.textColor=WLTEXTCOLOR;
        lbOfj.font=[UIFont systemFontOfSize:WLsize(14.0)];
        lbOfj.textAlignment=NSTextAlignmentCenter;
        [view2 addSubview:lbOfj];
        
        UILabel *lbOfj2 = [[UILabel alloc] init];
        lbOfj2.frame=CGRectMake(wwj*j, hhj, wwj, hhj);
        lbOfj2.textColor=UIColorFromRGB(0x999999, 1);
        lbOfj2.font=[UIFont systemFontOfSize:WLsize(14.0)];
        lbOfj2.textAlignment=NSTextAlignmentCenter;
        [view2 addSubview:lbOfj2];
        NSString *strtextj1=@"";
        NSString *strtextj2=@"";
        switch (j) {
            case 0:
                strtextj1=@"5";
                strtextj2=@"订单数";
                break;
            case 1:
                strtextj1=@"8";
                strtextj2=@"访客数";
                break;
            case 2:
                strtextj1=[NSString stringWithFormat:@"¥%@",@"280.00"];
                strtextj2=@"在线收入";
                break;
                
            default:
                break;
        }
        lbOfj.text=strtextj1;
        lbOfj2.text=strtextj2;

    }
    UIView *view3 =[[UIView alloc] init];
    view3.frame=CGRectMake(0, CGRectGetMaxY(view2.frame)+WLsize(15.0), WIDTH, view.frame.size.height-CGRectGetMaxY(view2.frame)-WLsize(15.0));
    UITapGestureRecognizer *ges3 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDetail:)];
    [view3 addGestureRecognizer:ges3];
    [view addSubview:view3];
    UILabel *sep3 =[[UILabel alloc] init];
    sep3.frame=CGRectMake(WLsize(10.0), 0, WIDTH-WLsize(20.0), 1.0);
    sep3.backgroundColor=UIColorFromRGB(0xBBBBBB, 1);
    [view3 addSubview:sep3];
    UILabel *lbOfCcontext3 =[[UILabel alloc] init];
    lbOfCcontext3.frame=CGRectMake(0, 0, WIDTH, view3.frame.size.height);
    lbOfCcontext3.textColor=WLTEXTCOLOR;
    lbOfCcontext3.font=[UIFont systemFontOfSize:WLsize(14.0)];
    lbOfCcontext3.textAlignment=NSTextAlignmentCenter;
    lbOfCcontext3.text=@"查看详情";
    [view3 addSubview:lbOfCcontext3];
    
    
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
    NSMutableArray *arrofData = [[NSMutableArray alloc] init];
    HomeBannerModel *model1 = [[HomeBannerModel alloc] init];
    model1.headImageUrl=@"http://img.zcool.cn/community/0142135541fe180000019ae9b8cf86.jpg@1280w_1l_2o_100sh.png";
    model1.processId=@"1";
    [arrofData addObject:model1];
    HomeBannerModel *model2 = [[HomeBannerModel alloc] init];
    model2.headImageUrl=@"http://img05.tooopen.com/images/20150820/tooopen_sy_139205349641.jpg";
    model2.processId=@"2";
    
    [arrofData addObject:model2];
    
    self.banner =  [[BannerView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, view.frame.size.height) andDataOfHomePageMedel:arrofData withViewController:self isNeedSeparator:NO];
    [view addSubview:self.banner];
}
- (void)createCell5:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, WLsize(9.0), WIDTH, KCellHeight5-WLsize(9.0));
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


#pragma mark -- 点击买单收款，订单管理，帮客点餐
-(void)clickFirstCell:(UIGestureRecognizer *)ges
{
    NSInteger tag =[ges view].tag;
    if (tag==1) {
        WLReceiptViewController *vc =[[WLReceiptViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (tag==2)
    {
        WLShopInformationViewController *vc =[[WLShopInformationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (tag==3)
    {
        WLShopInformationViewController *vc =[[WLShopInformationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark ---点击cell2 里面的view
- (void)clickCell2View:(UIGestureRecognizer *)ges
{
    NSInteger tag = [ges view].tag;
    if (tag==1) {
        //店内服务
        WLShopServiceViewController *vc =[[WLShopServiceViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (tag==2)
    {
        //营销活动
        WLActivityManagerViewController *vc =[[WLActivityManagerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (tag==3)
    {
        //店面管理
        WLShopManagerViewController *vc =[[WLShopManagerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (tag==4)
    {
        //财务管理
        [[NSNotificationCenter defaultCenter] postNotificationName:KSwitchToSecondTabNotification object:nil];
    }
    NSLog(@"%ld",tag);
}

#pragma mark --点击经营数据时间 一周等
- (void)clickTimeSection:(UIButton *)button
{
    NSInteger tag =button.tag;
    self.selectOfTime=tag;
//    [self.tableview reloadData];
    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    NSLog(@"%ld",tag);
}


#pragma mark --点击查看详情
- (void)clickDetail:(UIGestureRecognizer *)ges
{
    NSLog(@"clickDetail");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
