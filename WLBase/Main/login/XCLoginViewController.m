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
#import "WXApi.h"
#import "XCThirdLoginExUserInfo.h"
#import "XCThirdBackResult.h"
#import <ShareSDK/ShareSDK.h>
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWeixinLoginAppResult:) name:@"weixinLogin" object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = nil;

}

#pragma mark --微信登陆
- (void)handleWeixinLoginAppResult:(NSNotification *)notification
{
    BaseResp* resultDic = (BaseResp *) notification.object;
    [self receiveWeixinResponseWith:resultDic];
}
#pragma mark -- 创建UI
- (void)createUI
{
    //手机号view
    UIView *view1 = [[UIView alloc] init];
    view1.frame= CGRectMake(KSep1, 40, WIDTH-2*KSep1, KHeight);
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
    UIButton *btnOfSend = [[UIButton alloc] init];
    btnOfSend.frame=CGRectMake(view1.frame.size.width-80, 5, 80, 22);
    btnOfSend.layer.masksToBounds=YES;
    btnOfSend.layer.cornerRadius=5;
    btnOfSend.layer.borderWidth=1;
    btnOfSend.layer.borderColor=UIColorFromRGB(0x666666, 1).CGColor;
    [btnOfSend setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btnOfSend addTarget:self action:@selector(clickSend) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:textField1];
    
    //密码view
    UIView *view2 = [[UIView alloc] init];
    view2.frame= CGRectMake(KSep1, CGRectGetMaxY(view1.frame)+10, WIDTH-2*KSep1, KHeight);
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
   
    //登陆
    UIButton *btn2 = [[UIButton alloc] init];
    [btn2 setTitle:@"登录" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.frame=CGRectMake(KSep1, CGRectGetMaxY(view2.frame)+30, WIDTH-2*KSep1, KHeight);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"bnt"] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor whiteColor];
    [btn2 addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame=CGRectMake((WIDTH-60)/2.0, HEIGHT-150, 60, 60);
    imageView.backgroundColor = [UIColor grayColor];
    imageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *ges =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWXLogin)];
    [imageView addGestureRecognizer:ges];
    [self.view addSubview:imageView];
    
    //还没有账号，点击注册
    UILabel *lb1=[[UILabel alloc] init];
    lb1.text=@"微信登录";
    lb1.font=[UIFont systemFontOfSize:15];
    CGSize size=XCsizeWithFont(lb1.text,  lb1.font);
    lb1.frame=CGRectMake((WIDTH-40-size.width)/2.0, imageView.frame.origin.y-50, size.width+40, 30);
    lb1.textAlignment=NSTextAlignmentCenter;
    lb1.textColor=UIColorFromRGB(0x333333, 1);
    [self.view addSubview:lb1];
    
    UILabel *sep1 = [[UILabel alloc] init];
    sep1.frame=CGRectMake(KSep1, lb1.frame.origin.y+lb1.frame.size.height/2.0,(WIDTH-40-size.width-KSep1*2)/2.0 , 1.0);
    sep1.backgroundColor=UIColorFromRGB(0xEEEEEE, 1);
    [self.view addSubview:sep1];
    
    UILabel *sep2 = [[UILabel alloc] init];
    sep2.frame=CGRectMake(CGRectGetMaxX(lb1.frame), lb1.frame.origin.y+lb1.frame.size.height/2.0,(WIDTH-40-size.width-KSep1*2)/2.0 , 1.0);
    sep2.backgroundColor=UIColorFromRGB(0xEEEEEE, 1);
    [self.view addSubview:sep2];
    
    
  
}

#pragma mark --点击微信登陆
-(void)clickWXLogin
{
//    SendAuthReq* req =[[SendAuthReq alloc ] init];
//    
//    //都有哪些权限
//    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_contact";
//    //应用标示，两个程序之间跳转的标示
//    req.state = @"0744";
//    //调微信客户端
//    [WXApi sendReq:req];
//    [WXApi sendAuthReq:req viewController:self delegate:self];
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
#pragma mark----------------------------------------------微信登陆--------------------------------------------------------
//微信登陆的回调
- (void)receiveWeixinResponseWith:(BaseResp*)resp
{
    /*
     ErrCode ERR_OK = 0(用户同意)
     ERR_AUTH_DENIED = -4（用户拒绝授权）
     ERR_USER_CANCEL = -2（用户取消）
     code    用户换取access_token的code，仅在ErrCode为0时有效
     state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
     lang    微信客户端当前语言
     country 微信用户当前国家信息
     */
    SendAuthResp *aresp = (SendAuthResp *)resp;
    
    //aresp.errCode == 0时用户同意
    
    if (aresp.errCode == 0) {
        //然后拿到code
        NSString *code = aresp.code;//拿着这个code我们去请求token，得到token我们后请求个人信息
        
        //NSDictionary *dic = @{@"code":code};
        [self getAccess_tokenwith:code];
        
        
    }
}
//获取touken
-(void)getAccess_tokenwith:(NSString*)code
{
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    //获取用户token
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WEIXIN_APPKEY,WEIXIN_WEIXINSECRET,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                NSLog(@"------------token%@-----------",dic);
                
                
                [self getUserInfoWith:dic[@"access_token"] withOpenid:dic[@"openid"]];
                
            }
        });
    });
}
//根据返回的token获取用户信息
-(void)getUserInfoWith:(NSString*)access_token  withOpenid:(NSString*)openId
{
    // https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
    //获取用户信息
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openId];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"------------用户信息%@-----------",dic);
                
                
                XCThirdLoginExUserInfo *exUserInfo = [XCThirdLoginExUserInfo mj_objectWithKeyValues:dic];
                
                NSString *sex = exUserInfo.sex;
                if ([exUserInfo.sex intValue] == 1) {
                    sex = @"男";
                }else if ([exUserInfo.sex intValue] == 2) {
                    sex = @"女";
                }else
                {
                    sex = @"";
                }
                NSString * headimgurl = exUserInfo.headimgurl;
                NSString *nickname = exUserInfo.nickname;
                NSString *unionid = exUserInfo.unionid;
                
                XCThirdBackResult *info = [[XCThirdBackResult alloc] init];
                info.custSex = sex;
                info.custNickName = nickname;
                info.custHeadpic = headimgurl;
                info.thridUserId = unionid;
             
                
                [self uploadIconImage:nil WithInfo:info LoginMethod:1];
                
                //                }
                
                
            }
        });
        
    });
}

- (void)uploadIconImage:(UIImage *)image WithInfo:(XCThirdBackResult *)info LoginMethod:(NSInteger )loginMethod
{
    
}
//{
//    if (image) {
//        XCModifyIconParam *param = [[XCModifyIconParam alloc] init];
//        param.attach = @"1";
//        [XCUserInfoRequestTool uploadIcomImage:param andIconImage:image withView:nil success:^(XCModifyIconResult *result) {
//            if ([result.success integerValue]) {
//                if (result.model && result.model.count > 0) {
//                    XCCustheadpicUrl * url = result.model[0];
//                    if (url.fileUrl && url.fileUrl.length > 0) {
//                        info.custHeadpic = url.fileUrl;
//                    }
//
//                    if ([self.delegate respondsToSelector:@selector(loginSucceedWithLoginMethod:withTHirdInfo:)])
//                    {
//                        [self.delegate loginSucceedWithLoginMethod:loginMethod withTHirdInfo:info];
//                    }
//
//                }
//
//            }
//            else
//            {
//                [MBProgressHUD showWithMessage:result.msg];
//
//            }
//
//        } failure:^(NSString *msg) {
//
//        }];
//    }else
//    {
//        if ([self.delegate respondsToSelector:@selector(loginSucceedWithLoginMethod:withTHirdInfo:)])
//        {
//            [self.delegate loginSucceedWithLoginMethod:loginMethod withTHirdInfo:info];
//        }
//
//
//    }
//
//
//
//
//}
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
#pragma mark --获取验证码
- (void)clickSend
{
    NSLog(@"获取验证码");
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
