//
//  WLLoginViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/20.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLLoginViewController.h"
#import "WLRegisterViewController.h"
#import "WXApi.h"
#import <ShareSDK/ShareSDK.h>
#import "WLProblemViewController.h"
@interface WLLoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *textfieldOfPhone;
@property (nonatomic,strong) UITextField *textfieldOfCode;
@property (nonatomic,strong) NSMutableArray *arrayOfTextfield;

@property (nonatomic,assign) NSInteger selectType;

@end

@implementation WLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我家餐厅登录";
    self.selectType=1;
    self.view.backgroundColor = DEFAULT_BackgroundView_COLOR;
    self.view.userInteractionEnabled=YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOther)];
    [self.view addGestureRecognizer:ges];
    [self createUI];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self clickOther];
}
#pragma mark ==点击空白取消键盘
-(void)clickOther
{
    [self.textfieldOfCode resignFirstResponder];
    [self.textfieldOfPhone resignFirstResponder];
}
-(void)createUI
{
    UIView *view1 = [[UIView alloc] init];
    view1.frame=CGRectMake((WIDTH-WLsize(65))/2.0, WLsize(45), WLsize(65), WLsize(65));
    view1.layer.masksToBounds=YES;
    view1.layer.cornerRadius=WLsize(5);
    view1.backgroundColor=[UIColor blackColor];
    [self.view addSubview:view1];
    
    UIView *view11 =[[UIView alloc] init];
    view11.frame=CGRectMake(0, WLsize(155), WIDTH, WLsize(55.0));
    view11.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:view11];
    NSArray *array11 =[[NSArray alloc] initWithObjects:@"手机号验证登录",@"账号密码登录", nil];
    CGFloat ww11= WIDTH/2.0;
    CGFloat hh11=view11.frame.size.height;
    for (int w=0; w<array11.count;w++) {
        UIButton *btn11= [[UIButton alloc] init];
        btn11.frame=CGRectMake(ww11*w, 0, ww11, hh11);
        [btn11 setTitle:[array11 objectAtIndex:w] forState:UIControlStateNormal];
        btn11.tag=w+1;
        btn11.titleLabel.font=[UIFont systemFontOfSize:WLsize(17)];
        if (self.selectType==btn11.tag) {
            [btn11 setTitleColor:WLORANGColor forState:UIControlStateNormal];
        }
        else{
            [btn11 setTitleColor:UIColorFromInt(51, 51, 51, 1) forState:UIControlStateNormal];
        }
        [btn11 addTarget:self action:@selector(clickLoginType:) forControlEvents:UIControlEventTouchUpInside];
        [view11 addSubview:btn11];
        UILabel *lbOfSep = [[UILabel alloc] init];
        lbOfSep.frame=CGRectMake(ww11*w, hh11-1.0, ww11, 1.0);
        lbOfSep.backgroundColor=UIColorFromInt(220, 220, 220, 1);
        if (self.selectType==btn11.tag) {
            lbOfSep.backgroundColor=WLORANGColor;

        }
        [view11 addSubview:lbOfSep];
        
    }
    
    
    NSArray *temp1 =[[NSArray alloc] initWithObjects:@"手机号",@"验证码",  nil];
    NSArray *temp2 =[[NSArray alloc] initWithObjects:@"请输入手机号码", @"请输入验证码",  nil];
    if (self.selectType==2) {
       temp1 =[[NSArray alloc] initWithObjects:@"账号",@"密码",  nil];
       temp2 =[[NSArray alloc] initWithObjects:@"请输入账号", @"请输入密码",  nil];
    }
    CGFloat hh2=WLsize(50.0);
    UIView *view2 = [[UIView alloc] init];
    view2.frame=CGRectMake(0, CGRectGetMaxY(view11.frame), WIDTH, hh2*temp1.count);
    view2.backgroundColor=[UIColor whiteColor];
    //    view2.layer.masksToBounds=YES;
    //    view2.layer.borderWidth=1.0;
    //    view2.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [self.view addSubview:view2];
    
    NSMutableArray *tempArray =[[NSMutableArray alloc] init];
    for (int j=0; j<temp1.count; j++) {
        UIView *view3 = [[UIView alloc] init];
        view3.frame=CGRectMake(0,hh2*j, WIDTH, hh2);
        view3.backgroundColor=[UIColor whiteColor];
        [view2 addSubview:view3];
        
        UILabel *lbPhone = [[UILabel alloc] init];
        lbPhone.frame=CGRectMake(WLsize(13.0), (view3.frame.size.height-WLsize(36.0))/2.0, WLsize(60.0), WLsize(36.0));
        lbPhone.textColor=UIColorFromInt(51, 51, 51, 1);
        lbPhone.font=[UIFont systemFontOfSize:WLsize(17.0)];
        lbPhone.text=[temp1 objectAtIndex:j];
        [view3 addSubview:lbPhone];
        
        UITextField *textfieldPhone = [[UITextField alloc] init];
        textfieldPhone.frame=CGRectMake(CGRectGetMaxX(lbPhone.frame)+WLsize(19.0), (view3.frame.size.height-WLsize(36.0))/2.0, WLsize(155.0), WLsize(36.0));
        textfieldPhone.textColor=UIColorFromInt(51, 51, 51, 1);
        textfieldPhone.font=[UIFont systemFontOfSize:WLsize(17.0)];
        textfieldPhone.placeholder=[temp2 objectAtIndex:j];
        // 就下面这两行是重点
        NSAttributedString *attrString1 = [[NSAttributedString alloc] initWithString:[temp2 objectAtIndex:j] attributes:
                                           @{NSForegroundColorAttributeName:UIColorFromInt(153, 153, 153, 1),
                                             NSFontAttributeName:textfieldPhone.font
                                             }];
        textfieldPhone.attributedPlaceholder = attrString1;
        textfieldPhone.delegate=self;
        textfieldPhone.tag=j+1;
        [tempArray addObject:textfieldPhone];
        [view3 addSubview:textfieldPhone];
        
        if ([lbPhone.text isEqualToString:@"手机号"]) {
            UIButton *btnOfSend = [[UIButton alloc] init];
            btnOfSend.frame = CGRectMake(WIDTH-WLsize(106.0), WLsize(10.0), WLsize(96.0), WLsize(30.0));
            btnOfSend.layer.masksToBounds=YES;
//            btnOfSend.layer.borderWidth=1.0/2;
//            btnOfSend.layer.borderColor=WLORANGColor.CGColor;
            btnOfSend.layer.cornerRadius=WLsize(5.0);
            [btnOfSend setTitle:@"获取验证码" forState:UIControlStateNormal];
            [btnOfSend setTitleColor:UIColorFromInt(153, 153, 153, 1) forState:UIControlStateNormal];
            btnOfSend.backgroundColor=UIColorFromInt(238, 238, 238, 1);
            btnOfSend.titleLabel.font=[UIFont systemFontOfSize:WLsize(12.0)];
            [btnOfSend addTarget:self action:@selector(clickSendCode) forControlEvents:UIControlEventTouchUpInside];
            [view3 addSubview:btnOfSend];
        }
        
        UILabel *lbOfSep =[[UILabel alloc] init];
        lbOfSep.frame= CGRectMake(WLsize(13.0), hh2-1.0, WIDTH-WLsize(26.0), 1.0);
        lbOfSep.backgroundColor=UIColorFromInt(220, 220, 220, 1);
        lbOfSep.hidden=NO;;
        [view3 addSubview:lbOfSep];
        if (j==(temp1.count-1)) {
            lbOfSep.hidden=YES;
        }
    }
    self.arrayOfTextfield=[[NSMutableArray alloc] initWithArray:tempArray];
    

    UILabel *lbOfProblem = [[UILabel alloc] init];
    lbOfProblem.frame=CGRectMake(WLsize(13.0), CGRectGetMaxY(view2.frame)+WLsize(10), WLsize(100), WLsize(23.0));
    lbOfProblem.text=@"遇见问题";
    lbOfProblem.textColor=UIColorFromInt(153, 153, 153, 1);
    lbOfProblem.font=[UIFont systemFontOfSize:WLsize(12)];
    [self.view addSubview:lbOfProblem];
    lbOfProblem.userInteractionEnabled=YES;
    UITapGestureRecognizer *gesProblem = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickProblem:)];
    [lbOfProblem addGestureRecognizer:gesProblem];
    
    UILabel *lbOfRegister = [[UILabel alloc] init];
    lbOfRegister.frame=CGRectMake(WIDTH-WLsize(100)-WLsize(13.0), lbOfProblem.frame.origin.y, WLsize(100), WLsize(23.0));
    lbOfRegister.text=@"立即注册";
    lbOfRegister.textAlignment=NSTextAlignmentRight;
    lbOfRegister.textColor=WLORANGColor;
    lbOfRegister.font=[UIFont systemFontOfSize:WLsize(12)];
    [self.view addSubview:lbOfRegister];
    lbOfRegister.userInteractionEnabled=YES;
    UITapGestureRecognizer *gesRegister = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToRegister:)];
    [lbOfRegister addGestureRecognizer:gesRegister];
    
    UIButton *btnOfRegister = [[UIButton alloc] init];
    btnOfRegister.frame = CGRectMake(WLsize(13.0), CGRectGetMaxY(view2.frame)+WLsize(45.0), WIDTH-WLsize(26.0), WLsize(40.0));
    btnOfRegister.layer.masksToBounds=YES;
//    btnOfRegister.layer.borderWidth=1.0;
//    btnOfRegister.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    btnOfRegister.layer.cornerRadius=WLsize(5);
    [btnOfRegister setTitle:@"登录" forState:UIControlStateNormal];
    [btnOfRegister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnOfRegister.titleLabel.font=[UIFont systemFontOfSize:WLsize(17.0)];
    btnOfRegister.backgroundColor=WLORANGColor;
    [btnOfRegister addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOfRegister];
    
    
    
    //微信的
    UIButton *btnOfWX = [[UIButton alloc] init];
    btnOfWX.frame=CGRectMake((WIDTH-WLsize(44))/2.0,HEIGHT-WLsize(92.0)-XCStatusBar, WLsize(44), WLsize(44));
    [btnOfWX setImage:[UIImage imageNamed:@"WeChat_icon"] forState:UIControlStateNormal];
    [btnOfWX addTarget:self action:@selector(weixinLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOfWX];
    
    UILabel *lbOfWeixin = [[UILabel alloc] init];
    lbOfWeixin.frame=CGRectMake(btnOfWX.frame.origin.x-WLsize(40.0),btnOfWX.frame.origin.y-WLsize(50), WLsize(124), WLsize(23));
    lbOfWeixin.text=@"微信登录";
    lbOfWeixin.textAlignment=NSTextAlignmentCenter;
    lbOfWeixin.textColor=UIColorFromInt(153, 153, 153, 1);
    lbOfWeixin.font=[UIFont systemFontOfSize:WLsize(12)];
    [self.view addSubview:lbOfWeixin];
    
    UILabel *lbOfSepWX = [[UILabel alloc] init];
    lbOfSepWX.frame=CGRectMake(WLsize(50), lbOfWeixin.center.y, WLsize(75), 1.0);
    lbOfSepWX.backgroundColor=WLSEPLBColor;
    [self.view addSubview:lbOfSepWX];
    UILabel *lbOfSepWX2 = [[UILabel alloc] init];
    lbOfSepWX2.frame=CGRectMake(WIDTH-WLsize(75)-WLsize(50), lbOfWeixin.center.y, WLsize(75), 1.0);
    lbOfSepWX2.backgroundColor=WLSEPLBColor;
    [self.view addSubview:lbOfSepWX2];
    
    
    
}
#pragma mark--点击切换登录方式
- (void)clickLoginType:(UIButton *)button
{
    self.selectType=button.tag;
    [self createUI];
}


#pragma mark --获取验证码
- (void)clickSendCode
{
    NSLog(@"clickSendCode");
}

#pragma mark --点击登录
- (void)clickLogin
{
    NSLog(@"clickLogin");
    [[NSNotificationCenter defaultCenter] postNotificationName:KLoginSuccessfulNotification object:nil];

}

#pragma mark --注册请求
- (void)sendRequestOfRegister
{
    if (self.selectType==1) {
        //手机号登录
    }
    else
    {
        //账号密码登录
        
    }
    UITextField *textfileld1=[self.arrayOfTextfield objectAtIndex:0];
    UITextField *textfileld2=[self.arrayOfTextfield objectAtIndex:1];
   
    
    NSDictionary *dict = @{@"custId":textfileld1.text,@"blockId":textfileld2.text};
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServer,WLURLRegister];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HttpRequest getWebData:dict path:urlStr method:@"POST" ishowLoading:false success:^(id object) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ( [object[@"success"] integerValue] == 1 )
        {
            NSDictionary *model = object[@"model"];
        }
        
    } fail:^(NSString *msg) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}

#pragma mark --textDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self clickOther];
    return YES;
}

#pragma mark--点击遇见问题
- (void)clickProblem:(UIGestureRecognizer *)ges
{
    WLProblemViewController *vc =[[WLProblemViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --点击立即注册
-(void)clickToRegister:(UIGestureRecognizer *)ges
{
    WLRegisterViewController *vc =[[WLRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --微信登录
- (void)weixinLogin:(UIButton *)button
{
    [ShareSDK authorize:SSDKPlatformTypeWechat settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess)
        {
            NSLog(@"%@",user.rawData);
            NSLog(@"uid===%@",user.uid);
            NSLog(@"%@",user.credential);
        }
        else if (state == SSDKResponseStateCancel)
        {
            NSLog(@"取消");
        }
        else if (state == SSDKResponseStateFail)
        {
            NSLog(@"%@",error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
