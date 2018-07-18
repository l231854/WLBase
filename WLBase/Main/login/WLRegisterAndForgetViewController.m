//
//  WLRegisterAndForgetViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/6/4.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLRegisterAndForgetViewController.h"
#define KSep1 30
#define KHeight 44
#define KSepH 30
#define KFont 15
@interface WLRegisterAndForgetViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *textField1;
@property (nonatomic,strong) UITextField *textField2;
@property (nonatomic,strong) UITextField *textField3;
@property (nonatomic,strong) UITextField *textField4;
@property (nonatomic,strong) UIButton *btnSelect;

@end

@implementation WLRegisterAndForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title=@"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self buildBackBarButtonItemGrayCoolr];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)buildBackBarButtonItemGrayCoolr
{
    self.navigationItem.leftBarButtonItem = nil;
    
   
        UIImage* img = [UIImage imageNamed:@"nav_icon_back"];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //btn.backgroundColor = [UIColor redColor];
        btn.frame = CGRectMake(0, 0, img.size.width, img.size.height);
        [btn setImage:img forState:UIControlStateNormal];
        [btn setImage:img forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
   
}
- (void)backBtnClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- 创建UI
- (void)createUI
{
    //手机号view
    UIView *view1 = [[UIView alloc] init];
    view1.frame= CGRectMake(KSep1, 30, WIDTH-2*KSep1, KHeight);
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
    textField1.font=[UIFont systemFontOfSize:KFont];
    textField1.placeholder=@"请输入手机号";
    self.textField1=textField1;
    [view1 addSubview:textField1];
    
    //密码view
    UIView *view2 = [[UIView alloc] init];
    view2.frame= CGRectMake(KSep1, CGRectGetMaxY(view1.frame)+KSepH, WIDTH-2*KSep1, KHeight);
    view2.backgroundColor = DEFAULT_BackgroundView_COLOR;
    view2.layer.masksToBounds=YES;
    view2.layer.cornerRadius=4;
    [self.view addSubview:view2];
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.frame=CGRectMake(20,(KHeight-46.0/2)/2.0 , 32.0/2, 46.0/2);
    imageView2.image=[UIImage imageNamed:@"YZM"];
    [view2 addSubview:imageView2];
    UITextField *textField2 = [[UITextField alloc] init];
    textField2.frame=CGRectMake(CGRectGetMaxX(imageView2.frame)+20, 0, view2.frame.size.width-CGRectGetMaxX(imageView2.frame)-20, KHeight);
    
    textField2.delegate=self;
    textField2.placeholder=@"请输入验证码";
    textField2.font=[UIFont systemFontOfSize:KFont];
    UIButton *btncode = [[UIButton alloc] init];
    btncode.frame=CGRectMake(textField2.frame.size.width-110, 0, 100, KHeight);
    [btncode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btncode setTitleColor:UIColorFromRGB(0xFF8000, 1) forState:UIControlStateNormal];
    btncode.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [btncode addTarget:self action:@selector(clickCode) forControlEvents:UIControlEventTouchUpInside];
    [textField2 addSubview:btncode];
    self.textField2=textField2;
    [view2 addSubview:textField2];
    
    //密码view
    UIView *view3 = [[UIView alloc] init];
    view3.frame= CGRectMake(KSep1, CGRectGetMaxY(view2.frame)+KSepH, WIDTH-2*KSep1, KHeight);
    view3.backgroundColor = DEFAULT_BackgroundView_COLOR;
    view3.layer.masksToBounds=YES;
    view3.layer.cornerRadius=4;
    [self.view addSubview:view3];
    UIImageView *imageView3 = [[UIImageView alloc] init];
    imageView3.frame=CGRectMake(20,(KHeight-21.0)/2.0 , 17.0, 21.0);
    imageView3.image=[UIImage imageNamed:@"mm"];
    [view3 addSubview:imageView3];
    UITextField *textField3 = [[UITextField alloc] init];
    textField3.frame=CGRectMake(CGRectGetMaxX(imageView3.frame)+20, 0, view3.frame.size.width-CGRectGetMaxX(imageView3.frame)-20, KHeight);
    textField3.delegate=self;
    textField3.font=[UIFont systemFontOfSize:KFont];
    textField3.placeholder=@"请输入新密码";
    self.textField3=textField3;
    [view3 addSubview:textField3];
    
    //密码view
    UIView *view4 = [[UIView alloc] init];
    view4.frame= CGRectMake(KSep1, CGRectGetMaxY(view3.frame)+KSepH, WIDTH-2*KSep1, KHeight);
    view4.backgroundColor = DEFAULT_BackgroundView_COLOR;
    view4.layer.masksToBounds=YES;
    view4.layer.cornerRadius=4;
    [self.view addSubview:view4];
    UIImageView *imageView4 = [[UIImageView alloc] init];
    imageView4.frame=CGRectMake(20,(KHeight-21.0)/2.0 , 17.0, 21.0);
    imageView4.image=[UIImage imageNamed:@"mm"];
    [view4 addSubview:imageView4];
    UITextField *textField4 = [[UITextField alloc] init];
    textField4.frame=CGRectMake(CGRectGetMaxX(imageView3.frame)+20, 0, view4.frame.size.width-CGRectGetMaxX(imageView3.frame)-20, KHeight);
    textField4.delegate=self;
    textField4.tag=4;
    textField4.font=[UIFont systemFontOfSize:KFont];
    textField4.placeholder=@"请再次输入新密码";
    self.textField4=textField4;
    [view4 addSubview:textField4];
    if ([self.isFlag isEqualToString:@"1"]) {
        //用户协议
        UIButton *btnw = [[UIButton alloc] init];
        btnw.frame=CGRectMake(view4.frame.origin.x+10, CGRectGetMaxY(view4.frame)+24, 34, 34);
        [btnw setImage:[UIImage imageNamed:@"OFF"] forState:UIControlStateNormal];
        btnw.selected=NO;
        [btnw addTarget:self action:@selector(clickSelect:) forControlEvents:UIControlEventTouchUpInside];
        self.btnSelect=btnw;
        [self.view addSubview:btnw];
    UILabel *lb1=[[UILabel alloc] init];
    lb1.text=@"我已同意并阅读《小智用户协议》";
    lb1.font=[UIFont systemFontOfSize:14];
    lb1.frame=CGRectMake(CGRectGetMaxX(btnw.frame)+5, btnw.frame.origin.y, 230, 34);
    [lb1 setAttributedText:[self changeLabelWithTextOfPrice2:lb1.text]];
    lb1.userInteractionEnabled=YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickProtocol)];
    [lb1 addGestureRecognizer:ges];
    [self.view addSubview:lb1];
    }
    
    //注册
    UIButton *btn2 = [[UIButton alloc] init];
    CGFloat sep1=100;
    if ([self.isFlag isEqualToString:@"1"]) {
        [btn2 setTitle:@"注册" forState:UIControlStateNormal];
        sep1=95;
    }
    else if ([self.isFlag isEqualToString:@"2"])
    {
        [btn2 setTitle:@"重置密码" forState:UIControlStateNormal];
        sep1=42;

    }
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.frame=CGRectMake(KSep1, CGRectGetMaxY(view4.frame)+sep1, WIDTH-2*KSep1, KHeight);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"bnt"] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor whiteColor];
    [btn2 addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
    
    self.view.userInteractionEnabled =YES;
    UITapGestureRecognizer *ges2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOther)];
    [self.view addGestureRecognizer:ges2];
}
#pragma mark --点击空白处
- (void)clickOther
{
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
    [self.textField4 resignFirstResponder];

}

#pragma mark --点击选框
- (void)clickSelect:(UIButton *)btn
{
    btn.selected=!btn.selected;
    if (btn.selected) {
        [btn setImage:[UIImage imageNamed:@"ON"] forState:UIControlStateNormal];

    }
    else{
        [btn setImage:[UIImage imageNamed:@"OFF"] forState:UIControlStateNormal];

    }
}
                                                                                       
#pragma mark -- 点击注册或者重置密码
- (void)clickLogin
{
    if ([self.isFlag isEqualToString:@"1" ]) {
        
    }
    else if ([self.isFlag isEqualToString:@"2"])
    {
        
    }
}
#pragma mark --点击协议
-(void)clickProtocol
{
                                                                                                           
}
#pragma mark --点击获取验证码
-(void)clickCode
{
    
}
//富文本
-(NSMutableAttributedString*)changeLabelWithTextOfPrice2:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    [attrString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x444444, 1) range:NSMakeRange(0,7)];
    
    [attrString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xFF8000, 1) range:NSMakeRange(7,needText.length-7)];
//    [attrString addAttribute:NSForegroundColorAttributeName value:UIColorFromInt(254, 169, 50, 1) range:NSMakeRange(7,needText.length-7)];

    
    
    return attrString;
}

#pragma mark --
- (void)keyboardWillShow:(NSNotification *)notification{
    CGFloat ty=0;
 
    if (self.textField4.editing||self.textField3.editing) {
        if (HEIGHT<=568) {
            ty=44;
            CGRect frame = self.view.frame;
            frame.origin.y =-ty+XCStatusBar2;
            self.view.frame = frame;
        }
    }
   

  
    
}
//实现回收键盘时，输入框恢复原来的位置
- (void)keyboardWillHide:(NSNotification *)notification {
    //恢复到默认y为0的状态，有时候要考虑导航栏要+64
    CGRect frame = self.view.frame;
    frame.origin.y = XCStatusBar2;
    self.view.frame = frame;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
