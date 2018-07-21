//
//  WLCodeListViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/21.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLCodeListViewController.h"
#import "WLCodeListModel.h"
#define KCellHeight 280.0/375*WIDTH
@interface WLCodeListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *arrayOfData;
@property (nonatomic,strong) UILabel *lbOfGoToHome;

@end

@implementation WLCodeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"支付二维码";
    self.arrayOfData=[[NSMutableArray alloc] init];
    WLCodeListModel *model = [[WLCodeListModel alloc] init];
    model.name=@"店铺二维码";
    model.imageUrl=@"https://qr.api.cli.im/qr?data=%25E6%25B5%258B%25E8%25AF%2595&level=H&transparent=false&bgcolor=%23ffffff&forecolor=%23000000&blockpixel=12&marginblock=1&logourl=&size=280&kid=cliim&key=268f3bbe7363b1da9057fef12bf5df76";
    [self.arrayOfData addObject:model];
    WLCodeListModel *model2 = [[WLCodeListModel alloc] init];
    model2.name=@"支付二维码";
    model2.imageUrl=@"https://qr.api.cli.im/qr?data=%25E6%25B5%258B%25E8%25AF%2595&level=H&transparent=false&bgcolor=%23ffffff&forecolor=%23000000&blockpixel=12&marginblock=1&logourl=&size=280&kid=cliim&key=268f3bbe7363b1da9057fef12bf5df76";
    [self.arrayOfData addObject:model2];
    WLCodeListModel *model3 = [[WLCodeListModel alloc] init];
    model3.name=@" 扫我点餐哦 A001桌号";
    model3.imageUrl=@"https://qr.api.cli.im/qr?data=%25E6%25B5%258B%25E8%25AF%2595&level=H&transparent=false&bgcolor=%23ffffff&forecolor=%23000000&blockpixel=12&marginblock=1&logourl=&size=280&kid=cliim&key=268f3bbe7363b1da9057fef12bf5df76";
    [self.arrayOfData addObject:model3];
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

#pragma mark --创建回到首页的圆球
- (void)createBallOfGoToHome
{
    self.lbOfGoToHome=[[UILabel alloc] init];
    self.lbOfGoToHome.frame=CGRectMake(WIDTH-WLsize(10.0)-WLsize(40.0), HEIGHT-XCStatusBar-WLsize(50.0)-WLsize(40), WLsize(40), WLsize(40));
    self.lbOfGoToHome.layer.masksToBounds=YES;
    self.lbOfGoToHome.layer.borderWidth=1;
    self.lbOfGoToHome.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    self.lbOfGoToHome.layer.cornerRadius=self.lbOfGoToHome.frame.size.height/2.0;
    self.lbOfGoToHome.text=@"首页";
    self.lbOfGoToHome.textAlignment=NSTextAlignmentCenter;
    self.lbOfGoToHome.textColor=UIColorFromRGB(0x1010101, 1);
    self.lbOfGoToHome.font=[UIFont systemFontOfSize:WLsize(12.0)];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGoToHome)];
    self.lbOfGoToHome.userInteractionEnabled=YES;
    [self.lbOfGoToHome addGestureRecognizer:ges];
    [self.view addSubview:self.lbOfGoToHome];
    
}
#pragma mark --点击回到首页
-(void)clickGoToHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    
    return heigth;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell1:cell AtIndexPath:indexPath];
    return cell;
    }

#pragma mark --创建cell
- (void)createCell1:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    WLCodeListModel *model =[self.arrayOfData objectAtIndex:indexPath.row];
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(WLsize(10.0), WLsize(10.0), WIDTH-WLsize(20.0), KCellHeight-WLsize(10.0));
    view.layer.masksToBounds=YES;
    view.layer.borderWidth=1.0;
    view.layer.cornerRadius=10.0;
    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [cell.contentView addSubview:view];
    UILabel *lb1 = [[UILabel alloc] init];
    lb1.frame=CGRectMake(0, WLsize(38.0), view.frame.size.width, WLsize(25.0));
    lb1.textColor=WLTEXTCOLOR;
    lb1.font=[UIFont systemFontOfSize:WLsize(17.0)];
    lb1.textAlignment=NSTextAlignmentCenter;
    lb1.text=model.name;
    [view addSubview:lb1];
    UIImageView *imageview =[[UIImageView alloc] init];
    imageview.frame=CGRectMake((view.frame.size.width-WLsize(150.0))/2.0, CGRectGetMaxY(lb1.frame)+WLsize(15.0), WLsize(150.0), WLsize(150.0));
    //    imageview.image =[UIImage imageNamed:@""];
    imageview.layer.masksToBounds=YES;
    imageview.layer.cornerRadius=30.0;
    [imageview sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    imageview.backgroundColor=[UIColor grayColor];
//    self.imageviewOfCode=imageview;
    [view addSubview:imageview];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
