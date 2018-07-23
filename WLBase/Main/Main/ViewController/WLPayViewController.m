//
//  WLPayViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/22.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLPayViewController.h"
#define KCellHeight WLsize(44.0)
#define KCellHeight2 WLsize(54.0)
#define KCellHeight3 WLsize(200.0)
#define KCellHeight10 WLsize(90.0)

@interface WLPayViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    //遮照
    UIView *viewOfBg;
    UIView *viewOfBgContent;

}
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *arrayOfData;

@end

@implementation WLPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"订单付款";
    self.arrayOfData=[[NSMutableArray alloc] initWithObjects:@"类型：",@"订单号：",@"下单时间：",@"桌台：",@"人数：",@"麻辣小龙虾：",@"茶味费：",@"商品合计：",@"订单合计：",@"",@"", nil];
    
    [self createUI];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self handleSingleFingerEvent];
}
#pragma mark --createUI
#pragma mark--- 创建UI
- (void)createUI
{
    if (self.tableview==nil) {
        self.tableview=[[UITableView alloc] init];
    }
    self.tableview.frame=CGRectMake(0, 0, WIDTH, HEIGHT-XCStatusBar);
    self.tableview.backgroundColor=[UIColor whiteColor];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    [self createBallOfGoToHome];

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
    if (indexPath.row==5) {
        heigth=KCellHeight2;
    }
    else if (indexPath.row==9)
    {
        heigth=KCellHeight3;
    }
    else if (indexPath.row==10)
    {
        heigth=KCellHeight10;
    }
    return heigth;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    if (indexPath.row==9) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell2:cell AtIndexPath:indexPath];
    }
    else if (indexPath.row==10)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell3:cell AtIndexPath:indexPath];
    }
    else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell1:cell AtIndexPath:indexPath];
    }
    return cell;
}
#pragma mark --创建cell
- (void)createCell1:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, 0, WIDTH, KCellHeight);
    view.backgroundColor=[UIColor whiteColor];
    [cell.contentView addSubview:view];
    if (indexPath.row==5) {
        cell.contentView.backgroundColor =DEFAULT_BackgroundView_COLOR;
        view.frame=CGRectMake(0, WLsize(10.0), WIDTH, KCellHeight2-WLsize(10.0));
        
    }
    UILabel *lbOfTitle = [[UILabel alloc] init];
    lbOfTitle.frame=CGRectMake(WLsize(13), 0, WLsize(100), KCellHeight);
    lbOfTitle.textColor=WLTEXTCOLOR;
    lbOfTitle.font =[UIFont systemFontOfSize:WLsize(14.0)];
    lbOfTitle.text=[self.arrayOfData objectAtIndex:indexPath.row];
    [view addSubview:lbOfTitle];
    
    UILabel *lbOfsep = [[UILabel alloc] init];
    lbOfsep.frame=CGRectMake(WLsize(13.0), KCellHeight-1, WIDTH-WLsize(26), 1.0);
    lbOfsep.backgroundColor=WLSEPLBColor;
    [view addSubview:lbOfsep];
    lbOfsep.hidden=NO;
    if (indexPath.row==4) {
        lbOfsep.hidden=YES;
    }
    
}
#pragma mark --创建cell
- (void)createCell2:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, 0, WIDTH, KCellHeight3);
    view.backgroundColor=[UIColor whiteColor];
    [cell.contentView addSubview:view];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame=CGRectMake((WIDTH-WLsize(160))/2.0, (KCellHeight3-WLsize(160))/2.0, WLsize(160), WLsize(160));
    imageView.backgroundColor = [UIColor grayColor];
    [view addSubview:imageView];
    
}
#pragma mark --创建cell
- (void)createCell3:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor=DEFAULT_BackgroundView_COLOR;
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, 0, WIDTH, KCellHeight10);
    view.backgroundColor=DEFAULT_BackgroundView_COLOR;
    [cell.contentView addSubview:view];
    UIButton *btn =[[UIButton alloc] init];
    btn.frame = CGRectMake(WLsize(13.0),(KCellHeight10-WLsize(40))/2.0, WIDTH-WLsize(26), WLsize(40));
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius=WLsize(5);
    //        btn.layer.borderWidth=1.0/2;
    //        btn.layer.borderColor=WLORANGColor.CGColor;
    btn.backgroundColor = WLORANGColor;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickComplete:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
}
#pragma mark --生成遮照
-(void)handleSingleFingerEvent
{
    [viewOfBg removeFromSuperview];
    [viewOfBgContent removeFromSuperview];
    viewOfBg=nil;
    viewOfBgContent=nil;
}

- (void)addPray
{
    viewOfBg = [[UIView alloc] init];
    viewOfBg.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    viewOfBg.backgroundColor = [UIColor blackColor];
    viewOfBg.alpha = 0.8;
    
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(handleSingleFingerEvent)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    
    [viewOfBg addGestureRecognizer:singleFingerOne];
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.window addSubview:viewOfBg];
    viewOfBgContent = [[UIView alloc] init];
    viewOfBgContent.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    viewOfBgContent.alpha = 1;
    [app.window addSubview:viewOfBgContent];
    viewOfBgContent.userInteractionEnabled=YES;
    [viewOfBgContent addGestureRecognizer:singleFingerOne];

    UILabel *lb1 =[[UILabel alloc] init];
    lb1.frame=CGRectMake(0, WLsize(81), WIDTH, WLsize(23.0));
    lb1.text=@"扫一扫,向我付款";
    lb1.textAlignment=NSTextAlignmentCenter;
    lb1.textColor=[UIColor whiteColor];
    lb1.font=[UIFont systemFontOfSize:WLsize(17)];
    [viewOfBgContent addSubview:lb1];
    UILabel *lb2 =[[UILabel alloc] init];
    lb2.frame=CGRectMake(0, CGRectGetMaxY(lb1.frame)+WLsize(40), WIDTH, WLsize(32.0));
    lb2.text=[NSString stringWithFormat:@"¥%@",@"150.00"];
    lb2.textColor=[UIColor whiteColor];
    lb2.textAlignment=NSTextAlignmentCenter;
    lb2.font=[UIFont systemFontOfSize:WLsize(35)];
    [viewOfBgContent addSubview:lb2];
    
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.frame=CGRectMake((WIDTH-WLsize(277))/2.0, CGRectGetMaxY(lb2.frame)+WLsize(30), WLsize(277), WLsize(277));
    imageview.backgroundColor=[UIColor whiteColor];
    [viewOfBgContent addSubview:imageview];
    
    NSArray *arrayOfImage=[[NSArray alloc] initWithObjects:@"alipay_icon",@"WeChat_icon", nil];
    for (int i=0; i<arrayOfImage.count; i++) {
        UIButton *btnOfImage =[[UIButton alloc] init];
        btnOfImage.frame=CGRectMake(WLsize(105)+(WLsize(45)+WLsize(76))*i, HEIGHT-WLsize(80), WLsize(45), WLsize(45));
        [btnOfImage setImage:[UIImage imageNamed:[arrayOfImage objectAtIndex:i]] forState:UIControlStateNormal];
        btnOfImage.tag=i+1;
        [btnOfImage addTarget:self action:@selector(clickPayWXORzhifubao:) forControlEvents:UIControlEventTouchUpInside];
        [viewOfBgContent addSubview:btnOfImage];
    }
    UILabel *lbOfDes = [[UILabel alloc] init];
    lbOfDes.frame=CGRectMake((WIDTH-WLsize(200))/2.0, HEIGHT-WLsize(80)-WLsize(45), WLsize(200), WLsize(23));
    lbOfDes.text=@"支持使用微信,支付宝扫码付款";
    lbOfDes.textAlignment=NSTextAlignmentCenter;
    lbOfDes.textColor=[UIColor whiteColor];
    lbOfDes.font=[UIFont systemFontOfSize:WLsize(12)];
    [viewOfBgContent addSubview:lbOfDes];
    
    UILabel *lbOfSep1 =[[UILabel alloc] init];
    lbOfSep1.frame=CGRectMake(WLsize(24), lbOfDes.center.y, WLsize(63.5), 1.0/2);
    lbOfSep1.backgroundColor=[UIColor whiteColor];
    [viewOfBgContent addSubview:lbOfSep1];
    UILabel *lbOfSep2 =[[UILabel alloc] init];
    lbOfSep2.frame=CGRectMake(WIDTH-lbOfSep1.frame.size.width-WLsize(24), lbOfDes.center.y, lbOfSep1.frame.size.width, 1.0/2);
    lbOfSep2.backgroundColor=[UIColor whiteColor];
    [viewOfBgContent addSubview:lbOfSep2];
    
}

#pragma mark --点击完成
- (void)clickComplete:(UIButton *)button
{
    [self addPray];
}

#pragma mark --点击微信或者支付宝
-(void)clickPayWXORzhifubao:(UIButton *)button
{
    NSInteger tag =button.tag;
    NSLog(@"%ld",tag);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
