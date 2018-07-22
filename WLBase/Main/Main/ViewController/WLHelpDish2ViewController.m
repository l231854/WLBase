//
//  WLHelpDish2ViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/22.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLHelpDish2ViewController.h"
#import "WLHelpDish2TableViewCell.h"
#import "WLConformOrderViewController.h"
#define KTableviewW WLsize(70.0)
#define KTableviewCellH WLsize(44.0)
#define KBottomviewH WLsize(44.0)

@interface WLHelpDish2ViewController ()<UITableViewDelegate,UITableViewDataSource>
//左边分类
@property (nonatomic,strong) UITableView *tableview1;
//右边展示
@property (nonatomic,strong) UITableView *tableview2;
@property (nonatomic,strong) NSMutableArray *arrayOfCategory;
@property (nonatomic,strong) NSMutableArray *arrayOfGoods;
@property (nonatomic,strong) UIView *bottomView;

@end

@implementation WLHelpDish2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"帮客点餐";
    self.view.backgroundColor =[UIColor whiteColor];
    self.arrayOfCategory=[[NSMutableArray alloc] initWithObjects:@"常点菜",@"常点菜",@"常点菜",@"常点菜",@"常点菜", nil];
    self.arrayOfGoods=[[NSMutableArray alloc] init];
    
    [self createUI];
    
    
}
#pragma mark --createUI
#pragma mark--- 创建UI
- (void)createUI
{
    if (self.tableview1==nil) {
        self.tableview1=[[UITableView alloc] init];
    }
    self.tableview1.frame=CGRectMake(0, 0, KTableviewW, HEIGHT-XCStatusBar-KBottomviewH);
    self.tableview1.backgroundColor=[UIColor whiteColor];
    self.tableview1.delegate=self;
    self.tableview1.dataSource=self;
    self.tableview1.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview1];
    
    if (self.tableview2==nil) {
        self.tableview2=[[UITableView alloc] init];
    }
    self.tableview2.frame=CGRectMake(CGRectGetMaxX(self.tableview1.frame)+WLsize(13.0), 0, WIDTH-CGRectGetMaxX(self.tableview1.frame)-WLsize(13.0), HEIGHT-XCStatusBar-KBottomviewH);
    self.tableview2.backgroundColor=[UIColor whiteColor];
    self.tableview2.delegate=self;
    self.tableview2.dataSource=self;
    self.tableview2.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview2];
    if (self.bottomView==nil) {
        self.bottomView=[[UIView alloc] init];
    }
    self.bottomView.frame=CGRectMake(0, HEIGHT-KBottomviewH-XCStatusBar, WIDTH, KBottomviewH);
    [self.view addSubview:self.bottomView];
    UIButton *btnToPay = [[UIButton alloc] init];
    btnToPay.frame=CGRectMake(self.bottomView.frame.size.width-WLsize(80.0), 0, WLsize(80.0), self.bottomView.frame.size.height);
    btnToPay.backgroundColor = [UIColor orangeColor];
    [btnToPay setTitle:@"去结算" forState:UIControlStateNormal];
    [btnToPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnToPay.titleLabel.font = [UIFont systemFontOfSize:WLsize(14.0)];
    [btnToPay addTarget:self action:@selector(clickToPay:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:btnToPay];
    
}

#pragma mark --去结算
- (void)clickToPay:(UIButton *)buuton
{
    WLConformOrderViewController *vc = [[WLConformOrderViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count=0;
    if (self.tableview1==tableView) {
        count=1;
    }
    else if (tableView==self.tableview2)
    {
        count=1;
    }
    return count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count=0;
    if (self.tableview1==tableView) {
        count=self.arrayOfCategory.count;
    }
    else if (tableView==self.tableview2)
    {
        count=self.arrayOfGoods.count;
    }
    return count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigth=0;
    if (self.tableview1==tableView) {
        heigth=KTableviewCellH;
    }
    else if (tableView==self.tableview2)
    {
        heigth=WLsize(100.0);
    }
    return heigth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height=0;
    if (tableView==self.tableview2) {
        height=44;
    }
    return height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView=nil;
    if (tableView==self.tableview2) {
        headView= [[UIView alloc] init];
        headView.frame=CGRectMake(0, 0, WIDTH, 44);
        UILabel *lbOfTitle = [[UILabel alloc] init];
        lbOfTitle.frame=CGRectMake(0,(headView.frame.size.height-WLsize(33.0))/2.0, self.tableview2.frame.size.width-WLsize(6.0), WLsize(33.0));
        lbOfTitle.textColor=WLTEXTCOLOR;
        lbOfTitle.font=[UIFont systemFontOfSize:WLsize(14.0)];
        lbOfTitle.layer.masksToBounds=YES;
        lbOfTitle.layer.borderWidth=1.0;
        lbOfTitle.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
        lbOfTitle.text=@"分类名称";
        [headView addSubview:lbOfTitle];
        
    }
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    if (tableView==self.tableview1) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell1:cell AtIndexPath:indexPath];
    }
    else{
        WLHelpDish2TableViewCell *cell = [WLHelpDish2TableViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = [self.arrayOfGoods objectAtIndex:indexPath.row];
        
        return cell;
    }
    return cell;
}
#pragma mark --创建cell
- (void)createCell1:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *lb = [[UILabel alloc] init];
    lb.frame=CGRectMake(0,0, KTableviewW,KTableviewCellH);
    lb.font=[UIFont systemFontOfSize:WLsize(14.0)];
    lb.textColor=WLTEXTCOLOR;
    lb.textAlignment=NSTextAlignmentCenter;
    lb.text=[self.arrayOfCategory objectAtIndex:indexPath.row];
    [cell.contentView addSubview:lb];
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
