//
//  WLProblemViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/22.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLProblemViewController.h"
#import "WLProbLem2ViewController.h"
#define KCellHeight3 120.0/375*WIDTH

@interface WLProblemViewController ()<UITextFieldDelegate>

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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.isNeedWhite = YES;

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];

}
#pragma mark --创建UI
-(void)createUI{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, 0, WIDTH, WLsize(170));
    [self.view addSubview:view];
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.frame=CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    imageview.image =[UIImage imageNamed:@"problem_top_bg"];
    [view addSubview:imageview];
    
    [self createTitle];
    [self createLeft];
    [self createBall];
    NSArray *temp1 =[[NSArray alloc] initWithObjects:@"商家账号",  nil];
    NSArray *temp2 =[[NSArray alloc] initWithObjects:@"请输入账号",  nil];
    CGFloat hh2=WLsize(50.0);
    UIView *view2 = [[UIView alloc] init];
    view2.frame=CGRectMake(0, CGRectGetMaxY(view.frame), WIDTH, hh2*temp1.count);
    view2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view2];
    
    NSMutableArray *tempArray =[[NSMutableArray alloc] init];
    for (int j=0; j<temp1.count; j++) {
        UIView *view3 = [[UIView alloc] init];
        view3.frame=CGRectMake(0,hh2*j, WIDTH, hh2);
        view3.backgroundColor=[UIColor whiteColor];
        [view2 addSubview:view3];
        
        UILabel *lbPhone = [[UILabel alloc] init];
        lbPhone.frame=CGRectMake(WLsize(15.0), (view3.frame.size.height-WLsize(36.0))/2.0, WLsize(70.0), WLsize(36.0));
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
    btnOfRegister.frame = CGRectMake(WLsize(15.0), CGRectGetMaxY(view2.frame)+WLsize(25.0), WIDTH-WLsize(30.0), WLsize(40.0));
    btnOfRegister.layer.masksToBounds=YES;
    //    btnOfRegister.layer.borderWidth=1.0;
    //    btnOfRegister.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    btnOfRegister.layer.cornerRadius=4.0;
    [btnOfRegister setTitle:@"下一步" forState:UIControlStateNormal];
    [btnOfRegister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnOfRegister.titleLabel.font=[UIFont systemFontOfSize:WLsize(17.0)];
    btnOfRegister.backgroundColor=WLORANGColor;
    [btnOfRegister addTarget:self action:@selector(clickNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOfRegister];
}
#pragma mark --创建顺序栏
-(void)createBall
{
    UIColor *normalBackgroundColor=UIColorFromInt(255, 255, 255, 0.5);
    UIColor *selectBackgroundColor=[UIColor whiteColor];
    UIColor *selectBigBackgroundColor=UIColorFromInt(255, 255, 255, 0.5);
    UIColor *normalTextColor=[UIColor whiteColor];
    UIColor *selectTextColor=WLORANGColor;
    UIColor *normalTextTitleColor=UIColorFromInt(255, 255, 255, 0.5);
    UIColor *selectTextTitleColor=[UIColor whiteColor];
    NSInteger select=0;
    NSArray *arrayOfTitle = [[NSArray alloc] initWithObjects:@"输入账号",@"验证手机号",@"重设密码", nil];
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, WLsize(50.0), WIDTH, KCellHeight3);
    [self.view addSubview:view];
    CGFloat rw=29.0/375*WIDTH;
    CGFloat ballD=WLsize(26.0);
    CGFloat linew=(WIDTH-ballD*3-rw*2)/2.0;
    CGFloat rh=WLsize(35.0);
    CGFloat lbW = WLsize(100.0);
    for (int i=0; i<3; i++) {
        UILabel *viewOfBall = [[UILabel alloc] init];
        viewOfBall.frame=CGRectMake(rw+(ballD+linew)*i,rh,ballD, ballD);
        viewOfBall.layer.masksToBounds=YES;
        viewOfBall.layer.cornerRadius=ballD/2.0;
        
        if (i==select) {
            viewOfBall.backgroundColor=selectBackgroundColor;
        }else{
            viewOfBall.backgroundColor=normalBackgroundColor;
            
        }
        viewOfBall.textAlignment=NSTextAlignmentCenter;
        viewOfBall.font=[UIFont systemFontOfSize:WLsize(18.0)];
        viewOfBall.text=[NSString stringWithFormat:@"%d",i+1];
        if (i==select) {
            viewOfBall.textColor=selectTextColor;
        }
        else{
            viewOfBall.textColor=normalTextColor;

        }
        if (i<2) {
            UILabel *lbOfLine = [[UILabel alloc] init];
            lbOfLine.frame=CGRectMake(CGRectGetMaxX(viewOfBall.frame), viewOfBall.frame.origin.y+ballD/2.0-4.0/2,linew, 4.0);
            if (i==select) {
                lbOfLine.frame=CGRectMake(CGRectGetMaxX(viewOfBall.frame)+WLsize(5), viewOfBall.frame.origin.y+ballD/2.0-4.0/2,linew-WLsize(5.0), 4.0);

            }
            lbOfLine.backgroundColor=normalBackgroundColor;
            [view addSubview:lbOfLine];
        }
        
        UILabel *viewOfBall2 = [[UILabel alloc] init];
        viewOfBall2.frame=CGRectMake(rw+(ballD+linew)*i-WLsize(5.0),rh-WLsize(5.0),ballD+WLsize(10.0), ballD+WLsize(10.0));
        viewOfBall2.layer.masksToBounds=YES;
        viewOfBall2.layer.cornerRadius=viewOfBall2.frame.size.width/2.0;
        viewOfBall2.backgroundColor=selectBigBackgroundColor;
        if (i==select) {
            viewOfBall2.hidden=NO;
            [view addSubview:viewOfBall2];
            
            
        }else{
            viewOfBall2.hidden=YES;
            
        }
        [view addSubview:viewOfBall];
        
        UILabel *lbOfTitle = [[UILabel alloc] init];
        lbOfTitle.frame=CGRectMake(viewOfBall.center.x-lbW/2.0, CGRectGetMaxY(viewOfBall.frame)+WLsize(9.0), lbW, WLsize(23.0));
        lbOfTitle.textAlignment=NSTextAlignmentCenter;
        if (i==select) {
            lbOfTitle.textColor=selectTextTitleColor;
        }
        else{
            lbOfTitle.textColor= normalTextTitleColor;
        }
        lbOfTitle.font=[UIFont systemFontOfSize:WLsize(15.0)];
        NSString *strContent=[arrayOfTitle objectAtIndex:i];
        lbOfTitle.text=strContent;
        [view addSubview:lbOfTitle];
        
    }
}
#pragma mark --创建标题栏
-(void)createTitle
{
    UILabel *lbOfTitle = [[UILabel alloc] init];
    lbOfTitle.frame=CGRectMake((WIDTH-WLsize(100))/2.0, WLsize(30), WLsize(100), WLsize(23));
    lbOfTitle.text=@"忘记密码";
    lbOfTitle.textColor=[UIColor whiteColor];
    lbOfTitle.font=[UIFont systemFontOfSize:WLsize(17)];
    [self.view addSubview:lbOfTitle];
}

#pragma mark --创建返回按钮
 -(void)createLeft
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"Backicon"] forState:UIControlStateNormal];
    button.frame=CGRectMake(WLsize(6.0), WLsize(30.0), WLsize(20), WLsize(20));
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark --点击返回
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --点击下一步
- (void)clickNext
{
    WLProbLem2ViewController *vc =[[WLProbLem2ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
