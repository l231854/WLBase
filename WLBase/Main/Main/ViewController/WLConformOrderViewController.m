//
//  WLConformOrderViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/22.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLConformOrderViewController.h"
#import "WLPayViewController.h"
#define KCellHeight WLsize(44.0)
#define KCellHeight2 WLsize(90.0)
#define KCellHeight3 WLsize(54.0)
#define KCellHeight12 WLsize(90.0)

@interface WLConformOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *arrayOfData;


@end

@implementation WLConformOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"订单确认";
    self.arrayOfData=[[NSMutableArray alloc] initWithObjects:@"巴陵会馆",@"",@"麻辣小龙虾",@"茶位费：",@"商品合计：",@"订单合计：",@"类型：",@"订单号：",@"下单时间：",@"桌台",@"支付状态",@"人数", nil];
    [self createUI];
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
    return self.arrayOfData.count+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigth=KCellHeight;
    if (indexPath.row==1) {
        heigth=KCellHeight2;
    }
    else if (indexPath.row==6||indexPath.row==9) {
        heigth=KCellHeight3;
    }
    else if (indexPath.row==12)
    {
        heigth=KCellHeight12;

    }
    
    return heigth;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    if (indexPath.row==1) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell2:cell AtIndexPath:indexPath];
    }else if (indexPath.row==12)
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
    if (indexPath.row==6||indexPath.row==9) {
        cell.contentView.backgroundColor =DEFAULT_BackgroundView_COLOR;
        view.frame=CGRectMake(0, WLsize(10.0), WIDTH, KCellHeight3-WLsize(10.0));

    }
    UILabel *lbOfTitle = [[UILabel alloc] init];
    lbOfTitle.frame=CGRectMake(WLsize(13), 0, WLsize(100), KCellHeight);
    lbOfTitle.textColor=WLTEXTCOLOR;
    lbOfTitle.font =[UIFont systemFontOfSize:WLsize(14.0)];
    lbOfTitle.text=[self.arrayOfData objectAtIndex:indexPath.row];
    [view addSubview:lbOfTitle];
    
    UIImageView *imageview=[[UIImageView alloc] init];
    imageview.image=[UIImage imageNamed:@"right _arrow"];
    imageview.frame=CGRectMake(WIDTH-WLsize(15),(KCellHeight-WLsize(10))/2.0, WLsize(10), WLsize(10));
    if (indexPath.row==0) {
        imageview.hidden=NO;
        [view addSubview:imageview];
    }
    else{
        imageview.hidden=YES;

    }
    
    UILabel *lbOfsep = [[UILabel alloc] init];
    lbOfsep.frame=CGRectMake(WLsize(13.0), KCellHeight-1, WIDTH-WLsize(26), 1.0);
    lbOfsep.backgroundColor=WLSEPLBColor;
    [view addSubview:lbOfsep];
    lbOfsep.hidden=NO;
    if (indexPath.row==0||indexPath.row==5||indexPath.row==8||indexPath.row==11) {
        lbOfsep.hidden=YES;
    }
    
}
- (void)createCell2:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor=DEFAULT_BackgroundView_COLOR;
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(WLsize(29), WLsize(27), WIDTH-WLsize(58), WLsize(36));
    [cell.contentView addSubview:view];
    NSArray *temp = [[NSArray alloc] initWithObjects:@"等待处理",@"已确认",@"已完成", nil];
    NSArray *tempArrayImage = [[NSArray alloc] initWithObjects:@"check_click_icon",@"check_normal_icon",@"check_normal_icon", nil];

    CGFloat ww = WLsize(50);
    CGFloat hh = view.frame.size.height;
    CGFloat sepW = (view.frame.size.width-ww*temp.count)/2.0;

    for (int i=0; i<temp.count; i++) {
        UIView *view1 = [[UIView alloc] init];
        view1.frame=CGRectMake((ww+sepW)*i, 0, ww, hh);
        [view addSubview:view1];
        UIImageView *imageOfSelect =[[UIImageView alloc] init];
        imageOfSelect.frame=CGRectMake((view1.frame.size.width-WLsize(15))/2.0, 0, WLsize(15), WLsize(15));
        imageOfSelect.image=[UIImage imageNamed:[tempArrayImage objectAtIndex:i]];
        [view1 addSubview:imageOfSelect];
        UILabel *lbOfText = [[UILabel alloc] init];
        lbOfText.text=[temp objectAtIndex:i];
        lbOfText.textColor=UIColorFromInt(153, 153, 153, 1);
        if (i==0) {
            lbOfText.textColor=WLTEXTCOLOR;

        }
        lbOfText.font=[UIFont systemFontOfSize:WLsize(12)];
        lbOfText.textAlignment=NSTextAlignmentCenter;
        lbOfText.frame=CGRectMake(0, CGRectGetMaxY(imageOfSelect.frame)+WLsize(5), view1.frame.size.width, view1.frame.size.height-CGRectGetMaxY(imageOfSelect.frame)-WLsize(5));
        [view1 addSubview:lbOfText];
        
    }
    NSArray *tempSep = [[NSArray alloc] initWithObjects:@"1",@"0",@"0",@"0", nil];
    CGFloat wwj =WLsize(58);
    CGFloat hhJ = 2.0;
    CGFloat sepHj=WLsize(7);
    for (int j=0; j<4; j++) {
        UILabel *lbOfLb = [[UILabel alloc] init];
        lbOfLb.frame=CGRectMake(WLsize(3)+wwj*j+WLsize(21)*(j-1),sepHj,wwj, hhJ);
        NSString *select = [tempSep objectAtIndex:j];
        if ([select intValue]==1) {
            lbOfLb.backgroundColor=WLORANGColor;
        }else{
            lbOfLb.backgroundColor=UIColorFromInt(102, 102, 102, 1);

        }
        [view addSubview:lbOfLb];
    }
}

#pragma mark --创建cell
- (void)createCell3:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor=DEFAULT_BackgroundView_COLOR;
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, 0, WIDTH, KCellHeight12);
    view.backgroundColor=DEFAULT_BackgroundView_COLOR;
    [cell.contentView addSubview:view];
    CGFloat ww = (WIDTH-WLsize(13.0)*2-WLsize(20.0))/2.0;
    CGFloat hh =WLsize(40);
    NSArray *temp1 =[[NSArray alloc] initWithObjects:@"加菜",@"收款", nil];
    for (int i=0; i<temp1.count; i++) {
        UIButton *btn =[[UIButton alloc] init];
        btn.frame = CGRectMake(WLsize(13.0)+(ww+WLsize(20.0))*i,(KCellHeight12-hh)/2.0, ww, hh);
        [btn setTitle:[temp1 objectAtIndex:i] forState:UIControlStateNormal];
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=WLsize(5);
        btn.layer.borderWidth=1.0/2;
        btn.layer.borderColor=WLORANGColor.CGColor;
        if (i==0) {
            btn.backgroundColor = WLORANGColor;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else{
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:WLORANGColor forState:UIControlStateNormal];
        }
        btn.tag=i+1;
        [btn addTarget:self action:@selector(clickAddOrReceipt:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    
}

#pragma mark --加菜和收款
- (void)clickAddOrReceipt:(UIButton *)button
{
    if (button.tag==1) {
        //加菜
    }
    else if (button.tag==2)
    {
     //收款
        WLPayViewController *vc = [[WLPayViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
