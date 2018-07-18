//
//  SearchViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/3/7.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "SearchViewController.h"
#import "CustomeTitleView.h"
@interface SearchViewController ()<UITextFieldDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavigationItem];
}
#pragma mark-- 创建UI
- (void)initNavigationItem
{
    //清空tabBarController的navigationItem
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem. titleView = nil;
    self.title = nil;
    //left
//    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
//    left.frame=CGRectMake(0, 0, 0, 0);
//    [left setTitle:@"" forState:UIControlStateNormal];
//    [left addTarget:self action:@selector(clickLeft) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:left];
//    [self.navigationItem.leftBarButtonItem setBackgroundVerticalPositionAdjustment:-40 forBarMetrics:UIBarMetricsDefault];
        [self.navigationItem setHidesBackButton:YES];

    //middle
    UIView *headView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH-80, 35)];
    headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    headView.layer.masksToBounds=YES;
    headView.layer.cornerRadius=6.0;

    UIImageView *imageViewOfSearch = [[UIImageView alloc] init];
    imageViewOfSearch.image=[UIImage imageNamed:@"input_icon_search"];
    imageViewOfSearch.frame=CGRectMake(5, (headView.frame.size.height-16/667.0*HEIGHT)/2.0, 16/667.0*HEIGHT, 16/667.0*HEIGHT);
    [headView addSubview:imageViewOfSearch];
    UITextField *textFieldOfSearch = [[UITextField alloc] init];
    textFieldOfSearch.frame = CGRectMake(CGRectGetMaxX(imageViewOfSearch.frame)+5, 0, headView.frame.size.width-CGRectGetMaxX(imageViewOfSearch.frame)-5, headView.frame.size.height);
    textFieldOfSearch.placeholder=@"搜索";
    textFieldOfSearch.delegate=self;
    [headView addSubview:textFieldOfSearch];
    self.navigationItem.titleView=headView;

    //right
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame=CGRectMake(0, 0, 40, 40);
    [right setTitle:@"取消" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    
}


#pragma mark --- function
- (void)clickRight
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickLeft
{
    
}

//点击键盘return
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *text = textField.text;
    return YES;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //清空tabBarController的navigationItem
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem. titleView = nil;
    self.title = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
