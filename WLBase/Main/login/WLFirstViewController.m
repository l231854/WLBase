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
#import "WLHelperViewController.h"
#import "WLConsultViewController.h"
#define KCellHeight1 170.0/375*WIDTH
#define KCellHeight2 144.0/375*WIDTH
#define KCellHeight3 190.0/375*WIDTH
#define KCellHeight4 100.0/375*WIDTH
#define KCellHeight5 325.0/375*WIDTH
#define KCellHeight6 88.0/375*WIDTH
@interface WLFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) BannerView *banner;

@end

@implementation WLFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self initNavigationItem];
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
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];

//    [self.navigationController.navigationBar lt_reset];
}
- (void)initNavigationItem
{
    
    self.isNeedWhite = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];


}
#pragma mark--- 创建UI
- (void)createUI
{
    if (self.tableview==nil) {
        self.tableview=[[UITableView alloc] init];
    }
    self.tableview.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
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
    UIImageView *imageViewOfBackground = [[UIImageView alloc] init];
    imageViewOfBackground.frame=CGRectMake(0, 0, WIDTH, KCellHeight1);
    imageViewOfBackground.image=[UIImage imageNamed:@"home_top_bg"];
    [cell.contentView addSubview:imageViewOfBackground];
    
    UILabel *lb1 =[[UILabel alloc] init];
    lb1.frame=CGRectMake(WLsize(12.0), WLsize(31.0), WIDTH, 23.0/375*WIDTH);
    lb1.font=[UIFont systemFontOfSize:15.0/375*WIDTH];
    lb1.textColor=[UIColor whiteColor];
    lb1.text=@"欢迎使用我家餐厅";
    [cell.contentView addSubview:lb1];
    
    CGFloat w1=WIDTH/3.0;
    CGFloat h1=80.0/375*WIDTH;
    CGFloat seph1=CGRectGetMaxY(lb1.frame)+WLsize(32.0);
    NSArray *arrayOfImage = [[NSArray alloc] initWithObjects:@"pay_white_icon",@"order_white_icon",@"Stafforder_white_icon", nil];
    for (int i=0; i<3; i++) {
        UIView *view =[[UIView alloc] init];
        view.frame=CGRectMake(w1*i, seph1, w1, h1);
        [cell.contentView addSubview:view];
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.frame=CGRectMake(49.0/375*WIDTH, 0, WLsize(40.0),WLsize(40.0));
        imageview.image=[UIImage imageNamed:[arrayOfImage objectAtIndex:i]];
        [view addSubview:imageview];
        UILabel *lbOfText = [[UILabel alloc]init];
        lbOfText.frame=CGRectMake(imageview.frame.origin.x-WLsize(20.0), CGRectGetMaxY(imageview.frame)+12.0/375*WIDTH,imageview.frame.size.width+WLsize(40.0) ,23.0/375*WIDTH);
        lbOfText.font=[UIFont systemFontOfSize:WLsize(14.0)];
        lbOfText.textColor=[UIColor whiteColor];
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
    view.frame=CGRectMake(0, 0, WIDTH, KCellHeight2);
//    view.backgroundColor=[UIColor whiteColor];
//    view.layer.masksToBounds=YES;
//    view.layer.borderWidth=1.0;
//    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [cell.contentView addSubview:view];
    NSMutableArray *arrofData = [[NSMutableArray alloc] init];
    HomeBannerModel *model1 = [[HomeBannerModel alloc] init];
    model1.headImageUrl=@"http://img.zcool.cn/community/0142135541fe180000019ae9b8cf86.jpg@1280w_1l_2o_100sh.png";
    model1.processId=@"2";
    [arrofData addObject:model1];
    HomeBannerModel *model2 = [[HomeBannerModel alloc] init];
    model2.headImageUrl=@"http://img05.tooopen.com/images/20150820/tooopen_sy_139205349641.jpg";
    model2.processId=@"2";

    [arrofData addObject:model2];
    
    self.banner =  [[BannerView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, view.frame.size.height) andDataOfHomePageMedel:arrofData withViewController:self isNeedSeparator:NO];
    [view addSubview:self.banner];

}
- (void)createCell3:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor=DEFAULT_BackgroundView_COLOR;
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, WLsize(10.0), WIDTH, KCellHeight3-WLsize(10.0));
    view.backgroundColor=[UIColor whiteColor];
//    view.layer.masksToBounds=YES;
//    view.layer.borderWidth=1.0;
//    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [cell.contentView addSubview:view];
    CGFloat rw=29.0/375*WIDTH;
    CGFloat ballD=WLsize(26.0);
    CGFloat linew=(WIDTH-ballD*3-rw*2)/2.0;
    CGFloat rh=WLsize(25.0);
    CGFloat lbW = WLsize(100.0);
    for (int i=0; i<3; i++) {
        UILabel *viewOfBall = [[UILabel alloc] init];
        viewOfBall.frame=CGRectMake(rw+(ballD+linew)*i,rh,ballD, ballD);
        viewOfBall.layer.masksToBounds=YES;
        viewOfBall.layer.cornerRadius=ballD/2.0;
     
        if (i==0) {
            viewOfBall.backgroundColor=UIColorFromInt(249.0, 104.0, 28.0, 1);
        }else{
            viewOfBall.backgroundColor=UIColorFromInt(232.0, 232.0, 232.0, 1);

        }
        viewOfBall.textAlignment=NSTextAlignmentCenter;
        viewOfBall.font=[UIFont systemFontOfSize:WLsize(18.0)];
        viewOfBall.text=[NSString stringWithFormat:@"%d",i+1];
        viewOfBall.textColor=[UIColor whiteColor];
        
//        viewOfBall.layer.borderWidth=1.0;
//        viewOfBall.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
        if (i<2) {
            UILabel *lbOfLine = [[UILabel alloc] init];
            lbOfLine.frame=CGRectMake(CGRectGetMaxX(viewOfBall.frame), viewOfBall.frame.origin.y+ballD/2.0-4.0/2,linew, 4.0);
            lbOfLine.backgroundColor=UIColorFromInt(232.0, 232.0, 232.0, 1);
            [view addSubview:lbOfLine];
        }
        
        UILabel *viewOfBall2 = [[UILabel alloc] init];
        viewOfBall2.frame=CGRectMake(rw+(ballD+linew)*i-WLsize(5.0),rh-WLsize(5.0),ballD+WLsize(10.0), ballD+WLsize(10.0));
        viewOfBall2.layer.masksToBounds=YES;
        viewOfBall2.layer.cornerRadius=viewOfBall2.frame.size.width/2.0;
        viewOfBall2.backgroundColor=UIColorFromInt(249.0, 180.0, 145.0, 1);
        if (i==0) {
            viewOfBall2.hidden=NO;
            [view addSubview:viewOfBall2];
            
            
        }else{
            viewOfBall2.hidden=YES;
            
        }
        [view addSubview:viewOfBall];

        UILabel *lbOfTitle = [[UILabel alloc] init];
        lbOfTitle.frame=CGRectMake(viewOfBall.center.x-lbW/2.0, CGRectGetMaxY(viewOfBall.frame)+WLsize(9.0), lbW, WLsize(23.0));
        lbOfTitle.textAlignment=NSTextAlignmentCenter;
        if (i==0) {
            lbOfTitle.textColor=UIColorFromInt(249.0, 104.0, 28.0, 1);
        }
        else{
            lbOfTitle.textColor=  UIColorFromInt(232.0, 232.0, 232.0, 1);
        }
        lbOfTitle.font=[UIFont systemFontOfSize:WLsize(15.0)];
        NSString *strContent=@"";
        switch (i) {
            case 0:
                strContent=@"注册账号";
                break;
            case 1:
                strContent=@"提交资质";
                break;
            case 2:
                strContent=@"开通业务";
                break;
            default:
                break;
        }
        lbOfTitle.text=strContent;
        [view addSubview:lbOfTitle];
       
        
    }
    UIButton *btnOfRegister =[[UIButton alloc] init];
    btnOfRegister.frame=CGRectMake((WIDTH-WLsize(85.0))/2.0, WLsize(106.0), WLsize(85.0), WLsize(35.0));
    btnOfRegister.layer.masksToBounds=YES;
    btnOfRegister.layer.cornerRadius=WLsize(5.0);
    btnOfRegister.layer.borderWidth=1.0;
    btnOfRegister.layer.borderColor=UIColorFromInt(249, 104, 28, 1).CGColor;
    [btnOfRegister setTitle:@"立即注册" forState:UIControlStateNormal];
    [btnOfRegister setTitleColor:UIColorFromInt(249, 104, 28, 1) forState:UIControlStateNormal];
    btnOfRegister.titleLabel.font=[UIFont systemFontOfSize:WLsize(16.0)];
    [btnOfRegister addTarget:self action:@selector(clickRegister) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnOfRegister];
    
    UILabel *lbOfDetail = [[UILabel alloc] init];
    lbOfDetail.frame=CGRectMake(0, CGRectGetMaxY(btnOfRegister.frame)+WLsize(13.0), WIDTH, WLsize(24.0));
    lbOfDetail.text=@"我家餐厅支持餐饮商铺入驻";
    lbOfDetail.font=[UIFont systemFontOfSize:WLsize(12.0)];
    lbOfDetail.textAlignment=NSTextAlignmentCenter;
    [lbOfDetail setAttributedText:[self changeLabelWithTextOfPrice2:lbOfDetail.text]];

    [view addSubview:lbOfDetail];
}
-(NSMutableAttributedString*)changeLabelWithTextOfPrice2:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
//    UIFont *font = [UIFont systemFontOfSize:14.0];
//    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,4)];
//    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(4,1)];
    [attrString addAttribute:NSForegroundColorAttributeName value:UIColorFromInt(102, 102, 102, 1) range:NSMakeRange(0,6)];
    
    [attrString addAttribute:NSForegroundColorAttributeName value:UIColorFromInt(254, 168, 1, 1) range:NSMakeRange(6,2)];
    [attrString addAttribute:NSForegroundColorAttributeName value:UIColorFromInt(102, 102, 102, 1) range:NSMakeRange(8,4)];

    
    
    
    return attrString;
}

#pragma mark ---点击立即注册
- (void)clickRegister
{
    WLRegisterViewController *vc = [[WLRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)createCell4:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor=DEFAULT_BackgroundView_COLOR;
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, WLsize(10.0), WIDTH, KCellHeight4-WLsize(10.0));
    view.backgroundColor=[UIColor whiteColor];
//    view.layer.masksToBounds=YES;
//    view.layer.borderWidth=1.0;
//    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    view.userInteractionEnabled=YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCell4:)];
    [view addGestureRecognizer:ges];
    [cell.contentView addSubview:view];
    
    UILabel *lb1 = [[UILabel alloc] init];
    lb1.frame=CGRectMake(WLsize(13.0),WLsize(17.0), WLsize(170.0),WLsize(30.0));
    lb1.textColor=UIColorFromInt(249, 104, 28, 1);
    lb1.font=[UIFont systemFontOfSize:WLsize(15.0)];
    lb1.text=@"全网流量，多渠道获客";
    [view addSubview:lb1];
    UILabel *lb2 = [[UILabel alloc] init];
    lb2.frame=CGRectMake(WLsize(13.0),CGRectGetMaxY(lb1.frame)+WLsize(2.0), WLsize(260.0),WLsize(43.0));
    lb2.textColor=WLNEWTEXTColor;
    lb2.numberOfLines=2;
    lb2.font=[UIFont systemFontOfSize:WLsize(12.0)];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = WLsize(5.0);
    lb2.text=@"我家餐厅帮餐厅品牌在全网曝光与引流我家餐厅帮餐厅品牌在全网曝光与引流我家餐厅帮餐厅品牌在全网曝光与引流";
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
//    lb2.attributedText = [[NSAttributedString alloc] initWithString:@"我家餐厅帮餐厅品牌在全网曝光与引流我家餐厅帮餐厅品牌在全网曝光与引流我家餐厅帮餐厅品牌在全网曝光与引流" attributes:attributes];
    [view addSubview:lb2];
    
   
    UIView *viewBall = [[UIView alloc] init];
    viewBall.frame=CGRectMake(WIDTH-WLsize(33.0), 0, WLsize(24.0), WLsize(24.0));
    [view addSubview:viewBall];
    for (int i=0; i<2; i++) {
        UILabel *lbball1 = [[UILabel alloc] init];
        lbball1.frame=CGRectMake(WLsize(10)*i, WLsize(12), WLsize(5), WLsize(5));
        lbball1.layer.masksToBounds=YES;
        lbball1.layer.cornerRadius=lbball1.frame.size.height/2.0;
        if (i==0) {
            lbball1.backgroundColor=WLORANGColor;
        }
        else{
            lbball1.backgroundColor=UIColorFromInt(232, 232, 232, 1);
        }
        [viewBall addSubview:lbball1];
    }
    UIImageView *imageview2 = [[UIImageView alloc] init];
    imageview2.frame=CGRectMake(WIDTH-WLsize(67.0), CGRectGetMaxY(viewBall.frame)+WLsize(5.0), WLsize(54.0), WLsize(54.0));
    imageview2.image=[UIImage imageNamed:@"articlepic1"];
    [view addSubview:imageview2];
    
}
- (void)createCell5:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor= DEFAULT_BackgroundView_COLOR;
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, WLsize(10.0), WIDTH, KCellHeight5-WLsize(10.0));
    view.backgroundColor=[UIColor whiteColor];
//    view.layer.masksToBounds=YES;
//    view.layer.borderWidth=1.0;
//    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [cell.contentView addSubview:view];
    UILabel *lbOfTitle  = [[UILabel alloc] init];
    lbOfTitle.frame=CGRectMake(WLsize(13.0), WLsize(26.0), WIDTH, WLsize(23.0));
    lbOfTitle.textColor=UIColorFromInt(51, 51, 51, 1);
    lbOfTitle.font=[UIFont systemFontOfSize:WLsize(15.0)];
    lbOfTitle.text=@"入驻商家";
    [view addSubview:lbOfTitle];
    
//    NSArray *imageArray = [[NSArray alloc] initWithObjects:@"storepic1",@"store_pic2", @"store_pic3", @"store_pic4", @"store_pic5", @"store_pic6",  nil];
    NSArray *titleArray = [[NSArray alloc] initWithObjects:@"木子坊北方菜",@"探虾(香蜜湖店)", @"云味八方", @"喜万年顺德大盘鱼", @"北国飘香饼店", @"深夜食堂(明珠店)",  nil];

    CGFloat ww = WIDTH/3.0;
    CGFloat hh = (view.frame.size.height-CGRectGetMaxY(lbOfTitle.frame)-WLsize(22.0))/2.0;
    for (int i=0; i<6; i++) {
        int row = i/3;
        int column=i%3;
        UIView *view1 = [[UIView alloc] init];
        view1.frame=CGRectMake(ww*column, row*hh+CGRectGetMaxY(lbOfTitle.frame)+WLsize(22.0), ww, hh);
        view1.backgroundColor=[UIColor whiteColor];
        view1.layer.masksToBounds=YES;
//        view1.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
//        view1.layer.borderWidth=1.0;
//        view1.layer.shadowColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
//        //右边框
//        CALayer *rightLayer = [CALayer layer];
//        rightLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
//        rightLayer.frame = CGRectMake(view1.frame.size.width-1.0, 0, 1.0, view1.frame.size.height);
//        [view1.layer addSublayer:rightLayer];
//        //下边框
//        CALayer *bottomLayer = [CALayer layer];
//        bottomLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
//        bottomLayer.frame = CGRectMake(0,view1.frame.size.height-1.0, view1.frame.size.width, 1.0);
//        [view1.layer addSublayer:bottomLayer];

        [view addSubview:view1];
        UIImageView *imageview1 =[[UIImageView alloc] init];
        imageview1.frame=CGRectMake((view1.frame.size.width-WLsize(65.0))/2.0, 0, WLsize(65.0), WLsize(65.0));
        imageview1.image = [UIImage imageNamed:[NSString stringWithFormat:@"storepic%d",i+1]];
        [view1 addSubview:imageview1];
        UILabel *lb1 = [[UILabel alloc] init];
        lb1.frame=CGRectMake(0, CGRectGetMaxY(imageview1.frame)+WLsize(14.0), view1.frame.size.width, WLsize(23.0));
        lb1.font=[UIFont systemFontOfSize:WLsize(12.0)];
        lb1.textColor=WLNEWTEXTColor;
        lb1.text=[titleArray objectAtIndex:i];
        lb1.textAlignment=NSTextAlignmentCenter;
        [view1 addSubview:lb1];
    }
    
}
- (void)createCell6:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor=DEFAULT_BackgroundView_COLOR;
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, WLsize(10.0), WIDTH, KCellHeight6-WLsize(1.0));
    view.backgroundColor=UIColorFromInt(150, 150, 150, 1);
    [cell.contentView addSubview:view];
    
    CGFloat sepw = (WIDTH-WLsize(330))/3.0;
    UIButton *btnOflogin =[[UIButton alloc] init];
    btnOflogin.frame=CGRectMake(sepw,(view.frame.size.height-WLsize(44))/2.0, WLsize(165.0), WLsize(44.0));
    btnOflogin.layer.masksToBounds=YES;
    btnOflogin.layer.cornerRadius=WLsize(4.0);
//    btnOflogin.layer.borderWidth=1.0;
//    btnOflogin.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [btnOflogin setTitle:@"立即登陆" forState:UIControlStateNormal];
    [btnOflogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnOflogin.titleLabel.font=[UIFont systemFontOfSize:WLsize(15.0)];
    btnOflogin.backgroundColor=WLORANGColor;
    [btnOflogin addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnOflogin];
    
    UIButton *btnOfLocated =[[UIButton alloc] init];
    btnOfLocated.frame=CGRectMake(CGRectGetMaxX(btnOflogin.frame)+sepw, btnOflogin.frame.origin.y, btnOflogin.frame.size.width, btnOflogin.frame.size.height);
    btnOfLocated.layer.masksToBounds=YES;
    btnOfLocated.layer.cornerRadius=WLsize(4.0);
//    btnOfLocated.layer.borderWidth=1.0;
//    btnOfLocated.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [btnOfLocated setTitle:@"快速入驻" forState:UIControlStateNormal];
    [btnOfLocated setTitleColor:WLORANGColor forState:UIControlStateNormal];
    btnOfLocated.titleLabel.font=[UIFont systemFontOfSize:WLsize(15.0)];
    btnOfLocated.backgroundColor=[UIColor whiteColor];
    [btnOfLocated addTarget:self action:@selector(clickLocated) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnOfLocated];
}

#pragma mark --点击cell4
- (void)clickCell4:(UIGestureRecognizer *)ges
{
    WLConsultViewController *vc =[[WLConsultViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
