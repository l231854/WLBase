//
//  WLShopServiceViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/21.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLShopServiceViewController.h"

@interface WLShopServiceViewController ()

@end

@implementation WLShopServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"店内服务";
    [self createUI];
    [self createRight];
}
#pragma mark --创建UI
- (void)createUI{
    CGFloat ww=WLsize(149.0);
    CGFloat hh =WLsize(134.0);
    CGFloat seph= WLsize(10.0);
    NSArray *temp1=[[NSArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    NSArray *temp2=[[NSArray alloc] initWithObjects:@"员工帮点",@"餐桌管理",@"买单收菜", nil];

    for (int i=0; i<3; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame=CGRectMake((WIDTH-ww)/2.0, WLsize(75.0)+(hh+seph)*i, ww, hh);
        view.layer.masksToBounds=YES;
        view.layer.borderWidth=1.0;
        view.layer.cornerRadius=10.0;
        view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
        [self.view addSubview:view];
        
        UIImageView *imageview =[[UIImageView alloc] init];
        imageview.frame=CGRectMake((view.frame.size.width-WLsize(60.0))/2.0, WLsize(23.0), WLsize(60.0), WLsize(60.0));
            imageview.image =[UIImage imageNamed:[temp1 objectAtIndex:i]];
        imageview.layer.masksToBounds=YES;
        imageview.layer.cornerRadius=imageview.frame.size.height/2.0;
        imageview.backgroundColor=[UIColor grayColor];
        [view addSubview:imageview];
        
        UILabel *lb1 = [[UILabel alloc] init];
        lb1.frame=CGRectMake(0, CGRectGetMaxY(imageview.frame)+WLsize(18.0), view.frame.size.width, WLsize(24.0));
        lb1.textColor=WLTEXTCOLOR;
        lb1.font=[UIFont systemFontOfSize:WLsize(17.0)];
        lb1.textAlignment=NSTextAlignmentCenter;
        lb1.text=[temp2 objectAtIndex:i];
        [view addSubview:lb1];
    
    }
    
}
#pragma mark--创建右侧按钮
-(void)createRight
{
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame=CGRectMake(0, 0, 40, 40);
    //    [right setTitle:@"right" forState:UIControlStateNormal];
    [right setImage:[UIImage imageNamed:@"icon11"] forState:UIControlStateNormal];
    [right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    [right setNewBadge:@"591"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
}


#pragma mark --- 方法
- (void)clickRight
{
  
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
