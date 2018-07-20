//
//  WLBusinessLocatedViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/20.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLBusinessLocatedViewController.h"
#define KCELLHeight 44
#define KCELLHeight11 70

@interface WLBusinessLocatedViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *arrayOfData;
@property (nonatomic,strong) NSMutableArray *arrayOfTextfield;
@property (nonatomic,assign) BOOL selectTime;
//主营标签
@property (nonatomic,strong) NSMutableArray *arrayOfSign;
//主营标签的输入框
@property (nonatomic,strong) UITextField *textfieldOfSign;

@end

@implementation WLBusinessLocatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"商家注册";
    self.selectTime=NO;
    self.view.userInteractionEnabled=YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOther)];
    [self.view addGestureRecognizer:ges];
    self.arrayOfData=[[NSMutableArray alloc] initWithObjects:@"基本信息",@"申请人",@"邀请人ID",@"店铺名称",@"店铺电话",@"地址",@"营业时间",@"门店类型",@"主营业务",@"主营标签", nil];
    self.arrayOfTextfield=[[NSMutableArray alloc] init];
    self.arrayOfSign=[[NSMutableArray alloc] initWithObjects:@"烧烤",@"日韩风", nil];
    
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
    for (UITextField *textfield in self.arrayOfTextfield) {
            [textfield resignFirstResponder];
    }
}
#pragma mark --创建UI
- (void)createUI{
    if (self.tableview==nil) {
        self.tableview=[[UITableView alloc] init];
    }
    self.tableview.frame = CGRectMake(0, 0, WIDTH, HEIGHT-XCStatusBar);
    self.tableview.backgroundColor=[UIColor whiteColor];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
}

#pragma mark--UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfData.count+2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigth=KCELLHeight;
    if (indexPath.row==11) {
        heigth=KCELLHeight11;
    }
    if (indexPath.row==6 && self.selectTime) {
        heigth=KCELLHeight*2;
    }
    if (indexPath.row==9) {
        if ((self.arrayOfSign.count/3)>0) {
            heigth=KCELLHeight*2+((self.arrayOfSign.count/3)*KCELLHeight-(self.arrayOfSign.count%3==0?KCELLHeight:0));
        }
        else{
            heigth=KCELLHeight*2;
        }
    }
    return heigth;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    if (indexPath.row<10) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell1:cell AtIndexPath:indexPath];
    }else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell2:cell AtIndexPath:indexPath];
    }
    
    
    return cell;
}

#pragma mark --创建cell
- (void)createCell1:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UILabel *lbOfTitle = [[UILabel alloc] init];
        lbOfTitle.frame=CGRectMake(WLsize(10.0), 0, WLsize(90.0),KCELLHeight);
        lbOfTitle.textColor=UIColorFromRGB(0x101010, 1);
        lbOfTitle.font = [UIFont systemFontOfSize:12.0];
        lbOfTitle.text=[self.arrayOfData objectAtIndex:indexPath.row];
        [cell.contentView addSubview:lbOfTitle];

        UILabel *lbSep = [[UILabel alloc] init];
        lbSep.frame = CGRectMake(0,KCELLHeight-1.0, WIDTH, 1.0);
        lbSep.backgroundColor=UIColorFromRGB(0xBBBBBB, 1);
        [cell.contentView addSubview:lbSep];
    }
    else{
        UILabel *lbOfTitle = [[UILabel alloc] init];
        lbOfTitle.frame=CGRectMake(WLsize(10.0), 0, WLsize(90.0),KCELLHeight);
        lbOfTitle.textColor=UIColorFromRGB(0x030303, 1);
        lbOfTitle.font = [UIFont systemFontOfSize:16.0];
        lbOfTitle.text=[self.arrayOfData objectAtIndex:indexPath.row];
        [cell.contentView addSubview:lbOfTitle];
        
        UILabel *lbSep = [[UILabel alloc] init];
        lbSep.frame = CGRectMake(WLsize(10.0),KCELLHeight-1.0, WIDTH-WLsize(10.0)*2, 1.0);
        lbSep.backgroundColor=UIColorFromRGB(0xBBBBBB, 1);
        [cell.contentView addSubview:lbSep];
        
        if (indexPath.row==6) {
            UITextField *textfield=[[UITextField alloc] init];
            textfield.frame=CGRectMake(WLsize(102), (KCELLHeight-26.0)/2.0,WLsize(70.0), 26.0);
            textfield.font=[UIFont systemFontOfSize:16.0];
            textfield.placeholder=@"开始时间";
            if (self.selectTime) {
                textfield.text=@"9:30";
            }
            textfield.delegate=self;
            [cell.contentView addSubview:textfield];
            [self.arrayOfTextfield addObject:textfield];
            UILabel *lbOf1 = [[UILabel alloc] init];
            lbOf1.frame=CGRectMake(CGRectGetMaxX(textfield.frame)+WLsize(2.0), (KCELLHeight-24)/2.0, 24.0, 24.0);
            lbOf1.text=@"—";
            lbOf1.textColor=UIColorFromRGB(0x101010, 1);
            lbOf1.font=[UIFont systemFontOfSize:14.0];
            [cell.contentView addSubview:lbOf1];
            lbOf1.hidden=!self.selectTime;
            
            UITextField *textfield2=[[UITextField alloc] init];
            textfield2.frame=CGRectMake(CGRectGetMaxX(textfield.frame)+WLsize(28.0), (KCELLHeight-26.0)/2.0,WLsize(70.0), 26.0);
            textfield2.font=[UIFont systemFontOfSize:16.0];
            textfield2.placeholder=@"结束时间";
            if (self.selectTime) {
                textfield2.text=@"13:30";
            }
            textfield2.delegate=self;
            [cell.contentView addSubview:textfield2];
            [self.arrayOfTextfield addObject:textfield2];
            
            UIButton *btnOfAdd =[[UIButton alloc] init];
            btnOfAdd.frame=CGRectMake(WIDTH-45,(KCELLHeight-24)/2.0, 24, 24);
            [btnOfAdd setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            btnOfAdd.backgroundColor=[UIColor grayColor];
            [btnOfAdd addTarget:self action:@selector(clickTimeAdd) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnOfAdd];
            if (self.selectTime) {
                UITextField *textfield3=[[UITextField alloc] init];
                textfield3.frame=CGRectMake(WLsize(102), (KCELLHeight-26.0)/2.0+KCELLHeight,WLsize(70.0), 26.0);
                textfield3.font=[UIFont systemFontOfSize:16.0];
                textfield3.placeholder=@"开始时间";
                textfield3.delegate=self;
                textfield3.userInteractionEnabled=NO;

                [cell.contentView addSubview:textfield3];
                [self.arrayOfTextfield addObject:textfield3];
                UILabel *lbOf12 = [[UILabel alloc] init];
                lbOf12.frame=CGRectMake(CGRectGetMaxX(textfield3.frame)+WLsize(2.0), (KCELLHeight-24)/2.0+KCELLHeight, 24.0, 24.0);
                lbOf12.text=@"—";
                lbOf12.textColor=UIColorFromRGB(0x101010, 1);
                lbOf12.font=[UIFont systemFontOfSize:14.0];
                lbOf12.hidden=NO;
                [cell.contentView addSubview:lbOf12];
                
                UITextField *textfield4=[[UITextField alloc] init];
                textfield4.frame=CGRectMake(CGRectGetMaxX(textfield3.frame)+WLsize(28.0), (KCELLHeight-26.0)/2.0+KCELLHeight,WLsize(70.0), 26.0);
                textfield4.font=[UIFont systemFontOfSize:16.0];
                textfield4.placeholder=@"结束时间";
                textfield4.delegate=self;
                textfield4.userInteractionEnabled=NO;
                [cell.contentView addSubview:textfield4];
                [self.arrayOfTextfield addObject:textfield4];
                UILabel *lbSep = [[UILabel alloc] init];
                lbSep.frame = CGRectMake(WLsize(10.0),KCELLHeight*2-1.0, WIDTH-WLsize(10.0)*2, 1.0);
                lbSep.backgroundColor=UIColorFromRGB(0xBBBBBB, 1);
                [cell.contentView addSubview:lbSep];
                UIButton *btnOfMinus =[[UIButton alloc] init];
                btnOfMinus.frame=CGRectMake(WIDTH-45,(KCELLHeight-24)/2.0+KCELLHeight, 24, 24);
                [btnOfMinus setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                btnOfMinus.backgroundColor=[UIColor grayColor];
                [btnOfMinus addTarget:self action:@selector(clickTimeMinus:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btnOfMinus];
            }
            
        }
        else if (indexPath.row==9)
        {
            UITextField *textfield=[[UITextField alloc] init];
            textfield.frame=CGRectMake(WLsize(102), (KCELLHeight-26.0)/2.0,WLsize(130.0), 26.0);
            textfield.font=[UIFont systemFontOfSize:16.0];
            textfield.placeholder=@"如烧烤，火锅等";
            textfield.delegate=self;
            textfield.userInteractionEnabled=NO;
            [cell.contentView addSubview:textfield];
//            [self.arrayOfTextfield addObject:textfield];
         
            
            UIButton *btnOfAdd =[[UIButton alloc] init];
            btnOfAdd.frame=CGRectMake(WIDTH-45,(KCELLHeight-24)/2.0+KCELLHeight, 24, 24);
            [btnOfAdd setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            btnOfAdd.backgroundColor=[UIColor grayColor];
            [btnOfAdd addTarget:self action:@selector(clickBusinessAdd) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnOfAdd];
            CGFloat ww=WLsize(80.0);
            CGFloat hh= 30;
            CGFloat sepw =WLsize(10.0);
            CGFloat seph =7.0;
            for (int i=0; i<self.arrayOfSign.count; i++) {
                NSInteger row =i/3;
                NSInteger cloum= i%3;
                UIButton *btn1 =[[UIButton alloc] init];
                btn1.frame=CGRectMake(sepw+(ww+sepw)*cloum,seph+KCELLHeight*row+KCELLHeight, ww, hh);
                btn1.layer.masksToBounds=YES;
                btn1.layer.borderWidth=1.0;
                btn1.layer.cornerRadius=4.0;
                btn1.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
                [btn1 setTitle:[self.arrayOfSign objectAtIndex:i] forState:UIControlStateNormal];
                [btn1 setTitleColor:UIColorFromRGB(0x101010, 1) forState:UIControlStateNormal];
                btn1.titleLabel.font=[UIFont systemFontOfSize:WLsize(14.0)];
                //button长按事件
                UILongPressGestureRecognizer*longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
                
                longPress.minimumPressDuration=0.8;//定义按的时间
                
                [btn1 addGestureRecognizer:longPress];
                [cell.contentView addSubview:btn1];
            }
            
        }
        else{
            UITextField *textfield=[[UITextField alloc] init];
            textfield.frame=CGRectMake(WLsize(102), (KCELLHeight-26.0)/2.0, WIDTH-WLsize(102.0), 26.0);
            textfield.font=[UIFont systemFontOfSize:16.0];
            textfield.placeholder=@"必填";
            textfield.delegate=self;
            [cell.contentView addSubview:textfield];
            [self.arrayOfTextfield addObject:textfield];
        }
    }
    
}
- (void)createCell2:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==10) {
    UIButton *btnSelect = [[UIButton alloc] init];
    btnSelect.frame=CGRectMake(WLsize(10.0),(KCELLHeight-24.0)/2.0, 24.0, 24.0);
    [btnSelect setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btnSelect addTarget:self action:@selector(clickAllow:) forControlEvents:UIControlEventTouchUpInside];
        btnSelect.backgroundColor=[UIColor grayColor];
    btnSelect.selected=YES;
    [cell.contentView addSubview:btnSelect];
    UILabel *lbOfContent = [[UILabel alloc] init];
    lbOfContent.frame=CGRectMake(CGRectGetMaxX(btnSelect.frame)+WLsize(6.0), 0, WIDTH-CGRectGetMaxX(btnSelect.frame)-WLsize(6.0), KCELLHeight);
    lbOfContent.textColor=UIColorFromRGB(0x101010, 1);
    lbOfContent.font=[UIFont systemFontOfSize:14.0];
    lbOfContent.text=@"同意并阅读《入驻协议》";
    [cell.contentView addSubview:lbOfContent];
        UILabel *lbSep = [[UILabel alloc] init];
        lbSep.frame = CGRectMake(0,KCELLHeight-1.0, WIDTH, 1.0);
        lbSep.backgroundColor=UIColorFromRGB(0xBBBBBB, 1);
        [cell.contentView addSubview:lbSep];
    }else{
        UIButton *btnOfRegister = [[UIButton alloc] init];
        btnOfRegister.frame = CGRectMake(WLsize(10.0),WLsize(15.0), WIDTH-WLsize(20.0),40.0);
        btnOfRegister.layer.masksToBounds=YES;
        btnOfRegister.layer.borderWidth=1.0;
        btnOfRegister.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
        btnOfRegister.layer.cornerRadius=4.0;
        [btnOfRegister setTitle:@"确定" forState:UIControlStateNormal];
        [btnOfRegister setTitleColor:UIColorFromRGB(0x101010, 1) forState:UIControlStateNormal];
        btnOfRegister.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [btnOfRegister addTarget:self action:@selector(clickSure) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnOfRegister];
    }
}
#pragma mark --textDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self clickOther];
    return YES;
}
#pragma mark --营业时间点击+
-(void)clickTimeAdd{
    self.selectTime=YES;
    [self.tableview reloadData];
}
#pragma mark --营业时间点击-
-(void)clickTimeMinus:(UIButton *)button{
    self.selectTime=NO;
    
    [self.tableview reloadData];
}
#pragma mark --主营点击+
-(void)clickBusinessAdd{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"主营标签" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"添加", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *txtPhoneNum = [alert textFieldAtIndex:0];
    txtPhoneNum.keyboardType = UIKeyboardTypeNumberPad;
    [txtPhoneNum becomeFirstResponder];
    txtPhoneNum.placeholder=@"如烧烤";
    txtPhoneNum.delegate = self;
    self.textfieldOfSign = txtPhoneNum;
    [alert show];
}
#pragma mark --长按删除
-(void)btnLong:(UIGestureRecognizer *)ges
{
    UIButton *button = (UIButton *)[ges view];
    NSLog(@"btnLong");
    NSString *strText =button.titleLabel.text;
    [self.arrayOfSign removeObject:strText];
    [self.tableview reloadData];
}

#pragma mark --勾选入驻协议
- (void)clickAllow:(UIButton *)button
{
    button.selected=!button.selected;
}
#pragma mark --点击确定
-(void)clickSure{
    
}

#pragma mark --UIAlertViewController
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        [self.arrayOfSign addObject:self.textfieldOfSign.text];
        [self.tableview reloadData];
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
