//
//  WLFirstViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/19.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLFirstViewController.h"
#define KCellHeight1 140.0/375*WIDTH
#define KCellHeight2 140.0/375*WIDTH
#define KCellHeight3 140.0/375*WIDTH
#define KCellHeight4 140.0/375*WIDTH
#define KCellHeight5 140.0/375*WIDTH
#define KCellHeight6 140.0/375*WIDTH
@interface WLFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@end

@implementation WLFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationItem];
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
    [self initNavigationItem];
    
}
- (void)initNavigationItem
{
    
    self.isNeedWhite = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    self.tabBarController.navigationItem.titleView = nil;
    self.tabBarController.title = nil;
    UINavigationController *nav = self.tabBarController.navigationController;
    UIColor *color = DEFAULT_BackgroundView_COLOR;
    [nav.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    [nav.navigationBar hideLineOfNavtionBar];

}
#pragma mark--- 创建UI
- (void)createUI
{
    if (self.tableview==nil) {
        self.tableview=[[UITableView alloc] init];
    }
    self.tableview.frame=CGRectMake(0, 20, WIDTH, HEIGHT);
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
    return 1;
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
    lb1.text=@"欢迎使用食饭了商家后台";
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
    
}
- (void)createCell3:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)createCell4:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)createCell5:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)createCell6:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
