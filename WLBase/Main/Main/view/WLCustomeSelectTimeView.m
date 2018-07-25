//
//  WLCustomeSelectTimeView.m
//  WLBase
//
//  Created by 雷王 on 2018/7/24.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLCustomeSelectTimeView.h"
#define KTableviewW WLsize(345.0)
#define KCellHeight WLsize(160.0)
#define KCellHeight2 WLsize(155.0)
#define KCellHeight3 WLsize(190.0)
#define KCellHeight4 WLsize(65.0)
#define KCellBtnW WLsize(50)
#define KCellBtnH WLsize(20)

@implementation WLCustomeSelectTimeView
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
    
}
- (id)initWithTitle:(NSMutableArray*)years withyear:(NSString*)year withMonth:(NSString*)month withDay:(NSString*)day
{
    self = [super init];
    if (self) {
        self.arrayOfYears=[[NSMutableArray alloc] initWithArray:years];
        self.arrayOfMonth=[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
        self.arrayOfDay=[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31", nil];
        self.year=year;
        self.month=month;
        self.day=day;
        [self setSubviews];
    }
    return self;

}
- (void)setSubviews{
    _viewOfBig=[[UIView alloc] init];
    _viewOfBig.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
    _viewOfBig.backgroundColor=[UIColor blackColor];
    _viewOfBig.alpha=0.5;
    _viewOfBig.userInteractionEnabled=YES;
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent)];
    gestureRecognizer.numberOfTapsRequired =1;
    gestureRecognizer.numberOfTouchesRequired = 1;
    [_viewOfBig addGestureRecognizer:gestureRecognizer];
    [self createSelectView];
    
}
- (void)createSelectView{
    if (_viewOfSelectTime==nil) {
        _viewOfSelectTime=[[UIView alloc] init];
    }
//    _viewOfSelectTime.frame=CGRectMake(WLsize(15), WLsize(23), WIDTH-WLsize(30), WLsize(540));
//    _viewOfSelectTime.backgroundColor=[UIColor whiteColor];
//    _viewOfSelectTime.layer.masksToBounds=YES;
//    _viewOfSelectTime.layer.cornerRadius=WLsize(5.0);
    if (_tableview==nil) {
        _tableview=[[UITableView alloc] init];
    }
    _tableview.frame=CGRectMake(WLsize(15), WLsize(23), WIDTH-WLsize(30), WLsize(560));
    _tableview.backgroundColor=[UIColor whiteColor];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.window addSubview:self.viewOfBig];
//    [app.window addSubview:self.viewOfSelectTime];

    [app.window addSubview:self.tableview];

}
#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height =KCellHeight;
    switch (indexPath.row) {
        case 0:
            height =KCellHeight;
            break;
        case 1:
            height =KCellHeight2;
            break;
        case 2:
            height =KCellHeight3;
            break;
        case 3:
            height =KCellHeight4;
            break;
            
        default:
            break;
    }
    return height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
    else if (indexPath.row==2)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell3:cell AtIndexPath:indexPath];
    }
    else if (indexPath.row==3)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell4:cell AtIndexPath:indexPath];
    }
    return cell;
}
#pragma mark --创建cell
- (void)createCell1:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UIButton *btn1 =[[UIButton alloc] init];
    btn1.frame=CGRectMake(WLsize(10), WLsize(23), WLsize(80), WLsize(26));
    btn1.backgroundColor=WLORANGColor;
    [btn1 setTitle:@"选择时间" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.titleLabel.font =[UIFont systemFontOfSize:WLsize(14)];
    btn1.layer.masksToBounds=YES;
    btn1.layer.cornerRadius=WLsize(5);
    [btn1 addTarget:self action:@selector(clickSelectTime:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btn1];
    UILabel *lbOfTitle =[[UILabel alloc] init];
    lbOfTitle.frame=CGRectMake((self.tableview.frame.size.width-WLsize(120))/2.0,btn1.frame.origin.y, WLsize(120), btn1.frame.size.height);
    lbOfTitle.text=@"《       年       》";
    lbOfTitle.font=[UIFont systemFontOfSize:WLsize(14)];
    lbOfTitle.textColor=UIColorFromInt(153, 153, 153, 1);
    lbOfTitle.textAlignment=NSTextAlignmentCenter;
    [cell.contentView addSubview:lbOfTitle];
    UILabel *lbOfSep = [[UILabel alloc] init];
    lbOfSep.frame=CGRectMake(WLsize(10), CGRectGetMaxY(btn1.frame)+WLsize(23), (self.tableview.frame.size.width-WLsize(20)), 1.0/2);
    lbOfSep.backgroundColor=WLSEPLBColor;
    [cell.contentView addSubview:lbOfSep];
    
    UIView *viewOfContent = [[UIView alloc] init];
    viewOfContent.frame=CGRectMake(WLsize(30), CGRectGetMaxY(lbOfSep.frame)+WLsize(20), self.tableview.frame.size.width-WLsize(60), WLsize(65));
    [cell.contentView addSubview:viewOfContent];
    CGFloat  ww =KCellBtnW;
    CGFloat hh =KCellBtnH;
    CGFloat sepw = (viewOfContent.frame.size.width-ww*5)/4.0;
    CGFloat seph = (viewOfContent.frame.size.height-hh*2);
    for (int i=0; i<self.arrayOfYears.count; i++) {
        int row = i/5;
        int colum = i%5;
        UIButton *btnYear = [[UIButton alloc] init];
        btnYear.frame=CGRectMake((ww+sepw)*colum, (hh+seph)*row, ww, hh);
        [btnYear setTitle:[self.arrayOfYears objectAtIndex:i] forState:UIControlStateNormal];
        btnYear.titleLabel.font=[UIFont systemFontOfSize:WLsize(12)];
        btnYear.layer.masksToBounds=YES;
        btnYear.layer.cornerRadius=WLsize(4);
        btnYear.tag=i+1;
        [btnYear addTarget:self action:@selector(clickYear:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.year isEqualToString:[self.arrayOfYears objectAtIndex:i]]) {
            btnYear.backgroundColor=WLORANGColor;
            [btnYear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else{
            btnYear.backgroundColor=[UIColor whiteColor];
            [btnYear setTitleColor:WLTEXTCOLOR forState:UIControlStateNormal];
        }
        [viewOfContent addSubview:btnYear];
    }

}
#pragma mark --创建cell
- (void)createCell2:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *lbOfTitle =[[UILabel alloc] init];
    lbOfTitle.frame=CGRectMake((self.tableview.frame.size.width-WLsize(120))/2.0,WLsize(30), WLsize(120), WLsize(26));
    lbOfTitle.text=@"《       月       》";
    lbOfTitle.font=[UIFont systemFontOfSize:WLsize(14)];
    lbOfTitle.textColor=UIColorFromInt(153, 153, 153, 1);
    lbOfTitle.textAlignment=NSTextAlignmentCenter;
    [cell.contentView addSubview:lbOfTitle];
//    UILabel *lbOfSep = [[UILabel alloc] init];
//    lbOfSep.frame=CGRectMake(WLsize(10), CGRectGetMaxY(lbOfTitle.frame)+WLsize(23), (self.tableview.frame.size.width-WLsize(20)), 1.0/2);
//    lbOfSep.backgroundColor=WLSEPLBColor;
//    [cell.contentView addSubview:lbOfSep];
    
    UIView *viewOfContent = [[UIView alloc] init];
    viewOfContent.frame=CGRectMake(WLsize(30), CGRectGetMaxY(lbOfTitle.frame)+WLsize(10), self.tableview.frame.size.width-WLsize(60), WLsize(85));
    [cell.contentView addSubview:viewOfContent];
    CGFloat  ww =KCellBtnW;
    CGFloat hh =KCellBtnH;
    CGFloat sepw = (viewOfContent.frame.size.width-ww*5)/4.0;
    CGFloat seph = (viewOfContent.frame.size.height-hh*3)/2;
    for (int i=0; i<self.arrayOfMonth.count; i++) {
        int row = i/5;
        int colum = i%5;
        UIButton *btnYear = [[UIButton alloc] init];
        btnYear.frame=CGRectMake((ww+sepw)*colum, (hh+seph)*row, ww, hh);
        [btnYear setTitle:[NSString stringWithFormat:@"%@月",[self.arrayOfMonth objectAtIndex:i]] forState:UIControlStateNormal];
        btnYear.titleLabel.font=[UIFont systemFontOfSize:WLsize(12)];
        btnYear.layer.masksToBounds=YES;
        btnYear.layer.cornerRadius=WLsize(4);
        btnYear.tag=i+1;
        [btnYear addTarget:self action:@selector(clickMonth:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.month intValue]==(i+1)) {
            btnYear.backgroundColor=WLORANGColor;
            [btnYear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else{
            btnYear.backgroundColor=[UIColor whiteColor];
            [btnYear setTitleColor:WLTEXTCOLOR forState:UIControlStateNormal];
        }
        [viewOfContent addSubview:btnYear];
    }
    
}
#pragma mark --创建cell
- (void)createCell3:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *lbOfTitle =[[UILabel alloc] init];
    lbOfTitle.frame=CGRectMake((self.tableview.frame.size.width-WLsize(120))/2.0,WLsize(23), WLsize(120), WLsize(16));
    lbOfTitle.text=@"《       日       》";
    lbOfTitle.font=[UIFont systemFontOfSize:WLsize(14)];
    lbOfTitle.textColor=UIColorFromInt(153, 153, 153, 1);
    lbOfTitle.textAlignment=NSTextAlignmentCenter;
    [cell.contentView addSubview:lbOfTitle];
//    UILabel *lbOfSep = [[UILabel alloc] init];
//    lbOfSep.frame=CGRectMake(WLsize(10), CGRectGetMaxY(lbOfTitle.frame)+WLsize(23), (self.tableview.frame.size.width-WLsize(20)), 1.0/2);
//    lbOfSep.backgroundColor=WLSEPLBColor;
//    [cell.contentView addSubview:lbOfSep];
    
    UIView *viewOfContent = [[UIView alloc] init];
    viewOfContent.frame=CGRectMake(WLsize(20), CGRectGetMaxY(lbOfTitle.frame)+WLsize(6), self.tableview.frame.size.width-WLsize(40), WLsize(144));
    [cell.contentView addSubview:viewOfContent];
    CGFloat  ww =WLsize(45);
    CGFloat hh =WLsize(18);
    CGFloat sepw = (viewOfContent.frame.size.width-ww*6)/4.0;
    CGFloat seph = (viewOfContent.frame.size.height-hh*6)/5.0;
    for (int i=0; i<self.arrayOfDay.count; i++) {
        int row = i/6;
        int colum = i%6;
        UIButton *btnYear = [[UIButton alloc] init];
        btnYear.frame=CGRectMake((ww+sepw)*colum, (hh+seph)*row, ww, hh);
        [btnYear setTitle:[self.arrayOfDay objectAtIndex:i] forState:UIControlStateNormal];
        btnYear.titleLabel.font=[UIFont systemFontOfSize:WLsize(12)];
        btnYear.layer.masksToBounds=YES;
        btnYear.layer.cornerRadius=WLsize(4);
        btnYear.tag=i+1;
        [btnYear addTarget:self action:@selector(clickDay:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.day isEqualToString:[self.arrayOfDay objectAtIndex:i]]) {
            btnYear.backgroundColor=WLORANGColor;
            [btnYear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else{
            btnYear.backgroundColor=[UIColor whiteColor];
            [btnYear setTitleColor:WLTEXTCOLOR forState:UIControlStateNormal];
        }
        [viewOfContent addSubview:btnYear];
    }
    
}
#pragma mark --创建cell
- (void)createCell4:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    UIButton *btnSure = [[UIButton alloc] init];
    btnSure.frame=CGRectMake((self.tableview.frame.size.width-WLsize(80))/2.0,WLsize(15), WLsize(80), WLsize(24));
    [btnSure setTitle:@"确认" forState:UIControlStateNormal];
    btnSure.titleLabel.font=[UIFont systemFontOfSize:WLsize(12)];
    btnSure.layer.masksToBounds=YES;
    btnSure.layer.cornerRadius=WLsize(4);
    [btnSure addTarget:self action:@selector(clickSure:) forControlEvents:UIControlEventTouchUpInside];
        btnSure.backgroundColor=WLORANGColor;
        [btnSure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cell.contentView addSubview:btnSure];
}


#pragma mark --选择时间
-(void)clickSelectTime:(UIButton *)button
{
    NSLog(@"clickSelectTime");
}
#pragma mark --点击年
-(void)clickYear:(UIButton *)button
{
    self.year=button.titleLabel.text;
    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    //获取当月天数
    NSInteger count = [self getDaysInMonth:[self.year intValue] month:[self.month intValue]];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (int i=1; i<=count; i++) {
        [temp addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.arrayOfDay=[[NSMutableArray alloc] initWithArray:temp];
    if ([self.day intValue]>self.arrayOfDay.count) {
        self.day=@"";
        
    }
    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
}
#pragma mark --点击月
-(void)clickMonth:(UIButton *)button
{
    self.month=[self.arrayOfMonth objectAtIndex:button.tag-1];
    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    //获取当月天数
    NSInteger count = [self getDaysInMonth:[self.year intValue] month:[self.month intValue]];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (int i=1; i<=count; i++) {
        [temp addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.arrayOfDay=[[NSMutableArray alloc] initWithArray:temp];
    if ([self.day intValue]>self.arrayOfDay.count) {
        self.day=@"";

    }
    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];

}
#pragma mark --点击日
-(void)clickDay:(UIButton *)button
{
    self.day=button.titleLabel.text;
    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark --点击确认
-(void)clickSure:(UIButton *)button
{
    NSLog(@"年=%@，月=%@，日=%@",self.year,self.month,self.day);
    if ([self clickSure]) {
        [self clickSure](self.year,self.month,self.day);
    }
    [self handleSingleFingerEvent];
    
}



#pragma mark --点击取消
-(void)handleSingleFingerEvent
{
    [self.viewOfBig removeFromSuperview];
    [self.viewOfSelectTime removeFromSuperview];
    [self.tableview removeFromSuperview];

}

// 获取某年某月总共多少天
- (int)getDaysInMonth:(int)year month:(int)imonth {
    // imonth == 0的情况是应对在CourseViewController里month-1的情况
    if((imonth == 0)||(imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
        return 28;
    }
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}


@end
