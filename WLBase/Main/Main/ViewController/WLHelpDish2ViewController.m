//
//  WLHelpDish2ViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/22.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLHelpDish2ViewController.h"
#import "WLHelpDish2TableViewCell.h"
#import "WLConformOrderViewController.h"
#import "WLHelpDish2Model.h"
#define KTableviewW WLsize(80.0)
#define KTableviewCellH WLsize(50.0)
#define KBottomviewH WLsize(50.0)
#define KBottomviewBig WLsize(60.0)
#define KTableview2CellH WLsize(108.0)

@interface WLHelpDish2ViewController ()<UITableViewDelegate,UITableViewDataSource>
//左边分类
@property (nonatomic,strong) UITableView *tableview1;
//右边展示
@property (nonatomic,strong) UITableView *tableview2;
@property (nonatomic,strong) NSMutableArray *arrayOfCategory;
@property (nonatomic,strong) NSMutableArray *arrayOfGoods;
@property (nonatomic,strong) NSMutableDictionary *dictOfALLGoods;
//每个secction的高度
@property (nonatomic,strong) NSMutableArray *arrayOfSectionH;

@property (nonatomic,assign) NSInteger currentSelectCategory;

@property (nonatomic,strong) UIView *bottomView;
//选中商品的数组
@property (nonatomic,strong) NSMutableArray *arrayOfSelectGoods;
//是否是点击cell
@property (nonatomic,assign) BOOL isClickCell;

@end

@implementation WLHelpDish2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"帮客点餐";
    self.view.backgroundColor =[UIColor whiteColor];
    self.isClickCell=NO;
    self.arrayOfCategory=[[NSMutableArray alloc] initWithObjects:@"热销",@"折扣",@"其他分类", nil];
    self.arrayOfGoods=[[NSMutableArray alloc] init];
    WLHelpDish2Model *model = [[WLHelpDish2Model alloc] init];
    model.imageUrl=@"";
    model.Sign=@"1";
    model.SignOfRight=@"1";
    model.name=@"新奥尔娘卤肉双拼排挡";
    model.strText=@"虽然不是主打,但是双臂合一";
    model.salesNumber=@"50";
    model.price=@"31.8";
    model.Oldprice=@"40.00";
    model.remainingNmuber=@"5";
    [self.arrayOfGoods addObject:model];
    WLHelpDish2Model *model2 = [[WLHelpDish2Model alloc] init];
    model2.imageUrl=@"";
    model2.Sign=@"2";
    model2.SignOfRight=@"3";
    model2.name=@"新奥尔娘卤肉双拼排挡";
    model2.salesNumber=@"50";
    model2.price=@"31.8";
    model2.remainingNmuber=@"0";
    [self.arrayOfGoods addObject:model2];
    
    WLHelpDish2Model *model3 = [[WLHelpDish2Model alloc] init];
    model3.imageUrl=@"";
    model3.Sign=@"3";
    model3.SignOfRight=@"3";
    model3.name=@"新奥尔娘卤肉双拼排挡";
    model3.salesNumber=@"50";
    model3.price=@"31.8";
    model3.remainingNmuber=@"0";
    [self.arrayOfGoods addObject:model3];
    self.dictOfALLGoods = [[NSMutableDictionary alloc] init];
    for (int i=0; i<self.arrayOfCategory.count; i++) {
        NSString *strKey = [self.arrayOfCategory objectAtIndex:i];
        [self.dictOfALLGoods setObject:self.arrayOfGoods forKey:strKey];
    }
    NSMutableArray *temp2 = [[NSMutableArray alloc] init];
    for (int i=0; i<self.arrayOfCategory.count; i++) {
        NSString *strKey = [self.arrayOfCategory objectAtIndex:i];
        NSArray *temp =[[NSArray alloc] initWithArray:[self.dictOfALLGoods objectForKey:strKey]];
        CGFloat hh= KTableviewCellH+temp.count*KTableview2CellH;
        [temp2 addObject:[NSString stringWithFormat:@"%f",hh]];
    }
    self.arrayOfSectionH=[[NSMutableArray alloc] initWithArray:temp2];
    self.currentSelectCategory=0;
    [self createUI];
    
    
}
#pragma mark --createUI
#pragma mark--- 创建UI
- (void)createUI
{
    if (self.tableview1==nil) {
        self.tableview1=[[UITableView alloc] init];
    }
    self.tableview1.frame=CGRectMake(0, 0, KTableviewW, HEIGHT-XCStatusBar-KBottomviewH);
    self.tableview1.backgroundColor=DEFAULT_BackgroundView_COLOR;
    self.tableview1.userInteractionEnabled=YES;
    self.tableview1.delegate=self;
    self.tableview1.dataSource=self;
    self.tableview1.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview1];
    
    if (self.tableview2==nil) {
        self.tableview2=[[UITableView alloc] init];
    }
    self.tableview2.frame=CGRectMake(CGRectGetMaxX(self.tableview1.frame), 0, WIDTH-CGRectGetMaxX(self.tableview1.frame), HEIGHT-XCStatusBar-KBottomviewH);
    self.tableview2.backgroundColor=[UIColor whiteColor];
    self.tableview2.delegate=self;
    self.tableview2.dataSource=self;
    self.tableview2.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview2];
    [self createBottomVIew];
    
}

#pragma mark --创建底部view
- (void)createBottomVIew
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (NSMutableArray *array in [self.dictOfALLGoods allValues]) {
        for (WLHelpDish2Model *model in array) {
            if ([model.SelectNumber intValue]>0) {
                [temp addObject:model];
            }
        }
    }
    self.arrayOfSelectGoods=[[NSMutableArray alloc] initWithArray:temp];
    NSInteger count =0;
    CGFloat allPrice =0;
    for (WLHelpDish2Model *mode1 in self.arrayOfSelectGoods) {
        count=count+[mode1.SelectNumber intValue];
        allPrice=allPrice+[mode1.price floatValue];
    }
    if (self.bottomView==nil) {
        self.bottomView=[[UIView alloc] init];
    }
    self.bottomView.frame=CGRectMake(0, HEIGHT-KBottomviewBig-XCStatusBar, WIDTH, KBottomviewBig);
    [self.view addSubview:self.bottomView];
    UIView *viewOfContent = [[UIView alloc] init];
    viewOfContent.frame=CGRectMake(0, WLsize(10), self.bottomView.frame.size.width, WLsize(50));
    viewOfContent.backgroundColor=UIColorFromInt(59, 59, 61, 1);
    [self.bottomView addSubview:viewOfContent];
    
    UIButton *btnOfCar = [[UIButton alloc] init];
    btnOfCar.frame=CGRectMake(WLsize(10), 0, WLsize(50), WLsize(50));
    [btnOfCar setImage:[UIImage imageNamed:@"bowl_click_icon"] forState:UIControlStateNormal];
    [btnOfCar addTarget:self action:@selector(createCar:) forControlEvents:UIControlEventTouchUpInside];
    [btnOfCar setNew2Badge:[NSString stringWithFormat:@"%ld",count]];
    [self.bottomView addSubview:btnOfCar];
    
    UILabel *lbOfPrice = [[UILabel alloc] init];
    lbOfPrice.font=[UIFont systemFontOfSize:WLsize(25)];
    lbOfPrice.textColor=UIColorFromInt(240, 240, 240, 1);
    lbOfPrice.text=[NSString stringWithFormat:@"¥%.2f",allPrice];
    CGSize size = XCsizeWithFont(lbOfPrice.text, [UIFont systemFontOfSize:WLsize(25)]);
    lbOfPrice.frame=CGRectMake(WLsize(70), WLsize(6),size.width, WLsize(23));
    [viewOfContent addSubview:lbOfPrice];
    
    UILabel *lbOfCoupon = [[UILabel alloc] init];
    lbOfCoupon.font=[UIFont systemFontOfSize:WLsize(10)];
    lbOfCoupon.textColor=UIColorFromInt(227, 87, 100, 1);
    lbOfCoupon.text=[NSString stringWithFormat:@"优惠¥%@",@"20.00"];
    CGSize size1 = XCsizeWithFont(lbOfCoupon.text, [UIFont systemFontOfSize:WLsize(11)]);
    lbOfCoupon.frame=CGRectMake(CGRectGetMaxX(lbOfPrice.frame)+WLsize(5), WLsize(16),size1.width, WLsize(13));
    [viewOfContent addSubview:lbOfCoupon];
    
    UILabel *lbOfNumber = [[UILabel alloc] init];
    lbOfNumber.font=[UIFont systemFontOfSize:WLsize(10)];
    lbOfNumber.textColor=UIColorFromInt(240, 240, 240, 1);
    lbOfNumber.text=[NSString stringWithFormat:@"已经点了%ld道菜品",self.arrayOfSelectGoods.count];
    lbOfNumber.frame=CGRectMake(lbOfPrice.frame.origin.x, CGRectGetMaxY(lbOfPrice.frame)+WLsize(4),WLsize(150), WLsize(13));
    [viewOfContent addSubview:lbOfNumber];
    
    UIButton *btnToPay = [[UIButton alloc] init];
    btnToPay.frame=CGRectMake(viewOfContent.frame.size.width-WLsize(106.0), 0, WLsize(106.0), viewOfContent.frame.size.height);
    btnToPay.backgroundColor =WLORANGColor;
    [btnToPay setTitle:@"去结算" forState:UIControlStateNormal];
    [btnToPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnToPay.titleLabel.font = [UIFont systemFontOfSize:WLsize(17.0)];
    [btnToPay addTarget:self action:@selector(clickToPay:) forControlEvents:UIControlEventTouchUpInside];
    [viewOfContent addSubview:btnToPay];
}

#pragma mark --去结算
- (void)clickToPay:(UIButton *)buuton
{
    WLConformOrderViewController *vc = [[WLConformOrderViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count=0;
    if (self.tableview1==tableView) {
        count=1;
    }
    else if (tableView==self.tableview2)
    {
        count=self.arrayOfCategory.count;
    }
    return count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count=0;
    if (self.tableview1==tableView) {
        count=self.arrayOfCategory.count;
    }
    else if (tableView==self.tableview2)
    {
        NSString *strKey = [self.arrayOfCategory objectAtIndex:section];
        NSArray *temp =[[NSArray alloc] initWithArray:[self.dictOfALLGoods objectForKey:strKey]];
        count=temp.count;
    }
    return count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigth=0;
    if (self.tableview1==tableView) {
        heigth=KTableviewCellH;
    }
    else if (tableView==self.tableview2)
    {
        heigth=KTableview2CellH;
    }
    return heigth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height=0;
    if (tableView==self.tableview2) {
        height=KTableviewCellH;
    }
    return height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView=nil;
    if (tableView==self.tableview2) {
        headView= [[UIView alloc] init];
        headView.frame=CGRectMake(0, 0, self.tableview2.frame.size.width, KTableviewCellH);
        headView.backgroundColor=[UIColor whiteColor];
        UILabel *lbOfTitle = [[UILabel alloc] init];
        lbOfTitle.frame=CGRectMake(WLsize(10),(headView.frame.size.height-WLsize(33.0))/2.0, self.tableview2.frame.size.width-WLsize(20.0), WLsize(33.0));
        lbOfTitle.textColor=UIColorFromInt(102, 102, 102, 1);
        lbOfTitle.font=[UIFont systemFontOfSize:WLsize(12.0)];
        lbOfTitle.text=[self.arrayOfCategory objectAtIndex:section];
        [headView addSubview:lbOfTitle];
        UILabel *lbOfSep = [[UILabel alloc] init];
        lbOfSep.frame=CGRectMake(0, headView.frame.size.height-1.0/2,headView.frame.size.width, 1.0/2);
        lbOfSep.backgroundColor=WLSEPLBColor;
        [headView addSubview:lbOfSep];
    }
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    if (tableView==self.tableview1) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell1:cell AtIndexPath:indexPath];
    }
    else{
        WLHelpDish2TableViewCell *cell = [WLHelpDish2TableViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.currentIndex=indexPath;
        cell.model = [self.arrayOfGoods objectAtIndex:indexPath.row];
        __weak typeof(self)weakSelf = self;
        cell.clickAddOrMin = ^(NSIndexPath *index, NSString *number) {
            [weakSelf.tableview2 reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
            [weakSelf createBottomVIew];
        };
        return cell;
    }
    return cell;
}
#pragma mark --创建cell
- (void)createCell1:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor=DEFAULT_BackgroundView_COLOR;
    UILabel *lbOfText = [[UILabel alloc] init];
    lbOfText.frame=CGRectMake(0,0, KTableviewW,KTableviewCellH);
    lbOfText.font=[UIFont systemFontOfSize:WLsize(14.0)];
    lbOfText.textColor=UIColorFromInt(102, 102, 102, 1);
    lbOfText.textAlignment=NSTextAlignmentCenter;
    lbOfText.text=[self.arrayOfCategory objectAtIndex:indexPath.row];
    [cell.contentView addSubview:lbOfText];
    UILabel *lbSelect = [[UILabel alloc] init];
    lbSelect.frame=CGRectMake(0,0, WLsize(2),KTableviewCellH);
    lbSelect.backgroundColor=WLORANGColor;
    lbSelect.hidden=YES;
    [cell.contentView addSubview:lbSelect];
    if (indexPath.row==self.currentSelectCategory) {
        lbOfText.textColor=UIColorFromInt(48, 48, 48, 1);
        lbSelect.hidden=NO;
        cell.contentView.backgroundColor=[UIColor whiteColor];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableview1) {
        self.currentSelectCategory=indexPath.row;
        self.isClickCell=YES;
        [self.tableview1 reloadData];
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        [self.tableview2 scrollToRowAtIndexPath:indexPath2 atScrollPosition:UITableViewScrollPositionTop animated:YES];
        // reloadDate会在主队列执行，而dispatch_get_main_queue会等待机会，直到主队列空闲才执行。
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新完成
            [self performSelector:@selector(dely) withObject:nil afterDelay:1];
        });
    

    }
}
#pragma mark--延时操作
- (void)dely
{
    self.isClickCell=NO;

}
//scroller的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (scrollView ==self.tableview2) {
        if (self.isClickCell) {
            return;
        }
        NSInteger sectionNumber =0;
        CGFloat sectionH = 0;
        for (int i=0; i<self.arrayOfSectionH.count; i++) {
            CGFloat sectionH1 =[[self.arrayOfSectionH objectAtIndex:i] floatValue];
            sectionH=sectionH+sectionH1;
            if (yOffset>=sectionH) {
                sectionNumber++;
            }
            else{
                break;
            }
        }
        if (sectionNumber!=self.currentSelectCategory) {
//            NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:sectionNumber inSection:0];
            self.currentSelectCategory=sectionNumber;
            [self.tableview1 reloadData];
            
        }
      
        
    }
}

#pragma mark --点击购物车按钮
- (void)createCar:(UIButton *)button
{
    NSLog(@"createCar");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
