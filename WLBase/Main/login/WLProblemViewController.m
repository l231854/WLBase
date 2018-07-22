//
//  WLProblemViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/22.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLProblemViewController.h"

@interface WLProblemViewController ()

@end

@implementation WLProblemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}
#pragma mark --创建UI
-(void)createUI{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, 0, WIDTH, WLsize(190));
    [self.view addSubview:view];
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.frame=CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    imageview.image =[UIImage imageNamed:@"problem_top_bg"];
    [view addSubview:imageview];
    
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
