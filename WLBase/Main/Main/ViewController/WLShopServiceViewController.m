//
//  WLShopServiceViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/21.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLShopServiceViewController.h"
#import "WLHelpDishesViewController.h"
@interface WLShopServiceViewController ()
@property (nonatomic,strong) NSMutableArray *arrayOfText;
@property (nonatomic,strong) NSMutableArray *arrayOfImage;

@end

@implementation WLShopServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"店内服务";
    self.arrayOfText=[[NSMutableArray alloc] initWithObjects:@"帮客点餐",@"餐桌管理点餐",@"买单收款",@"排队",@"预约", nil];
    self.arrayOfImage=[[NSMutableArray alloc] initWithObjects:@"Stafforde_icon",@"tablemanagement_icon",@"pay_icon",@"line_up_icon",@"make_icon", nil];

    [self createUI];
    [self createRight];
}
#pragma mark --创建UI
- (void)createUI{
    self.view.backgroundColor=DEFAULT_BackgroundView_COLOR;
    CGFloat ww=WLsize(150.0);
    CGFloat hh =WLsize(150);
    CGFloat seph= WLsize(19);
    CGFloat seph2= WLsize(37);
    for (int i=0; i<self.arrayOfText.count; i++) {
        NSInteger row =i/2;
        NSInteger colum = i%2;
        UIView *view = [[UIView alloc] init];
        view.frame=CGRectMake(seph+(ww+seph2)*colum, WLsize(40.0)+(hh+WLsize(20))*row, ww, hh);
        view.layer.masksToBounds=YES;
        view.backgroundColor=[UIColor whiteColor];
//        view.layer.borderWidth=1.0;
        view.layer.cornerRadius=WLsize(5);
//        view.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
        [self.view addSubview:view];
        view.userInteractionEnabled=YES;
        view.tag=i+1;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
        [view addGestureRecognizer:ges];
        
        
        UIImageView *imageview =[[UIImageView alloc] init];
        imageview.frame=CGRectMake((view.frame.size.width-WLsize(40.0))/2.0, WLsize(40.0), WLsize(40.0), WLsize(40.0));
            imageview.image =[UIImage imageNamed:[self.arrayOfImage objectAtIndex:i]];
        [view addSubview:imageview];
        
        UILabel *lb1 = [[UILabel alloc] init];
        lb1.frame=CGRectMake(0, CGRectGetMaxY(imageview.frame)+WLsize(13.0), view.frame.size.width, WLsize(20.0));
        lb1.textColor=WLTEXTCOLOR;
        lb1.font=[UIFont systemFontOfSize:WLsize(14.0)];
        lb1.textAlignment=NSTextAlignmentCenter;
        lb1.text=[self.arrayOfText objectAtIndex:i];
        [view addSubview:lb1];
    
    }
    
}
#pragma mark--创建右侧按钮
-(void)createRight
{
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame=CGRectMake(0, 0, 40, 40);
    //    [right setTitle:@"right" forState:UIControlStateNormal];
    [right setImage:[UIImage imageNamed:@"order_notice_icon"] forState:UIControlStateNormal];
    [right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    [right setNewBadge:@"5"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
}


#pragma mark --- 方法
- (void)clickRight
{
  
}

#pragma mark --点击各个模块
- (void)clickView:(UIGestureRecognizer *)ges
{
    NSInteger tag = [ges view].tag;
    if (tag==1) {
        //员工帮点
        WLHelpDishesViewController *vc = [[WLHelpDishesViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (tag==2)
    {
        //餐桌管理
        
    }
    else if (tag==3)
    {
        //买单收款
        
    }
    
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
