//
//  WLHelperViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/21.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLHelperViewController.h"
#import "WLSetShopViewController.h"
@interface WLHelperViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *arrayOfData;
@end

@implementation WLHelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"开店小助手";
    self.arrayOfData=[[NSMutableArray alloc] initWithObjects:@"我们是什么",@"如何加入我们",@"提高客流量的业务有哪些", nil];
    [self createUI];
    
}

#pragma mark --创建UI
- (void)createUI{
    if (self.tableview==nil) {
        self.tableview=[[UITableView alloc] init];
    }
    self.tableview.frame = CGRectMake(0, 0, WIDTH, HEIGHT-XCStatusBar);
    self.tableview.backgroundColor=[UIColor whiteColor];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    [self createBallOfGoToHome];
}


#pragma mark--UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigth=44;
    return heigth;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
    UILabel *lbOfContent =[[UILabel alloc] init];
    lbOfContent.frame=CGRectMake(WLsize(15.0),9, 220, 26.0);
    lbOfContent.textColor=UIColorFromRGB(0x030303, 1);
    lbOfContent.font=[UIFont systemFontOfSize:17.0];
    lbOfContent.text=[self.arrayOfData objectAtIndex:indexPath.row];
    [cell.contentView addSubview:lbOfContent];
    
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.frame= CGRectMake(WIDTH-WLsize(15)-8, 15, 8, 13);
    imageview.image=[UIImage imageNamed:@"dyp101"];
    [cell.contentView addSubview:imageview];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strContent = [self.arrayOfData objectAtIndex:indexPath.row];
    WLSetShopViewController *vc = [[WLSetShopViewController alloc] init];
    vc.title=strContent;
    [self.navigationController pushViewController:vc animated:YES];
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
