//
//  SecondViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/3/5.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "SecondViewController.h"
#import "OtherViewController.h"
#define WLPageIndex 20
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
//分页
@property (nonatomic) int pageIndexpage;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.title =@"发现";

    [self.navigationController.navigationBar setTitleTextAttributes:
     @{
       NSForegroundColorAttributeName :[UIColor blackColor],
       NSFontAttributeName : [UIFont systemFontOfSize:36/2]
       }];
    [self createNavigationItem];

}
#pragma mark---UI
- (void)createNavigationItem{
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame=CGRectMake(0, 0, 40, 40);
    [right setTitle:@"right" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
}

#pragma mark -- 刷新和加载更多
- (void)reloadData
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];
//    或
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
#pragma mark --- 请求
- (void)sendRequest
{
    
}

#pragma mark -- 分页请求
- (void)sendRequstOfPage
{
    NSString* url = [NSString stringWithFormat:@"%@%@", @"",@""];
    NSDictionary *dic = @{@"custId":@"",@"skuIdList":@""};
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HttpRequest getWebData:dic path:url method:@"POST" ishowLoading:NO success:^(id object) {
        NSLog(@"%@", object);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ( [object[@"success"] integerValue] == 1 )
        {
        }else{
            [MBProgressHUD showWithMessage:object[@"msg"]];
            
            NSString *rest = object[@"errorCode"];
            if ([rest isEqualToString:KFalseAccruedTokenStr]) {
                
                
            }
        }
        
        
    } fail:^(NSString *msg) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showWithMessage:msg];
        
    }];
    __weak typeof(self)weakSelf=self;
   
}

#pragma mark --- 方法
- (void)clickRight
{
    OtherViewController *vc = [[OtherViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.title =nil;
    self.tabBarController.navigationItem.rightBarButtonItem =nil;

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
