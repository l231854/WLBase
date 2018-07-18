//
//  XCLoginViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/6/3.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "XCLoginViewController.h"
#import "WLRegisterAndForgetViewController.h"
#import "AppDelegate.h"
#import "PublicNavViewController.h"
#import "XCNavigationModalViewController.h"
#import "ViewController.h"
#define KSep1 30
#define KHeight 44

@interface XCLoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *textField1;
@property (nonatomic,strong) UITextField *textField2;

@end

@implementation XCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"食饭了登录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = nil;

}
#pragma mark -- 创建UI
- (void)createUI
{
    //手机号view
    UIView *view1 = [[UIView alloc] init];
    view1.frame= CGRectMake(KSep1, 100, WIDTH-2*KSep1, KHeight);
    view1.backgroundColor = DEFAULT_BackgroundView_COLOR;
    view1.layer.masksToBounds=YES;
    view1.layer.cornerRadius=4;
    [self.view addSubview:view1];
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.frame=CGRectMake(20,(KHeight-46.0/2)/2.0 , 32.0/2, 46.0/2);
    imageView1.image=[UIImage imageNamed:@"sj"];
    [view1 addSubview:imageView1];
    UITextField *textField1 = [[UITextField alloc] init];
    textField1.frame=CGRectMake(CGRectGetMaxX(imageView1.frame)+20, 0, view1.frame.size.width-CGRectGetMaxX(imageView1.frame)-20, KHeight);
    textField1.delegate=self;
    textField1.placeholder=@"请输入手机号";
    textField1.font=[UIFont systemFontOfSize:15];
    self.textField1=textField1;
    [view1 addSubview:textField1];
    
    //密码view
    UIView *view2 = [[UIView alloc] init];
    view2.frame= CGRectMake(KSep1, CGRectGetMaxY(view1.frame)+44, WIDTH-2*KSep1, KHeight);
    view2.backgroundColor = DEFAULT_BackgroundView_COLOR;
    view2.layer.masksToBounds=YES;
    view2.layer.cornerRadius=4;
    [self.view addSubview:view2];
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.frame=CGRectMake(20,(KHeight-46.0/2)/2.0 , 32.0/2, 46.0/2);
    imageView2.image=[UIImage imageNamed:@"mm"];
    [view2 addSubview:imageView2];
    UITextField *textField2 = [[UITextField alloc] init];
    textField2.frame=CGRectMake(CGRectGetMaxX(imageView2.frame)+20, 0, view2.frame.size.width-CGRectGetMaxX(imageView2.frame)-20, KHeight);
    textField2.delegate=self;
    textField2.placeholder=@"请输入密码";
    textField2.font=[UIFont systemFontOfSize:15];
    self.textField2=textField2;
    [view2 addSubview:textField2];
    //忘记密码
    UIButton *btn1 = [[UIButton alloc] init];
    [btn1 setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [btn1 setTitleColor:UIColorFromRGB(0x333333, 1) forState:UIControlStateNormal];
    btn1.titleLabel.font=[UIFont systemFontOfSize:14];
    btn1.frame=CGRectMake(WIDTH-120, CGRectGetMaxY(view2.frame)+20, 100, 44);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 addTarget:self action:@selector(clickForget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    //登陆
    UIButton *btn2 = [[UIButton alloc] init];
    [btn2 setTitle:@"登录" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.frame=CGRectMake(KSep1, CGRectGetMaxY(btn1.frame)+48, WIDTH-2*KSep1, KHeight);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"bnt"] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor whiteColor];
    [btn2 addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    //还没有账号，点击注册
    UILabel *lb1=[[UILabel alloc] init];
    lb1.text=@"还没有账号，点击注册";
    lb1.font=[UIFont systemFontOfSize:15];
    lb1.frame=CGRectMake((WIDTH-160)/2, CGRectGetMaxY(btn2.frame)+22, 200, 44);
    [lb1 setAttributedText:[self changeLabelWithTextOfPrice2:lb1.text]];
    lb1.userInteractionEnabled=YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRegister)];
    [lb1 addGestureRecognizer:ges];
    [self.view addSubview:lb1];
    
    
    self.view.userInteractionEnabled =YES;
    UITapGestureRecognizer *ges2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOther)];
    [self.view addGestureRecognizer:ges2];
}

#pragma mark --点击空白处
- (void)clickOther
{
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
}
#pragma mark -- 点击忘记密码?
-(void)clickForget
{
    WLRegisterAndForgetViewController *vc = [[WLRegisterAndForgetViewController alloc] init];
    vc.isFlag=@"2";
    vc.title=@"忘记密码";
    XCNavigationModalViewController *nav = [[XCNavigationModalViewController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}
#pragma mark -点击登陆
- (void)clickLogin
{
    [MobileData sharedInstance].custPhone=@"18010855578";
    [MobileData sharedInstance].custNickName=@"管理员";
    [[NSNotificationCenter defaultCenter] postNotificationName:KLoginSuccessfulNotification object:nil];
//    AppDelegate* appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"loginCreateHome"];
//    appDelegate.window.rootViewController =
//    [[PublicNavViewController alloc] initWithRootViewController:[[ViewController alloc] init]];
}
#pragma mark --点击注册
- (void)clickRegister
{
    WLRegisterAndForgetViewController *vc = [[WLRegisterAndForgetViewController alloc] init];
    vc.isFlag=@"1";
    vc.title=@"注册";
    XCNavigationModalViewController *nav = [[XCNavigationModalViewController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}
//富文本
-(NSMutableAttributedString*)changeLabelWithTextOfPrice2:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    [attrString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x666666, 1) range:NSMakeRange(0,needText.length-4)];
    
    [attrString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xFF8000, 1) range:NSMakeRange(needText.length-4,4)];

    
    
    return attrString;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
