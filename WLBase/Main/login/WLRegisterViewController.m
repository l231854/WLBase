//
//  WLRegisterViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/20.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLRegisterViewController.h"
#import "WLBusinessLocatedViewController.h"
#define KCellHeight3 120.0/375*WIDTH

@interface WLRegisterViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *textfieldOfPhone;
@property (nonatomic,strong) UITextField *textfieldOfCode;
@property (nonatomic,strong) NSMutableArray *arrayOfTextfield;

@end

@implementation WLRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title=@"注册";
    self.view.backgroundColor = DEFAULT_BackgroundView_COLOR;
    self.view.userInteractionEnabled=YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOther)];
    [self.view addGestureRecognizer:ges];
    self.arrayOfTextfield=[[NSMutableArray alloc] init];
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
    view.frame=CGRectMake(0, WLsize(10.0), WIDTH, KCellHeight3-WLsize(10.0));
    view.backgroundColor=[UIColor whiteColor];
    view.layer.masksToBounds=YES;
//    view.layer.borderWidth=1.0;
//    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [self.view addSubview:view];
    CGFloat rw=29.0/375*WIDTH;
    CGFloat ballD=WLsize(26.0);
    CGFloat linew=(WIDTH-ballD*3-rw*2)/2.0;
    CGFloat rh=WLsize(25.0);
    CGFloat lbW = WLsize(100.0);
    for (int i=0; i<3; i++) {
        UILabel *viewOfBall = [[UILabel alloc] init];
        viewOfBall.frame=CGRectMake(rw+(ballD+linew)*i,rh,ballD, ballD);
        viewOfBall.layer.masksToBounds=YES;
        viewOfBall.layer.cornerRadius=ballD/2.0;
        
        if (i==0) {
            viewOfBall.backgroundColor=UIColorFromInt(249.0, 104.0, 28.0, 1);
        }else{
            viewOfBall.backgroundColor=UIColorFromInt(232.0, 232.0, 232.0, 1);
            
        }
        viewOfBall.textAlignment=NSTextAlignmentCenter;
        viewOfBall.font=[UIFont systemFontOfSize:WLsize(18.0)];
        viewOfBall.text=[NSString stringWithFormat:@"%d",i+1];
        viewOfBall.textColor=[UIColor whiteColor];
        
        //        viewOfBall.layer.borderWidth=1.0;
        //        viewOfBall.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
        if (i<2) {
            UILabel *lbOfLine = [[UILabel alloc] init];
            lbOfLine.frame=CGRectMake(CGRectGetMaxX(viewOfBall.frame), viewOfBall.frame.origin.y+ballD/2.0-4.0/2,linew, 4.0);
            lbOfLine.backgroundColor=UIColorFromInt(232.0, 232.0, 232.0, 1);
            [view addSubview:lbOfLine];
        }
        
        UILabel *viewOfBall2 = [[UILabel alloc] init];
        viewOfBall2.frame=CGRectMake(rw+(ballD+linew)*i-WLsize(5.0),rh-WLsize(5.0),ballD+WLsize(10.0), ballD+WLsize(10.0));
        viewOfBall2.layer.masksToBounds=YES;
        viewOfBall2.layer.cornerRadius=viewOfBall2.frame.size.width/2.0;
        viewOfBall2.backgroundColor=UIColorFromInt(249.0, 180.0, 145.0, 1);
        if (i==0) {
            viewOfBall2.hidden=NO;
            [view addSubview:viewOfBall2];
            
            
        }else{
            viewOfBall2.hidden=YES;
            
        }
        [view addSubview:viewOfBall];
        
        UILabel *lbOfTitle = [[UILabel alloc] init];
        lbOfTitle.frame=CGRectMake(viewOfBall.center.x-lbW/2.0, CGRectGetMaxY(viewOfBall.frame)+WLsize(9.0), lbW, WLsize(23.0));
        lbOfTitle.textAlignment=NSTextAlignmentCenter;
        if (i==0) {
            lbOfTitle.textColor=UIColorFromInt(249.0, 104.0, 28.0, 1);
        }
        else{
            lbOfTitle.textColor=  UIColorFromInt(232.0, 232.0, 232.0, 1);
        }
        lbOfTitle.font=[UIFont systemFontOfSize:WLsize(15.0)];
        NSString *strContent=@"";
        switch (i) {
            case 0:
                strContent=@"注册账号";
                break;
            case 1:
                strContent=@"提交资质";
                break;
            case 2:
                strContent=@"开通业务";
                break;
            default:
                break;
        }
        lbOfTitle.text=strContent;
        [view addSubview:lbOfTitle];
        
        
    }
    
    UILabel *lbOfTitle2 = [[UILabel alloc] init];
    lbOfTitle2.frame=CGRectMake(WLsize(13.0),CGRectGetMaxY(view.frame)+WLsize(28.0), WIDTH-WLsize(26.0), WLsize(23.0));
    lbOfTitle2.textColor=UIColorFromRGB(0x101010, 1);
    lbOfTitle2.font=[UIFont systemFontOfSize:WLsize(12.0)];
    lbOfTitle2.text=@"注册后可使用本手机号登录我家餐厅";
    [lbOfTitle2 setAttributedText:[self changeLabelWithTextOfPrice2:lbOfTitle2.text]];

    [self.view addSubview:lbOfTitle2];
    
    
    NSArray *temp1 =[[NSArray alloc] initWithObjects:@"账号",@"密码", @"手机号", @"验证码",  nil];
    NSArray *temp2 =[[NSArray alloc] initWithObjects:@"请输入邮箱",@"请设置6-16位密码", @"请输入手机号", @"请输入验证码",  nil];
    CGFloat hh2=WLsize(50.0);
    UIView *view2 = [[UIView alloc] init];
    view2.frame=CGRectMake(0, CGRectGetMaxY(lbOfTitle2.frame)+WLsize(5.0), WIDTH, hh2*temp1.count);
    view2.backgroundColor=[UIColor whiteColor];
//    view2.layer.masksToBounds=YES;
//    view2.layer.borderWidth=1.0;
//    view2.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [self.view addSubview:view2];
    
    NSMutableArray *tempArray =[[NSMutableArray alloc] init];
    for (int j=0; j<4; j++) {
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
            btnOfSend.layer.borderWidth=1.0/2;
            btnOfSend.layer.borderColor=WLORANGColor.CGColor;
            btnOfSend.layer.cornerRadius=WLsize(5.0);
            [btnOfSend setTitle:@"获取验证码" forState:UIControlStateNormal];
            [btnOfSend setTitleColor:UIColorFromInt(51, 51, 51, 1) forState:UIControlStateNormal];
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
    
   
    
    UIButton *btnOfRegister = [[UIButton alloc] init];
    btnOfRegister.frame = CGRectMake(WLsize(13.0), CGRectGetMaxY(view2.frame)+WLsize(31.0), WIDTH-WLsize(26.0), WLsize(40.0));
    btnOfRegister.layer.masksToBounds=YES;
//    btnOfRegister.layer.borderWidth=1.0;
//    btnOfRegister.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    btnOfRegister.layer.cornerRadius=4.0;
    [btnOfRegister setTitle:@"立即注册" forState:UIControlStateNormal];
    [btnOfRegister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnOfRegister.titleLabel.font=[UIFont systemFontOfSize:WLsize(17.0)];
    btnOfRegister.backgroundColor=WLORANGColor;
    [btnOfRegister addTarget:self action:@selector(clickRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOfRegister];
    
    
}


-(NSMutableAttributedString*)changeLabelWithTextOfPrice2:(NSString*)needText
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    //    UIFont *font = [UIFont systemFontOfSize:14.0];
    //    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,4)];
    //    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(4,1)];
    [attrString addAttribute:NSForegroundColorAttributeName value:UIColorFromInt(102, 102, 102, 1) range:NSMakeRange(0,needText.length-4)];
    
    [attrString addAttribute:NSForegroundColorAttributeName value:UIColorFromInt(254, 168, 1, 1) range:NSMakeRange(needText.length-4,4)];
//    [attrString addAttribute:NSForegroundColorAttributeName value:UIColorFromInt(102, 102, 102, 1) range:NSMakeRange(8,4)];
    
    
    
    
    return attrString;
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
    vc.phone=@"13000000000";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --注册请求
- (void)sendRequestOfRegister
{
    UITextField *textfileld1=[self.arrayOfTextfield objectAtIndex:0];
    UITextField *textfileld2=[self.arrayOfTextfield objectAtIndex:1];
    UITextField *textfileld3=[self.arrayOfTextfield objectAtIndex:2];
    UITextField *textfileld4=[self.arrayOfTextfield objectAtIndex:3];

    NSDictionary *dict = @{@"custId":textfileld1.text,@"blockId":textfileld2.text,@"custId":textfileld3.text,@"blockId":textfileld4.text};
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
