//
//  WLChatViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/6/10.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLChatViewController.h"
#import "WLChatModel.h"
#import "iflyMSC/IFlyMSC.h"
#import "ISRDataHelper.h"

#define KBottomH 44
#define KSubH 35
#define KCELLH 60
@interface WLChatViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,IFlySpeechRecognizerDelegate>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *arrayOfData;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIImageView *imageViewFly;
@property (nonatomic,strong) UIView *flyView;
@property (nonatomic,strong) UIImageView *imageViewFlyBack;

//不带界面的识别对象
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic, strong) NSString * result;

@end

@implementation WLChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arrayOfData =[[NSMutableArray alloc] init];
    [self creatUI];
    [self sendRequest];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.result=@"";
    [self createFly];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [_iFlySpeechRecognizer stopListening];
     
     }

#pragma mark --创建语音识别
- (void)createFly{
    if (_iFlySpeechRecognizer == nil) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    }
    
    [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
    
    //set recognition domain
    [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    
    _iFlySpeechRecognizer.delegate = self;
    if (_iFlySpeechRecognizer != nil) {
        IATConfig *instance = [IATConfig sharedInstance];
        
        //set timeout of recording
        [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //set VAD timeout of end of speech(EOS)
        [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        //set VAD timeout of beginning of speech(BOS)
        [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        //set network timeout
        [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        //set sample rate, 16K as a recommended option
        [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        //set language
        [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        //set accent
        [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        
        //set whether or not to show punctuation in recognition results
        [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
        
    }
    if([[IATConfig sharedInstance].language isEqualToString:@"en_us"]){
        if([IATConfig sharedInstance].isTranslate){
            [self translation:NO];
        }
    }
    else{
        if([IATConfig sharedInstance].isTranslate){
            [self translation:YES];
        }
    }
    
}
-(void)translation:(BOOL) langIsZh
{
    
    if ([IATConfig sharedInstance].haveView == NO) {
        [_iFlySpeechRecognizer setParameter:@"1" forKey:[IFlySpeechConstant ASR_SCH]];
        
        if(langIsZh){
            [_iFlySpeechRecognizer setParameter:@"cn" forKey:@"orilang"];
            [_iFlySpeechRecognizer setParameter:@"en" forKey:@"translang"];
        }
        else{
            [_iFlySpeechRecognizer setParameter:@"en" forKey:@"orilang"];
            [_iFlySpeechRecognizer setParameter:@"cn" forKey:@"translang"];
        }
        
        [_iFlySpeechRecognizer setParameter:@"translate" forKey:@"addcap"];
        
        [_iFlySpeechRecognizer setParameter:@"its" forKey:@"trssrc"];
    }
    //    else{
    //        [_iflyRecognizerView setParameter:@"1" forKey:[IFlySpeechConstant ASR_SCH]];
    //
    //        if(langIsZh){
    //            [_iflyRecognizerView setParameter:@"cn" forKey:@"orilang"];
    //            [_iflyRecognizerView setParameter:@"en" forKey:@"translang"];
    //        }
    //        else{
    //            [_iflyRecognizerView setParameter:@"en" forKey:@"orilang"];
    //            [_iflyRecognizerView setParameter:@"cn" forKey:@"translang"];
    //        }
    //
    //        [_iflyRecognizerView setParameter:@"translate" forKey:@"addcap"];
    //
    //        [_iflyRecognizerView setParameter:@"its" forKey:@"trssrc"];
    //    }
    
    
}
#pragma mark -- 点击开始说话
-(void)startFly
{
    
    NSLog(@"%s[IN]",__func__);
    
    if ([IATConfig sharedInstance].haveView == NO) {
        
        
        [_iFlySpeechRecognizer cancel];
        
        //Set microphone as audio source
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //Set result type
        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //Set the audio name of saved recording file while is generated in the local storage path of SDK,by default in library/cache.
        [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        [_iFlySpeechRecognizer setDelegate:self];
        
        BOOL ret = [_iFlySpeechRecognizer startListening];
        
        if (ret) {
            
            
        }else{
            
        }
    }
    
}


#pragma mark -- IFlySpeechRecognizerDelegate协议实现
//识别结果返回代理
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    //    _result =[NSString stringWithFormat:@"%@%@", _result,resultString];
    
    NSString * resultFromJson =  nil;
    
    resultFromJson = [ISRDataHelper stringFromJson:resultString];
    
    self.result = [NSString stringWithFormat:@"%@%@", self.result,resultFromJson];
    if (isLast){
        NSLog(@"ISR Results(json)：%@",  self.result);
    }
    NSLog(@"_result=%@",_result);
    NSLog(@"resultFromJson=%@",resultFromJson);
    //    NSLog(@"isLast=%d,_textView.text=%@",isLast,_textView.text);
}
//识别会话结束返回代理
- (void)onCompleted: (IFlySpeechError *) error{
    NSLog(@"error=%d",[error errorCode]);
    NSString *text ;
    if (error.errorCode ==0 ) {
        if (self.result.length==0 || [self.result hasPrefix:@"nomatch"]) {
            text = NSLocalizedString(@"T_ASR_NoMat", nil);
        }else
        {
            text = NSLocalizedString(@"T_ISR_Succ", nil);
            //            _resultView.text = _curResult;
        }
    }
    else
    {
        text = [NSString stringWithFormat:@"Error：%d %@", error.errorCode,error.errorDesc];
        NSLog(@"%@",text);
    }
//    [MBProgressHUD showWithMessage:self.result];
    [_iFlySpeechRecognizer stopListening];
    
    self.flyView.tag=1;
    self.textField.text=[NSString stringWithFormat:@"%@%@",self.textField.text,self.result];
    self.imageViewFlyBack.hidden=YES;

    self.result=@"";
    
}
//停止录音回调
- (void) onEndOfSpeech{
    NSLog(@"%@",self.result);
}
//开始录音回调
- (void) onBeginOfSpeech{
    
}
//音量回调函数
- (void) onVolumeChanged: (int)volume{
    
}
//会话取消回调
- (void) onCancel{
    
}

#pragma mark --创建UI
- (void)creatUI{
    if (self.tableview==nil) {
        self.tableview =[[UITableView alloc] init];
    }
    self.tableview.frame=CGRectMake(0, 0, WIDTH, HEIGHT-KBottomH-XCStatusBar);
    self.tableview.backgroundColor=DEFAULT_BackgroundView_COLOR;
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableview.userInteractionEnabled=YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCancle:)];
    [self.tableview addGestureRecognizer:ges];
    [self.view addSubview:self.tableview];
    
    if (self.bottomView==nil) {
        self.bottomView=[[UIView alloc] init];
    }
    self.bottomView.frame=CGRectMake(0, HEIGHT-KBottomH-XCStatusBar, WIDTH, KBottomH);
    self.bottomView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.frame=CGRectMake(10, 9, 26, 27);
    imageView1.image = [UIImage imageNamed:@"icon1p1115"];
    imageView1.userInteractionEnabled=YES;
    imageView1.tag=1;
    UITapGestureRecognizer *ges2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickKBoard:)];
    [imageView1 addGestureRecognizer:ges2];
    self.imageViewFly=imageView1;
    [self.bottomView addSubview:imageView1];
    
    UIButton *btnSend = [[UIButton alloc] init];
    btnSend.frame = CGRectMake(self.bottomView.frame.size.width-70, (KBottomH-KSubH)/2.0, 60, KSubH);
    btnSend.backgroundColor = WLTabbarSelectedColor;
    btnSend.layer.masksToBounds=YES;
    btnSend.layer.cornerRadius=4;
    [btnSend addTarget:self action:@selector(btnOfSend:) forControlEvents:UIControlEventTouchUpInside];
    [btnSend setTitle:@"发送" forState:UIControlStateNormal];
    [btnSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bottomView addSubview:btnSend];
    
    UIView*flyView = [[UIView alloc] init];
    flyView.frame=CGRectMake(0, HEIGHT-216, WIDTH, 216);
    flyView.backgroundColor=[UIColor whiteColor];
    
    
    UIImageView *imageViewback = [[UIImageView alloc] init];
    imageViewback.frame=CGRectMake(0, 0, flyView.frame.size.width, flyView.frame.size.height-60);
    imageViewback.image = [UIImage imageNamed:@"bjp1115"];
    self.imageViewFlyBack=imageViewback;
    [flyView addSubview:imageViewback];
    self.imageViewFlyBack.hidden=YES;
    UIButton *btnOfFly = [[UIButton alloc] init];
    btnOfFly.frame=CGRectMake((WIDTH-56)/2.0, (216-84)/2.0, 56, 84);
    [btnOfFly addTarget:self action:@selector(clickFly:) forControlEvents:UIControlEventTouchUpInside];
    [btnOfFly setImage:[UIImage imageNamed:@"icon2p1115"] forState:UIControlStateNormal];
    btnOfFly.tag=11;
    [flyView addSubview:btnOfFly];
    self.flyView=flyView;
    
    UITextField *textFiled2 = [[UITextField alloc] init];
    textFiled2.frame=CGRectMake(CGRectGetMaxX(imageView1.frame)+15,(KBottomH-KSubH)/2.0 , self.bottomView.frame.size.width-CGRectGetMaxX(imageView1.frame)-90, KSubH);
    textFiled2.delegate=self;
    textFiled2.inputView=self.flyView;
    self.textField=textFiled2;
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.frame=CGRectMake(CGRectGetMaxX(imageView1.frame)+10,(KBottomH-KSubH)/2.0 , self.bottomView.frame.size.width-CGRectGetMaxX(imageView1.frame)-85, KSubH);
    imageView2.image = [UIImage imageNamed:@"srk3p1115"];
    [self.bottomView addSubview:imageView2];
    [self.bottomView addSubview:textFiled2];
    
    
}
#pragma mark --回复请求
-(void)sendRequest{
    WLChatModel *model=[[WLChatModel alloc] init];
    model.role=@"2";
    model.content =@"你好,我是小智";
    [self.arrayOfData addObject:model];
    WLChatModel *model2=[[WLChatModel alloc] init];
    model2.role=@"1";
    model2.content =@"你好,小智";
    [self.arrayOfData addObject:model2];
    WLChatModel *model3=[[WLChatModel alloc] init];
    model3.role=@"2";
    model3.content =@"请问需要我问您做什么?";
    [self.arrayOfData addObject:model3];
    WLChatModel *model4=[[WLChatModel alloc] init];
    model4.role=@"1";
    model4.content =@"帮我把碗洗了";
    [self.arrayOfData addObject:model4];
    [self.tableview reloadData];
}
#pragma mark--UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat maxW=WIDTH-150;
    WLChatModel *model = [self.arrayOfData objectAtIndex:indexPath.row];
    
    CGSize size1 = XCsizeWithFont(model.content, [UIFont systemFontOfSize:17]);
//    CGFloat ww=size1.width>maxW?maxW:size1.width;
    CGFloat hh=((int)(size1.width/maxW)+1)*size1.height+30;
    return hh;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=nil;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self createCell1:cell cellForRowAtIndexPath:indexPath];
    return cell;
    
}
#pragma mark -- createCell
- (void)createCell1:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat maxW=WIDTH-150;
    cell.contentView.backgroundColor = DEFAULT_BackgroundView_COLOR;

    WLChatModel *model = [self.arrayOfData objectAtIndex:indexPath.row];
    CGSize size1 = XCsizeWithFont(model.content, [UIFont systemFontOfSize:17]);
    CGFloat ww=size1.width>maxW?maxW:size1.width;
    CGFloat hh=((int)(size1.width/maxW)+1)*size1.height+15;
    if ([model.role isEqualToString:@"1"]) {
        UIImageView *imageView1=[[UIImageView alloc] init];
        imageView1.frame=CGRectMake(WIDTH-55,(hh+15-40)/2.0, 40, 40);
//        imageView1.frame=CGRectMake(WIDTH-55,45, 40, 40);

        imageView1.image = [UIImage imageNamed:@"yhp1115"];
        [cell.contentView addSubview:imageView1];
      
        UIImageView *imageView2=[[UIImageView alloc] init];
//        imageView2.frame=CGRectMake(imageView1.frame.origin.x-size1.width-35, imageView1.frame.origin.y, size1.width+30, 40);
        imageView2.frame=CGRectMake(imageView1.frame.origin.x-ww-35, (hh+15-hh)/2.0, ww+30, hh);

        imageView2.image = [UIImage imageNamed:@"srk2p1115"];
        [cell.contentView addSubview:imageView2];

        UILabel *lb1=[[UILabel alloc] init];
//        lb1.frame=CGRectMake(imageView1.frame.origin.x-size1.width-35.0/2, imageView1.frame.origin.y, size1.width, 40);
        lb1.frame=CGRectMake(imageView1.frame.origin.x-ww-35.0/2, (hh+15-hh)/2.0, ww, hh);
        lb1.text=model.content;
        lb1.numberOfLines=0;
        lb1.font=[UIFont systemFontOfSize:15];
        lb1.textColor = [UIColor whiteColor];
        [cell.contentView addSubview:lb1];
        
    }else{
        UIImageView *imageView1=[[UIImageView alloc] init];
        imageView1.frame=CGRectMake(15,( hh+15-40)/2.0, 40, 40);
        imageView1.image = [UIImage imageNamed:@"xzp1115"];
        [cell.contentView addSubview:imageView1];
//        CGSize size1 = XCsizeWithFont(model.content, [UIFont systemFontOfSize:17]);
        UIImageView *imageView2=[[UIImageView alloc] init];
//        imageView2.frame=CGRectMake(CGRectGetMaxX(imageView1.frame)+5.0, imageView1.frame.origin.y, size1.width+30, 40);
        imageView2.frame=CGRectMake(CGRectGetMaxX(imageView1.frame)+5.0, (hh+15-hh)/2.0, ww+30, hh);

        imageView2.image = [UIImage imageNamed:@"srkp1115"];
        [cell.contentView addSubview:imageView2];
        UILabel *lb1=[[UILabel alloc] init];
//        lb1.frame=CGRectMake(CGRectGetMaxX(imageView1.frame)+35.0/2+10, imageView1.frame.origin.y, size1.width, 40);
        lb1.frame=CGRectMake(CGRectGetMaxX(imageView1.frame)+35.0/2+10,(hh+15-hh)/2.0,ww, hh);
        lb1.text=model.content;
        lb1.numberOfLines=0;
        lb1.font=[UIFont systemFontOfSize:15];
        lb1.textColor = UIColorFromRGB(0x333333, 1);
        [cell.contentView addSubview:lb1];
        
    }
}
#pragma mark --点击键盘或者语音
- (void)clickKBoard:(UIGestureRecognizer *)ges
{
    NSInteger tag =[ges view].tag;
    if (tag==1) {
//        [self.textField resignFirstResponder];

        self.imageViewFly.tag=2;
        self.imageViewFly.frame=CGRectMake(15, 12, 14, 21);
        self.imageViewFly.image=[UIImage imageNamed:@"icon2p1115"];
        self.textField.inputView=nil;
        [self.textField reloadInputViews];
//        [self.textField becomeFirstResponder];
    }
    else if (tag==2)
    {
//        [self.textField resignFirstResponder];

        self.imageViewFly.tag=1;
        self.imageViewFly.frame=CGRectMake(10, 9, 26, 27);
        self.imageViewFly.image=[UIImage imageNamed:@"icon1p1115"];
        self.textField.inputView=self.flyView;
//        [self.textField becomeFirstResponder];
        [self.textField reloadInputViews];

    }
}

#pragma mark --点击发送
- (void)btnOfSend:(UIButton *)btn
{
    if (self.textField.text.length>0) {
    WLChatModel *modelw=[[WLChatModel alloc] init];
    modelw.role=@"1";
    modelw.content =self.textField.text;
    [self.arrayOfData addObject:modelw];
    WLChatModel *modelx=[[WLChatModel alloc] init];
    modelx.role=@"2";
    modelx.content =@"请稍等一下";
    [self.arrayOfData addObject:modelx];
    [self.tableview reloadData];
        self.textField.text=@"";
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.arrayOfData.count-1 inSection:0];
        [self.tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    else{
        [MBProgressHUD showWithMessage:@"输入内容不能为空！"];
    }
}

#pragma mark --
- (void)keyboardWillShow:(NSNotification *)notification{
        CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    self.flyView.frame=CGRectMake(self.flyView.frame.origin.x, keyboardFrame.origin.y-self.flyView.frame.size.height-44, self.flyView.frame.size.width, self.flyView.frame.size.height);
    CGRect frame = self.view.frame;
    frame.origin.y = -keyboardFrame.size.height+XCStatusBar;
    self.view.frame = frame;
   
}
//实现回收键盘时，输入框恢复原来的位置
- (void)keyboardWillHide:(NSNotification *)notification {
    //恢复到默认y为0的状态，有时候要考虑导航栏要+64
    CGRect frame = self.view.frame;
    frame.origin.y = XCStatusBar2;
    self.view.frame = frame;
}

#pragma mark-
-(void)clickCancle:(UIGestureRecognizer*)ges
{
    [self.textField resignFirstResponder];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    return YES;
}

#pragma mark --点击语音按钮
-(void)clickFly:(UIButton *)btn
{
    if (btn.tag==11) {
        btn.tag=22;
        self.imageViewFlyBack.hidden=NO;
        [self startFly];
    }
    else if (btn.tag==22)
    {
        btn.tag=11;
        self.imageViewFlyBack.hidden=NO;
        [_iFlySpeechRecognizer stopListening];
    }
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
