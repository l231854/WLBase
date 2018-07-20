//
//  WLRegisterViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/20.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLRegisterViewController.h"
#import "WLBusinessLocatedViewController.h"
#define KCellHeight3 94.0/375*WIDTH

@interface WLRegisterViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *textfieldOfPhone;
@property (nonatomic,strong) UITextField *textfieldOfCode;

@end

@implementation WLRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title=@"商家入驻";
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled=YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOther)];
    [self.view addGestureRecognizer:ges];
    
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

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
#pragma mark --创建UI
-(void)createUI
{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, WLsize(11.0), WIDTH, KCellHeight3-WLsize(10.0));
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds=YES;
    view.layer.borderWidth=1.0;
    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [self.view addSubview:view];
    CGFloat rw=44.0/375*WIDTH;
    CGFloat ballD=WLsize(20.0);
    CGFloat linew=(WIDTH-ballD*3-rw*2)/2.0;
    CGFloat rh=WLsize(24.0);
    CGFloat lbW = WLsize(100.0);
    for (int i=0; i<3; i++) {
        UIView *viewOfBall = [[UIView alloc] init];
        viewOfBall.frame=CGRectMake(rw+(ballD+linew)*i,rh,ballD, ballD);
        viewOfBall.layer.masksToBounds=YES;
        viewOfBall.layer.cornerRadius=ballD/2.0;
        viewOfBall.layer.borderWidth=1.0;
        viewOfBall.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
        [view addSubview:viewOfBall];
        if (i<2) {
            UILabel *lbOfLine = [[UILabel alloc] init];
            lbOfLine.frame=CGRectMake(CGRectGetMaxX(viewOfBall.frame), viewOfBall.frame.origin.y+ballD/2.0-1.0/2,linew, 1.0);
            lbOfLine.backgroundColor=UIColorFromRGB(0xBBBBBB, 1);
            [view addSubview:lbOfLine];
        }
        UILabel *lbOfTitle = [[UILabel alloc] init];
        lbOfTitle.frame=CGRectMake(viewOfBall.center.x-lbW/2.0, CGRectGetMaxY(viewOfBall.frame)+WLsize(9.0), lbW, WLsize(23.0));
        lbOfTitle.textAlignment=NSTextAlignmentCenter;
        lbOfTitle.textColor=UIColorFromRGB(0x101010, 1);
        lbOfTitle.font=[UIFont systemFontOfSize:WLsize(14.0)];
        NSString *strContent=@"";
        switch (i) {
            case 0:
                strContent=@"注册账号";
                break;
            case 1:
                strContent=@"认领门店";
                break;
            case 2:
                strContent=@"提交资质";
                break;
            default:
                break;
        }
        lbOfTitle.text=strContent;
        [view addSubview:lbOfTitle];
    }
    UILabel *lbOfTitle2 = [[UILabel alloc] init];
    lbOfTitle2.frame=CGRectMake(0,CGRectGetMaxY(view.frame)+WLsize(12.0), WIDTH, WLsize(23.0));
    lbOfTitle2.textColor=UIColorFromRGB(0x101010, 1);
    lbOfTitle2.font=[UIFont systemFontOfSize:WLsize(14.0)];
    lbOfTitle2.text=@"注册后可使用本手机号登录我家餐厅";
    [self.view addSubview:lbOfTitle2];
    
    
    UIView *view2 = [[UIView alloc] init];
    view2.frame=CGRectMake(0, CGRectGetMaxY(lbOfTitle2.frame)+WLsize(5.0), WIDTH, WLsize(100.0));
    view2.backgroundColor=[UIColor whiteColor];
    view2.layer.masksToBounds=YES;
    view2.layer.borderWidth=1.0;
    view2.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [self.view addSubview:view2];
    
    UILabel *lbPhone = [[UILabel alloc] init];
    lbPhone.frame=CGRectMake(WLsize(10.0), WLsize(7.0), WLsize(60.0), WLsize(36.0));
    lbPhone.textColor=UIColorFromRGB(0x101010, 1);
    lbPhone.font=[UIFont systemFontOfSize:WLsize(18.0)];
    lbPhone.text=@"手机号";
    [view2 addSubview:lbPhone];
    UITextField *textfieldPhone = [[UITextField alloc] init];
    textfieldPhone.frame=CGRectMake(CGRectGetMaxX(lbPhone.frame)+WLsize(19.0), WLsize(15.0), WLsize(155.0), WLsize(23.0));
    textfieldPhone.textColor=UIColorFromRGB(0x101010, 1);
    textfieldPhone.font=[UIFont systemFontOfSize:WLsize(14.0)];
    textfieldPhone.placeholder=@"请输入手机号";
    // 就下面这两行是重点
    NSAttributedString *attrString1 = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:
                                      @{NSForegroundColorAttributeName:UIColorFromRGB(0x101010, 1),
                                        NSFontAttributeName:textfieldPhone.font
                                        }];
    textfieldPhone.attributedPlaceholder = attrString1;
    textfieldPhone.delegate=self;
    self.textfieldOfPhone=textfieldPhone;
    [view2 addSubview:textfieldPhone];
    UIButton *btnOfSend = [[UIButton alloc] init];
    btnOfSend.frame = CGRectMake(WIDTH-WLsize(106.0), WLsize(10.0), WLsize(96.0), WLsize(30.0));
    btnOfSend.layer.masksToBounds=YES;
    btnOfSend.layer.borderWidth=1.0;
    btnOfSend.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    btnOfSend.layer.cornerRadius=4.0;
    [btnOfSend setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btnOfSend setTitleColor:UIColorFromRGB(0x101010, 1) forState:UIControlStateNormal];
    btnOfSend.titleLabel.font=[UIFont systemFontOfSize:WLsize(14.0)];
    [btnOfSend addTarget:self action:@selector(clickSendCode) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:btnOfSend];
    
    UILabel *lbOfSep = [[UILabel alloc] init];
    lbOfSep.frame=CGRectMake(WLsize(10.0), WLsize(50.0), WIDTH-WLsize(20.0), 1.0);
    lbOfSep.backgroundColor=UIColorFromRGB(0xBBBBBB, 1);
    [view2 addSubview:lbOfSep];
    UILabel *lbcode = [[UILabel alloc] init];
    lbcode.frame=CGRectMake(WLsize(10.0), CGRectGetMaxY(lbOfSep.frame)+WLsize(7.0), WLsize(60.0), WLsize(36.0));
    lbcode.textColor=UIColorFromRGB(0x101010, 1);
    lbcode.font=[UIFont systemFontOfSize:WLsize(18.0)];
    lbcode.text=@"验证码";
    [view2 addSubview:lbcode];
    UITextField *textfieldCode = [[UITextField alloc] init];
    textfieldCode.frame=CGRectMake(CGRectGetMaxX(lbcode.frame)+WLsize(19.0), CGRectGetMaxY(lbOfSep.frame)+WLsize(15.0), WLsize(155.0), WLsize(23.0));
    textfieldCode.textColor=UIColorFromRGB(0x101010, 1);
    textfieldCode.font=[UIFont systemFontOfSize:WLsize(14.0)];
    textfieldCode.placeholder=@"请输入验证码";
    // 就下面这两行是重点
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:
                                      @{NSForegroundColorAttributeName:UIColorFromRGB(0x101010, 1),
                                        NSFontAttributeName:textfieldCode.font
                                        }];
    textfieldCode.attributedPlaceholder = attrString;

    textfieldCode.delegate=self;
    self.textfieldOfCode=textfieldCode;
    [view2 addSubview:textfieldCode];
    
    
    UIButton *btnOfRegister = [[UIButton alloc] init];
    btnOfRegister.frame = CGRectMake(WLsize(10.0), CGRectGetMaxY(view2.frame)+WLsize(20.0), WIDTH-WLsize(20.0), WLsize(40.0));
    btnOfRegister.layer.masksToBounds=YES;
    btnOfRegister.layer.borderWidth=1.0;
    btnOfRegister.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    btnOfRegister.layer.cornerRadius=4.0;
    [btnOfRegister setTitle:@"立即注册" forState:UIControlStateNormal];
    [btnOfRegister setTitleColor:UIColorFromRGB(0x101010, 1) forState:UIControlStateNormal];
    btnOfRegister.titleLabel.font=[UIFont systemFontOfSize:WLsize(18.0)];
    [btnOfRegister addTarget:self action:@selector(clickRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOfRegister];
    
    
}

#pragma mark --获取验证码
- (void)clickSendCode
{
    NSLog(@"clickSendCode");
}

#pragma mark --立即注册
- (void)clickRegister
{
    NSLog(@"clickRegister");
    WLBusinessLocatedViewController *vc = [[WLBusinessLocatedViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --textDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self clickOther];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
