//
//  WLReceiptViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/21.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLReceiptViewController.h"
#import "WLCodeListViewController.h"
@interface WLReceiptViewController ()
@property (nonatomic,strong) UILabel *lbOfGoToHome;
@property (nonatomic,strong) UIImageView *imageviewOfCode;
@end

@implementation WLReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"支付二维码";
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark --创建UI
-(void)createUI{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(WLsize(10.0), WLsize(10.0), WIDTH-WLsize(20.0), WLsize(438.0));
    view.layer.masksToBounds=YES;
    view.layer.borderWidth=1.0;
    view.layer.cornerRadius=10.0;
    view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [self.view addSubview:view];
    UILabel *lb1 = [[UILabel alloc] init];
    lb1.frame=CGRectMake(0, WLsize(65.0), view.frame.size.width, WLsize(25.0));
    lb1.textColor=WLTEXTCOLOR;
    lb1.font=[UIFont systemFontOfSize:WLsize(17.0)];
    lb1.textAlignment=NSTextAlignmentCenter;
    lb1.text=@"微信扫一扫，向我付钱";
    [view addSubview:lb1];
    UIImageView *imageview =[[UIImageView alloc] init];
    imageview.frame=CGRectMake((view.frame.size.width-WLsize(150.0))/2.0, CGRectGetMaxY(lb1.frame)+WLsize(54.0), WLsize(150.0), WLsize(150.0));
//    imageview.image =[UIImage imageNamed:@""];
    imageview.layer.masksToBounds=YES;
    imageview.layer.cornerRadius=30.0;
    [imageview sd_setImageWithURL:[NSURL URLWithString:@"https://qr.api.cli.im/qr?data=%25E6%25B5%258B%25E8%25AF%2595&level=H&transparent=false&bgcolor=%23ffffff&forecolor=%23000000&blockpixel=12&marginblock=1&logourl=&size=280&kid=cliim&key=268f3bbe7363b1da9057fef12bf5df76"]];
    imageview.backgroundColor=[UIColor grayColor];
    
    self.imageviewOfCode=imageview;
    [view addSubview:imageview];
    UILabel *lb2 = [[UILabel alloc] init];
    lb2.frame=CGRectMake(WLsize(89.0), CGRectGetMaxY(imageview.frame)+WLsize(53.0), WLsize(60.0), WLsize(25.0));
    lb2.textColor=WLTEXTCOLOR;
    lb2.font=[UIFont systemFontOfSize:WLsize(14.0)];
    lb2.textAlignment=NSTextAlignmentCenter;
    lb2.text=@"设置金额";
    lb2.userInteractionEnabled=YES;
    UITapGestureRecognizer *ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSetMoney:)];
    [lb2 addGestureRecognizer:ges1];
    [view addSubview:lb2];
    UILabel *sep = [[UILabel alloc] init];
    sep.frame=CGRectMake(CGRectGetMaxX(lb2.frame)+WLsize(25.0),lb2.frame.origin.y, 1.0, lb2.frame.size.height);
    sep.backgroundColor=UIColorFromRGB(0xBBBBBB, 1);
    [view addSubview:sep];
    
    UILabel *lb3 = [[UILabel alloc] init];
    lb3.frame=CGRectMake(CGRectGetMaxX(lb2.frame)+WLsize(51.0), CGRectGetMaxY(imageview.frame)+WLsize(53.0), WLsize(75.0), WLsize(25.0));
    lb3.textColor=WLTEXTCOLOR;
    lb3.font=[UIFont systemFontOfSize:WLsize(14.0)];
    lb3.textAlignment=NSTextAlignmentCenter;
    lb3.text=@"保存收款码";
    lb3.userInteractionEnabled=YES;
    UITapGestureRecognizer *ges2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSaveCode:)];
    [lb3 addGestureRecognizer:ges2];
    [view addSubview:lb3];
    
    
    UILabel *lb4 = [[UILabel alloc] init];
    lb4.frame=CGRectMake(WLsize(23.0), CGRectGetMaxY(view.frame)+WLsize(15.0), WLsize(103.0), WLsize(25.0));
    lb4.textColor=WLTEXTCOLOR;
    lb4.font=[UIFont systemFontOfSize:WLsize(14.0)];
    lb4.textAlignment=NSTextAlignmentCenter;
    lb4.text=@"查看全部二维码";
    lb4.userInteractionEnabled=YES;
    UITapGestureRecognizer *ges3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookAllCode:)];
    [lb4 addGestureRecognizer:ges3];
    [self.view addSubview:lb4];
    
    [self createBallOfGoToHome];
    
}
#pragma mark --创建回到首页的圆球
- (void)createBallOfGoToHome
{
    self.lbOfGoToHome=[[UILabel alloc] init];
    self.lbOfGoToHome.frame=CGRectMake(WIDTH-WLsize(10.0)-WLsize(40.0), HEIGHT-XCStatusBar-WLsize(50.0)-WLsize(40), WLsize(40), WLsize(40));
    self.lbOfGoToHome.layer.masksToBounds=YES;
    self.lbOfGoToHome.layer.borderWidth=1;
    self.lbOfGoToHome.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    self.lbOfGoToHome.layer.cornerRadius=self.lbOfGoToHome.frame.size.height/2.0;
    self.lbOfGoToHome.text=@"首页";
    self.lbOfGoToHome.textAlignment=NSTextAlignmentCenter;
    self.lbOfGoToHome.textColor=UIColorFromRGB(0x1010101, 1);
    self.lbOfGoToHome.font=[UIFont systemFontOfSize:WLsize(12.0)];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGoToHome)];
    self.lbOfGoToHome.userInteractionEnabled=YES;
    [self.lbOfGoToHome addGestureRecognizer:ges];
    [self.view addSubview:self.lbOfGoToHome];
    
}
#pragma mark --点击回到首页
-(void)clickGoToHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark --设置金额
- (void)clickSetMoney:(UIGestureRecognizer *)ges
{
    
}
#pragma mark --保存收款码
- (void)clickSaveCode:(UIGestureRecognizer *)ges
{
    [self loadImageFinished:self.imageviewOfCode.image];
}

- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    [MBProgressHUD showWithMessage:@"保存成功!"];
}


#pragma mark --查看全部二维码
- (void)lookAllCode:(UIGestureRecognizer *)ges
{
    WLCodeListViewController *vc =[[WLCodeListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
