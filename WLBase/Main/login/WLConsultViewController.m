//
//  WLConsultViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/20.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLConsultViewController.h"
#import "WLConsultTableViewCell.h"
#import "WLConsultModel.h"
@interface WLConsultViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *arrayOfData;

@end

@implementation WLConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=[NSString stringWithFormat:@"%@咨询",APPNAME];
    self.arrayOfData=[[NSMutableArray alloc] init];
    WLConsultModel *model =[[WLConsultModel alloc] init];
    model.name=@"文章名字";
    model.time=@"6月5日";
    model.imageUrl=@"http://img.zcool.cn/community/0142135541fe180000019ae9b8cf86.jpg@1280w_1l_2o_100sh.png";
    model.content=@"图文并茂";
    [self.arrayOfData addObject:model];
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
    CGFloat heigth=HEIGHT-XCStatusBar;
    return heigth;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLConsultTableViewCell *cell = [WLConsultTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [self.arrayOfData objectAtIndex:indexPath.row];
    
    return cell;
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
