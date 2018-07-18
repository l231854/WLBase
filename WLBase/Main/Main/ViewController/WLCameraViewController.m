//
//  WLCameraViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/6/6.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLCameraViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <MediaPlayer/MPVolumeView.h>
#import "iflyMSC/IFlyMSC.h"
#import "ISRDataHelper.h"

//#import "MPVolumeView.h"
#define kCameroTag (654321)
#define KScrollViewH 200
#define KMiddlViewH 240
#define KCELLHeight 60
@interface WLCameraViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,IFlySpeechRecognizerDelegate>
@property (nonatomic,strong) UIScrollView *headScrollview;
@property (nonatomic,strong) UIView *middleView;
@property (nonatomic,strong) UIView *flyView;
@property (nonatomic,strong) UILabel *flyOfLb;

@property (nonatomic,strong) NSMutableArray *arrayOfData;
@property (nonatomic,strong) NSMutableArray *arrayOfDataCamera;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *Right;
@property (nonatomic,strong) UIView *grayView;
@property (nonatomic,strong) MPVolumeView *volumeView;
@property (nonatomic,assign) CGFloat volumeNumber;

//不带界面的识别对象
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic, strong) NSString * result;

@end

@implementation WLCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.volumeNumber=0.f;
    // Do any additional setup after loading the view.
    self.title=@"客厅摄像头";
    self.view.backgroundColor=[UIColor whiteColor];
    [self createNavigationItem];
    [self sendRequest];
    [self createUI];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.result=@"";
    [self createFly];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.volumeView removeFromSuperview];
    self.volumeView=nil;
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

- (void)createNavigationItem{
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame=CGRectMake(0, 0, 40, 40);
    [right setImage:[UIImage imageNamed:@"tjp7"] forState:UIControlStateNormal];
    [right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    self.Right=right;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame=CGRectMake(0, 0, 40, 40);
    [left setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [left setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(clickLeft) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    
}
#pragma mark --点击事件
-(void)clickRight
{
    NSLog(@"clickRight");
    [self isShow:YES];


}
-(void)clickLeft
{
    NSLog(@"clickLeft");
    [self.volumeView removeFromSuperview];
    self.volumeView=nil;
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark --请求数据
- (void)sendRequest
{

}

#pragma mark --createUI
-(void)createUI{
    if (self.headScrollview==nil) {
        self.headScrollview = [[UIScrollView alloc] init];
    }
    NSInteger count =5;
    self.headScrollview.frame=CGRectMake(0, 0, WIDTH,KScrollViewH);
    self.headScrollview.delegate=self;
self.headScrollview.contentSize=CGSizeMake(WIDTH*count, 0);
    //设置在拖拽的时候是否锁定其在水平或者垂直的方向
    self.headScrollview.directionalLockEnabled = NO;
    //设置是否可以进行画面切换
    self.headScrollview.pagingEnabled = YES;
    
    //隐藏滚动条设置（水平、跟垂直方向）
    self.headScrollview.alwaysBounceHorizontal = NO;
    self.headScrollview.alwaysBounceVertical = NO;
    self.headScrollview.showsHorizontalScrollIndicator = NO;
    self.headScrollview.showsVerticalScrollIndicator = NO;

    for (int i=0; i<count; i++) {
        UIView *view1 = [[UIView alloc] init];
        view1.frame=CGRectMake(WIDTH*i, 0, WIDTH, self.headScrollview.frame.size.height);
        UIImageView *imageView1 =[[UIImageView alloc] init];
        imageView1.frame=CGRectMake(0, 0, view1.frame.size.width, view1.frame.size.height);
        imageView1.image = [UIImage imageNamed:@"tpp63"];
        [view1 addSubview:imageView1];
        [self.headScrollview addSubview:view1];
    }
    [self.view addSubview:self.headScrollview];
    
    if (self.middleView==nil) {
        self.middleView=[[UIView alloc] init];
    }
    self.middleView.frame= CGRectMake(0, CGRectGetMaxY(self.headScrollview.frame), WIDTH, KMiddlViewH);
    [self.view addSubview:self.middleView];
    CGFloat w2=60;
    CGFloat h2=60;
    NSArray *tempArray1 = [[NSArray alloc] initWithObjects:@"相册",@"解绑",@"拍照",@"声音", nil];
    NSArray *tempArray2 = [[NSArray alloc] initWithObjects:@"icon1p63",@"icon3p63",@"icon2p63",@"icon4p63", nil];

    for (int j=0; j<4; j++) {
        UIView *view2 = [[UIView alloc] init];
        CGFloat sepW=30;
        CGFloat sepH=30;
        CGFloat x=sepW;
        CGFloat y=sepH;
       
        if (j==1||j==3) {
            x=self.middleView.frame.size.width-sepW-w2;
        }
        if (j==2||j==3) {
            y=self.middleView.frame.size.height-sepH-h2;
        }
        view2.frame=CGRectMake(x, y, w2, h2);
        view2.userInteractionEnabled=YES;
        view2.tag=j;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView2:)];
        [view2 addGestureRecognizer:ges];
        [self.middleView addSubview:view2];
        UIImageView *imageView2 = [[UIImageView alloc] init];
        imageView2.frame=CGRectMake((view2.frame.size.width-26)/2.0, 10, 26, 19);
        imageView2.image=[UIImage imageNamed:[tempArray2 objectAtIndex:j]];
        [view2 addSubview:imageView2];
        UILabel *lbOf2 = [[UILabel alloc] init];
        lbOf2.frame=CGRectMake(0, CGRectGetMaxY(imageView2.frame), view2.frame.size.width, 30);
        lbOf2.textColor=UIColorFromRGB(0x666666, 1);
        lbOf2.font=[UIFont systemFontOfSize:14];
        lbOf2.textAlignment=NSTextAlignmentCenter;
        lbOf2.text=[tempArray1 objectAtIndex:j];
        [view2 addSubview:lbOf2];
    }
    
    UIImageView *imageViewBig = [[UIImageView alloc] init];
imageViewBig.frame=CGRectMake((self.middleView.frame.size.width-145)/2.0, (self.middleView.frame.size.height-145)/2.0, 145, 145);
    imageViewBig.image=[UIImage imageNamed:@"icon5p63"];
    imageViewBig.userInteractionEnabled=YES;
    CGFloat w3=30;
    CGFloat h3=30;
    for (int k=0; k<4; k++) {
        CGFloat x3=(imageViewBig.frame.size.width-w3)/2.0;
        CGFloat y3=0;
        if (k==1) {
            x3=0;
            y3=(imageViewBig.frame.size.height-h3)/2.0;
        }else if (k==2)
        {
            y3=imageViewBig.frame.size.height-h3;
            
        }else if (k==3)
        {
            x3=imageViewBig.frame.size.width-h3;
            y3=(imageViewBig.frame.size.height-h3)/2.0;
        }
        UIButton *btn3 =[[UIButton alloc] init];
        btn3.frame=CGRectMake(x3, y3, w3, h3);
        btn3.tag=k;
        btn3.userInteractionEnabled=YES;
        [btn3 addTarget:self action:@selector(clickImageView3:) forControlEvents:UIControlEventTouchUpInside];
        [imageViewBig addSubview:btn3];
    }
    [self.middleView addSubview:imageViewBig];

    if (self.flyView==nil) {
        self.flyView = [[UIView alloc] init];
    }
    self.flyView.frame= CGRectMake(20, CGRectGetMaxY(self.middleView.frame)+30, WIDTH-40, 44);
    self.flyView.backgroundColor=WLTabbarSelectedColor;
    self.flyView.layer.masksToBounds=YES;
    self.flyView.layer.cornerRadius=4.0;
    [self.view addSubview:self.flyView];
    self.flyView.userInteractionEnabled=YES;
    self.flyView.tag=1;
    UITapGestureRecognizer *gesFly = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFly:)];
    [self.flyView addGestureRecognizer:gesFly];
    NSString *strText=@"我要说话";
    CGSize sizelb = XCsizeWithFont(strText, [UIFont systemFontOfSize:18]);
    UIImageView *imageviewFly = [[UIImageView alloc] init];
    imageviewFly.frame=CGRectMake((self.flyView.frame.size.width-sizelb.width-20)/2.0, (self.flyView.frame.size.height-24)/2.0, 18, 24);
    imageviewFly.image=[UIImage imageNamed:@"icon6p63"];
    [self.flyView addSubview:imageviewFly];
    UILabel *lbOfFly = [[UILabel alloc] init];
    lbOfFly.frame=CGRectMake(CGRectGetMaxX(imageviewFly.frame)+8, 0, self.flyView.frame.size.width-CGRectGetMaxX(imageviewFly.frame)-8, self.flyView.frame.size.height);
    lbOfFly.text=strText;
    lbOfFly.textColor=[UIColor whiteColor];
    lbOfFly.font=[UIFont systemFontOfSize:17];
    self.flyOfLb=lbOfFly;
    [self.flyView addSubview:lbOfFly];
    
    [self createtableview];

}
#pragma mark --创建UITableview
-(void)createtableview
{
    if (self.tableView==nil) {
        self.tableView=[[UITableView alloc] init];
    }
    self.tableView.frame=CGRectMake(0, 0, WIDTH, KCELLHeight*4);
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.hidden=YES;
    [self.view addSubview:self.tableView];
    if (self.grayView==nil) {
        self.grayView=[[UIView alloc] init];
    }
    self.grayView.frame=CGRectMake(0, CGRectGetMaxY(self.tableView.frame), WIDTH, HEIGHT-CGRectGetMaxY(self.tableView.frame));
    self.grayView.backgroundColor = [UIColor grayColor];
    self.grayView.alpha=1.0/2;
    [self.view addSubview:self.grayView];
    self.grayView.userInteractionEnabled=YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGray:)];
    self.grayView.hidden=YES;
    [self.grayView addGestureRecognizer:ges];
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count=4;
    return count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KCELLHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self createCell1:cell cellForRowAtIndexPath:indexPath];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击第%ldcell",indexPath.row);
    [self isShow:NO];

}
#pragma mark -- createCell
- (void)createCell1:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.frame = CGRectMake(15, (KCELLHeight-20)/2.0, 20, 20);
    [cell.contentView addSubview:imageView1];
    UILabel *lb1 =[[UILabel alloc] init];
    lb1.frame=CGRectMake(CGRectGetMaxX(imageView1.frame)+15, 0, 100, KCELLHeight);
    lb1.text=[NSString stringWithFormat:@"摄像头%ld",indexPath.row+1];
    if (indexPath.row%2==0) {
        lb1.textColor=UIColorFromInt(98, 208, 125, 1);
        imageView1.image=[UIImage imageNamed:@"icon1p14"];
    }
    else{
        lb1.textColor=UIColorFromInt(252, 117, 117, 1);
        imageView1.image=[UIImage imageNamed:@"icon2p14"];


    }
    [cell.contentView addSubview:lb1];
    
    UIImageView *imageView2=[[UIImageView alloc] init];
    imageView2.frame=CGRectMake(WIDTH-30, (60-15)/2.0, 9, 15);
    imageView2.image = [UIImage imageNamed:@"dyp101"];
    [cell.contentView addSubview:imageView2];
    
    UILabel *lbOfNumber = [[UILabel alloc] init];
    lbOfNumber.frame=CGRectMake(imageView2.frame.origin.x-60, 0, 50, 60);
    lbOfNumber.textColor=UIColorFromRGB(0x999999, 1);
    lbOfNumber.font=[UIFont systemFontOfSize:14];
    lbOfNumber.text=@"客厅";
    if (indexPath.row%2==0) {
        lbOfNumber.text=@"客厅";
    }
    else{
        lbOfNumber.text=@"";

    }
    lbOfNumber.textAlignment=NSTextAlignmentRight;
    [cell.contentView addSubview:lbOfNumber];
    
}
#pragma mark -- 点击相册 解绑 拍照 声音
- (void)clickView2:(UIGestureRecognizer *)ges
{
    NSInteger tag = [ges view].tag;
    switch (tag) {
        case 0:
            NSLog(@"点击相册");
            [self addPhotoFromPhotoLibrary];
            break;
        case 1:
            NSLog(@"点击解绑");

            break;
        case 2:
            NSLog(@"点击拍照");
            [self addPhotoFromCamera];
            break;
        case 3:
            NSLog(@"点击声音");
            [self setVolume:self.volumeNumber];
            break;
            
        default:
            break;
    }
}
#pragma mark -- 点击上下左右
- (void)clickImageView3:(UIButton *)btn
{
    NSInteger tag = btn.tag;
    switch (tag) {
        case 0:
            NSLog(@"上");
            break;
        case 1:
            NSLog(@"左");
            break;
        case 2:
            NSLog(@"下");
            
            break;
        case 3:
            NSLog(@"右");
            
            break;
            
        default:
            break;
    }
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
#pragma mark --点击我要说话
- (void)clickFly:(UIGestureRecognizer *)ges
{
    NSLog(@"clickFly");
    NSInteger tag =[ges view].tag;
    if (tag==1) {
        [ges view].tag=2;
        self.flyOfLb.text=@"语音听写中...";
        //启动识别服务
        [self startFly];

    }
    else{
        [_iFlySpeechRecognizer stopListening];

        [ges view].tag=1;
        self.flyOfLb.text=@"我要说话";
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
    [MBProgressHUD showWithMessage:self.result];
    [_iFlySpeechRecognizer stopListening];
    
    self.flyView.tag=1;
    self.flyOfLb.text=@"我要说话";
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
#pragma mark --点击遮罩
- (void)clickGray:(UIGestureRecognizer *)ges
{
    NSLog(@"clickGray");
    [self isShow:NO];
}
#pragma mark --show
- (void)isShow:(BOOL)isFlag{
    if (isFlag) {
        self.tableView.hidden=NO;
        self.grayView.hidden=NO;
        [self.Right setImage:[UIImage imageNamed:@"tjp7"] forState:UIControlStateNormal];
        [self.Right addTarget:self action:@selector(clickX) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else{
        self.tableView.hidden=YES;
        self.grayView.hidden=YES;
        [self.Right setImage:[UIImage imageNamed:@"tjp7"] forState:UIControlStateNormal];
       [self.Right addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
    }
}
#pragma mark --X
- (void)clickX{
    [self isShow:NO];
}

/* * 设置音量 */
- (void)setVolume:(float)value {
    UISlider *volumeSlider = [self volumeSlider]; self.volumeView.showsVolumeSlider = YES;
    // 需要设置 showsVolumeSlider 为 YES // 下面两句代码是关键
    self.volumeNumber=volumeSlider.value+0.1;
    [volumeSlider setValue:self.volumeNumber animated:NO];
//    [volumeSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
    volumeSlider.hidden = YES;
    volumeSlider.userInteractionEnabled=NO;
    _volumeView.hidden = NO;

    [self.volumeView sizeToFit];
    
}
- (MPVolumeView *)volumeView
{
    if (!_volumeView) {
        _volumeView = [[MPVolumeView alloc] init];
     
        _volumeView.hidden = NO;
        [[UIApplication sharedApplication].delegate.window addSubview:_volumeView];
    }
   
    return _volumeView;
    
}/* * 遍历控件,拿到UISlider */
- (UISlider *)volumeSlider {
    UISlider* volumeSlider = nil;
    for (UIView *view in [self.volumeView subviews]) {
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            volumeSlider = (UISlider *)view;
            break;
        }
        
    }
    return volumeSlider;
    
}

-(void)addPhotoFromPhotoLibrary
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
        //无权限
        if (IOS8) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:kAskOpenPhotosTip delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置",  nil];
            alert.tag = kCameroTag;
            [alert show];
        }
    }else
    {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = YES;
        if (@available(iOS 11.0, *)){
            [[UIScrollView appearance] setContentInsetAdjustmentBehavior:nil];
        }
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
#pragma add photo from camera
-(void)addPhotoFromCamera
{
    //调用照相机
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限
        if (IOS8) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:kAskOpenCameroTip delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置",  nil];
            alert.tag = kCameroTag;
            [alert show];
            
        }
    }else
    {
        //判断是否可以打开相机，模拟器此功能无法使用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            
            picker.delegate = self;
            picker.allowsEditing = YES;  //是否可编辑
            //摄像头
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
        else
        {
            //如果没有提示用户
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [alert show];
        }
    }
}
#pragma mark - UIImagePickerControllerDelegate  调用照相机
//拍摄完成后要执行的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //压缩图片
    image = [image getEmpressImge];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
//    [self changeIconImage:image];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == kCameroTag)
    {
        
        if (buttonIndex == 1) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
