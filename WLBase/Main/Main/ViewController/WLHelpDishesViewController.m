//
//  WLHelpDishesViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/22.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLHelpDishesViewController.h"
#import "WLHelpDish2ViewController.h"
#define KCell1SepH WLsize(64.0)
#define KCell1RowH WLsize(40.0)
#define KCell1RowSepH WLsize(12.0)

@interface WLHelpDishesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *arrayOfPeople;
@property (nonatomic,strong) NSMutableArray *arrayOfLocated;
@property (nonatomic,strong) NSMutableArray *arrayOfLocatedName;

@property (nonatomic,copy) NSString *selectOfPeople;
@property (nonatomic,copy) NSString *selectLocated;
@property (nonatomic,copy) NSString *selectLocatedName;

@end

@implementation WLHelpDishesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"员工帮点";
    self.selectOfPeople=@"";
    self.selectLocated=@"";
    self.arrayOfPeople=[[NSMutableArray alloc] initWithObjects:@"1", @"2",@"3",@"4",@"5",@"6", @"7",@"8",@"9",@"10",@"11", @"12",@"13",@"14",@"15",@"16", @"17",@"18",@"19",@"20",nil];
    self.arrayOfLocatedName=[[NSMutableArray alloc] initWithObjects:@"餐桌位置", @"大厅",@"包厢",nil];

    self.arrayOfLocated=[[NSMutableArray alloc] initWithObjects:@"A01", @"A02",@"A03",@"A04",@"A05",@"A06", @"A07",@"A08",@"A09",@"A10",nil];

    [self createUI];
    
    
}
#pragma mark --createUI
#pragma mark--- 创建UI
- (void)createUI
{
    if (self.tableview==nil) {
        self.tableview=[[UITableView alloc] init];
    }
    self.tableview.frame=CGRectMake(0, 0, WIDTH, HEIGHT-XCStatusBar);
    self.tableview.backgroundColor=[UIColor whiteColor];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    [self createBallOfGoToHome];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigth=WLsize(100);
    if (indexPath.row==0) {
        //用餐人数64
        NSInteger row=(self.arrayOfPeople.count/5+(self.arrayOfPeople.count%5>0?1:0));
        
        heigth= row*(KCell1RowH+KCell1RowSepH)+KCell1SepH;
    }
    else if (indexPath.row==1)
    {
        NSInteger row=(self.arrayOfPeople.count/5+(self.arrayOfPeople.count%5>0?1:0));
        heigth= row*(KCell1RowH+KCell1RowSepH)+KCell1SepH;
    }
    else{
        heigth= WLsize(140.0);

    }
 
    
    return heigth;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    if (indexPath.row==0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell1:cell AtIndexPath:indexPath];
    }
    else if (indexPath.row==1)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell2:cell AtIndexPath:indexPath];
    }
    else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell3:cell AtIndexPath:indexPath];
    }
  
    return cell;
}
#pragma mark --创建cell
- (void)createCell1:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *lbOfTitle =[[UILabel alloc] init];
    lbOfTitle.frame=CGRectMake(WLsize(15.0), WLsize(18.0), WLsize(70.0), WLsize(21.0));
    lbOfTitle.textColor=WLTEXTCOLOR;
    lbOfTitle.font=[UIFont systemFontOfSize:WLsize(15.0)];
    lbOfTitle.text=@"用餐人数";
    [cell.contentView addSubview:lbOfTitle];
    
    NSInteger row=(self.arrayOfPeople.count/5+(self.arrayOfPeople.count%5>0?1:0));
    
   CGFloat heigth= row*(KCell1RowH+KCell1RowSepH)+KCell1SepH;
    UIView *viewOfContent = [[UIView alloc] init];
    viewOfContent.frame=CGRectMake(WLsize(25), KCell1SepH, WIDTH-WLsize(50), heigth-KCell1SepH);
    [cell.contentView addSubview:viewOfContent];
    
    CGFloat ww =WLsize(42.0);
    CGFloat hh=WLsize(40.0);
    CGFloat seph=KCell1RowSepH;
    CGFloat sepw=(viewOfContent.frame.size.width-ww*5)/4.0;
    for (int i=0; i<self.arrayOfPeople.count; i++) {
        int  row1=i/5;
        int colum1 = i%5;
        UILabel *lb1 = [[UILabel alloc] init];
        lb1.frame=CGRectMake((ww+sepw)*colum1, (hh+seph)*row1, ww, hh);
        lb1.font=[UIFont systemFontOfSize:WLsize(14.0)];
        lb1.textAlignment=NSTextAlignmentCenter;
        lb1.text=[self.arrayOfPeople objectAtIndex:i];
        lb1.layer.masksToBounds=YES;
        lb1.layer.cornerRadius=WLsize(5);
        if ([lb1.text isEqualToString:self.selectOfPeople]) {
            lb1.backgroundColor=WLORANGColor;
            lb1.textColor=[UIColor whiteColor];

        }
        else{
            lb1.textColor=WLTEXTCOLOR;
            lb1.backgroundColor=[UIColor whiteColor];
        }
        [viewOfContent addSubview:lb1];
        lb1.userInteractionEnabled=YES;
        UITapGestureRecognizer *ges =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPeopleNumber:)];
        [lb1 addGestureRecognizer:ges];
    }
    UILabel *sepLb =[[UILabel alloc] init];
    sepLb.frame=CGRectMake(WLsize(15), heigth-1.0/2, WIDTH-WLsize(30), 1.0/2);
    sepLb.backgroundColor=WLSEPLBColor;
    [cell.contentView addSubview:sepLb];
}
- (void)createCell2:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=(self.arrayOfPeople.count/5+(self.arrayOfPeople.count%5>0?1:0));
    CGFloat  heigth= row*(KCell1RowH+KCell1RowSepH)+KCell1SepH;
    
    UIView *view1 = [[UIView alloc] init];
    view1.frame=CGRectMake(0,WLsize(10.0), WIDTH-WLsize(20.0), KCell1RowH);
    [cell.contentView addSubview:view1];
    UILabel *lbOfTilte = [[UILabel alloc] init];
    lbOfTilte.frame=CGRectMake(WLsize(15), 0, WLsize(80), view1.frame.size.height);
    lbOfTilte.text=@"餐桌位置";
    lbOfTilte.font=[UIFont systemFontOfSize:WLsize(14)];
    lbOfTilte.textColor=WLTEXTCOLOR;
    [view1 addSubview:lbOfTilte];
    
    CGFloat btnw =WLsize(50);
    CGFloat btnSep =(WIDTH-CGRectGetMaxX(lbOfTilte.frame)-WLsize(15))/self.arrayOfLocatedName.count;

    for (int i=0; i<self.arrayOfLocatedName.count; i++) {
        UIButton *btn1 = [[UIButton alloc] init];
        btn1.frame=CGRectMake((btnw +btnSep)*i, 0, btnw, view1.frame.size.height);
        btn1.layer.masksToBounds=YES;
        btn1.layer.cornerRadius=WLsize(5.0);
//        btn1.layer.borderWidth=1.0;
        btn1.tag=i+1;
//        btn1.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
        [btn1 setTitle:[self.arrayOfLocatedName objectAtIndex:i] forState:UIControlStateNormal];
        [btn1 setTitleColor:WLTEXTCOLOR forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(clickLocated:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.selectLocatedName isEqualToString:[self.arrayOfLocatedName objectAtIndex:i]]) {
            [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn1.backgroundColor=WLORANGColor;
        }
        else{
            [btn1 setTitleColor:WLTEXTCOLOR forState:UIControlStateNormal];
            btn1.backgroundColor=[UIColor whiteColor];
        }
        [view1 addSubview:btn1];
        
    }
    
//    CGFloat ww =WLsize(30.0);
//    CGFloat hh=WLsize(23.0);
//    CGFloat seph=WLsize(28.0);
//    NSInteger row=(self.arrayOfPeople.count/6+(self.arrayOfPeople.count%6>0?1:0));
//    CGFloat viewH= row*hh+(row)*seph;
//    NSInteger row=(self.arrayOfPeople.count/5+(self.arrayOfPeople.count%5>0?1:0));
//    heigth2= row*(KCell1RowH+KCell1RowSepH)+KCell1SepH;
    UIView *view = [[UIView alloc] init];
    view.frame =CGRectMake(WLsize(27.0), CGRectGetMaxY(view1.frame)+WLsize(10.0), WIDTH-WLsize(54.0), heigth-KCell1SepH);
    [cell.contentView addSubview:view];
        CGFloat ww =WLsize(50.0);
        CGFloat hh=KCell1RowH;
        CGFloat sepw = (view.frame.size.width-ww*5)/4.0;
        CGFloat seph=(view.frame.size.height-hh*(self.arrayOfLocated.count))/self.arrayOfLocated.count;
    for (int i=0; i<self.arrayOfLocated.count; i++) {
        int  row1=i/5;
        int colum1 = i%5;
        UILabel *lb1 = [[UILabel alloc] init];
        lb1.frame=CGRectMake((ww+sepw)*colum1, (hh+seph)*row1, ww, hh);
        lb1.textColor=WLTEXTCOLOR;
        lb1.font=[UIFont systemFontOfSize:WLsize(14.0)];
        lb1.textAlignment=NSTextAlignmentCenter;
        lb1.text=[self.arrayOfLocated objectAtIndex:i];
        if ([lb1.text isEqualToString:self.selectLocated]) {
            lb1.backgroundColor=UIColorFromRGB(0xBBBBBB, 1);
        }
        else{
            lb1.backgroundColor=[UIColor clearColor];
            
        }
        [view addSubview:lb1];
        lb1.userInteractionEnabled=YES;
        UITapGestureRecognizer *ges2 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPeopleLocated:)];
        [lb1 addGestureRecognizer:ges2];
    }
    UILabel *sepLb =[[UILabel alloc] init];
    sepLb.frame=CGRectMake(0, CGRectGetMaxY(view.frame)-1, WIDTH, 1);
    sepLb.backgroundColor=UIColorFromRGB(0xBBBBBB, 1);
    [cell.contentView addSubview:sepLb];
    
}

- (void)createCell3:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.frame=CGRectMake((WIDTH-WLsize(80.0))/2.0, WLsize(55.0), WLsize(80.0), WLsize(30.0));
    btn1.layer.masksToBounds=YES;
    btn1.layer.cornerRadius=WLsize(4.0);
    btn1.layer.borderWidth=1.0;
    btn1.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    [btn1 setTitle:@"去点菜" forState:UIControlStateNormal];
    [btn1 setTitleColor:WLTEXTCOLOR forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickGoTodish:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btn1];
}



#pragma mark --点击用餐人数
- (void)clickPeopleNumber:(UIGestureRecognizer *)ges
{
    UILabel *lb = (UILabel *)[ges view];
    NSString *strContent =lb.text;
    self.selectOfPeople=strContent;
    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark --点击用餐位置大厅包厢
- (void)clickPeopleLocated:(UIGestureRecognizer *)ges
{
    UILabel *lb = (UILabel *)[ges view];
    NSString *strContent =lb.text;
    self.selectLocated=strContent;
    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark --点击
- (void)clickLocated:(UIButton *)button
{
    NSInteger tag = button.tag;
    self.selectLocatedName=button.titleLabel.text;
    self.selectLocated=@"";
    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    
    NSLog(@"%ld",tag);
}

#pragma mark --去点菜
- (void)clickGoTodish:(UIButton *)button
{
    NSLog(@"clickGoTodish");
    WLHelpDish2ViewController *vc = [[WLHelpDish2ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
