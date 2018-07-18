//
//  WZGuideViewController.m 首次安装引导页
//  WZGuideViewController
//
//  Created by Wei on 13-3-11.
//  Copyright (c) 2013年 ZhuoYun. All rights reserved.
//

#import "WZGuideViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "PublicNavViewController.h"
#import "XCNavigationModalViewController.h"
#import "MyKeyChainHelper.h"
#import "XCLoginViewController.h"
//#import "XCAutomaticlyLogin.h"
#import "UIImage+JSH.h"
#import "XCWebViewController.h"

@interface WZGuideViewController ()<UIScrollViewDelegate>

@end

@implementation WZGuideViewController

@synthesize animating = _animating;

@synthesize pageScroll = _pageScroll;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark -

- (CGRect)onscreenFrame
{
    return [UIScreen mainScreen].bounds;
//	return [UIScreen mainScreen].applicationFrame;
}

- (CGRect)offscreenFrame
{
	CGRect frame = [self onscreenFrame];
	switch ([UIApplication sharedApplication].statusBarOrientation)
    {
		case UIInterfaceOrientationPortrait:
			frame.origin.y = frame.size.height;
			break;
		case UIInterfaceOrientationPortraitUpsideDown:
			frame.origin.y = -frame.size.height;
			break;
		case UIInterfaceOrientationLandscapeLeft:
			frame.origin.x = frame.size.width;
			break;
		case UIInterfaceOrientationLandscapeRight:
			frame.origin.x = -frame.size.width;
			break;
	}
	return frame;
}

- (void)showGuide
{
	if (!_animating && self.view.superview == nil)
	{
		[WZGuideViewController sharedGuide].view.frame = [self offscreenFrame];
		[[self mainWindow] addSubview:[WZGuideViewController sharedGuide].view];
		
		_animating = YES;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.0];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(guideShown)];
		[WZGuideViewController sharedGuide].view.frame = [self onscreenFrame];
		[UIView commitAnimations];
	}
}

- (void)guideShown
{
	_animating = NO;
}

- (void)hideGuide
{
	if (!_animating && self.view.superview != nil)
	{
		_animating = YES;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(guideHidden)];
		[WZGuideViewController sharedGuide].view.frame = [self offscreenFrame];
		[UIView commitAnimations];
	}
}

- (void)guideHidden
{
	_animating = NO;
	[[[WZGuideViewController sharedGuide] view] removeFromSuperview];
}

- (UIWindow *)mainWindow
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}

+ (void)show
{
    [[WZGuideViewController sharedGuide].pageScroll setContentOffset:CGPointMake(0.f, 0.f)];
	[[WZGuideViewController sharedGuide] showGuide];
}

+ (void)hide
{
	[[WZGuideViewController sharedGuide] hideGuide];
}

#pragma mark -

+ (WZGuideViewController *)sharedGuide
{
    @synchronized(self)
    {
        static WZGuideViewController *sharedGuide = nil;
        if (sharedGuide == nil)
        {
            sharedGuide = [[self alloc] init];
        }
        return sharedGuide;
    }
}

- (void)pressCheckButton:(UIButton *)checkButton
{ 
    [checkButton setSelected:!checkButton.selected];
}

- (void)pressEnterButton:(UIButton *)enterButton
{
   
        
        
    [self gotoLoginViewController];

    [[NSNotificationCenter defaultCenter] postNotificationName:KGuidingPageClosedNotification object:nil];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];


   }

//-(void)loginAutomaticly
//{
//    [XCAutomaticlyLogin loginAudomaticlyWithcontroller:self];
//
//
//}

#pragma mark - 监听textField
- (void)setupObserver
{
    //登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessfulAnddismissInLoading) name:KLoginSuccessfulNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupObserver];
    
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)loginSuccessfulAnddismissInLoading
{
    
    AppDelegate* appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

#warning 此处崩溃
//    XCWebViewController *vc = [[XCWebViewController alloc] init];
//    vc.strurl=@"http://180.76.162.182";
    appDelegate.window.rootViewController =
    [[PublicNavViewController alloc] initWithRootViewController:[[ViewController alloc] init]];

    
}


- (void)gotoLoginViewController
{
    XCLoginViewController *loginVC = [[XCLoginViewController alloc] init];
    XCNavigationModalViewController *navLogin = [[XCNavigationModalViewController alloc] initWithRootViewController:loginVC];
    [self presentViewController:navLogin animated:YES completion:nil];
//    XCBeforeLoginViewController *loginVC = [[XCBeforeLoginViewController alloc] init];
// 
//    [self presentViewController:loginVC animated:YES completion:nil];

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, HEIGHT-83.0f/2, WIDTH, 20)];
    //page.backgroundColor = [UIColor whiteColor];
    NSArray *imageNameArray;
    if (IPHONE5)
         //if ([UIScreen mainScreen].bounds.size.height == 568)
    
    {
        if (fiveInch) {
            imageNameArray = [NSArray arrayWithObjects:@"667-1", @"667-2", @"667-3" ,nil];

        }
        else if(sixInch)
            
        {
            imageNameArray = [NSArray arrayWithObjects:@"736-1", @"736-2", @"736-3" ,nil];

        }
        else if(xInch)
            
        {
            imageNameArray = [NSArray arrayWithObjects:@"812-1", @"812-2", @"812-3" ,nil];
            
        }
        else
        {
            imageNameArray = [NSArray arrayWithObjects:@"568-1", @"568-2", @"568-3",nil];

        }
        
    }
    else
    {
        imageNameArray = [NSArray arrayWithObjects:@"480-1", @"480-2", @"480-3", nil];
    }
    page.numberOfPages = imageNameArray.count;
    
    self.view.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:245/255.0 green:244/255.0 blue:242/255.0 alpha:1.0];
    
    if ( IOSVersion >= 7.0 )
    {
        //_pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, 320,  IPHONE5?568:480)];
        
        //jiang 6 适配
//        CGFloat pageScrollH = IPHONE5?568:480;
//        if (fiveInch) {
//            pageScrollH =  667;
//        }
         //_pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, WIDTH,  pageScrollH)];
        //_pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, fiveInch?0:-20, WIDTH,  HEIGHT)];
        _pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH,  HEIGHT)];
        
    }
    else
    {
       // _pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320,  IPHONE5?568:480)];
        //jiang 6 适配
//        CGFloat pageScrollH = IPHONE5?568:480;
//        if (fiveInch) {
//            pageScrollH =  667;
//        }
        //_pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH,  pageScrollH)];
        _pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH,  HEIGHT)];
        
        
    }
    self.pageScroll.pagingEnabled = YES;
    self.pageScroll.contentSize = CGSizeMake(self.view.frame.size.width * imageNameArray.count, self.view.frame.size.height);
    self.pageScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.pageScroll];
    
    _pageScroll.delegate = self;
    
//    NSString *imgName = nil;
    UIImageView *view;
    for (int i = 0; i < imageNameArray.count; i++)
    {
//        imgName = [imageNameArray objectAtIndex:i];
        view = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width * i), 0.f, self.view.frame.size.width, self.view.frame.size.height)];
//        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imgName]];
        
        view.image = [UIImage imageNamed:[imageNameArray objectAtIndex:i]];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:245/255.0 green:244/255.0 blue:242/255.0 alpha:1.0];
        
        [self.pageScroll addSubview:view];
        
        if (i == imageNameArray.count - 1) {
            
            UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
            enterButton.frame = CGRectMake((WIDTH-472.0/2)/2, HEIGHT-159/2, 472.0/2, 172.0/2);
            enterButton.layer.masksToBounds = YES;
            enterButton.layer.cornerRadius = 5;
//            if ( IOSVersion >= 7.0 )
//            {
//                if ( HEIGHT > 480 )
//                {
//                    
//                    enterButton = [[UIButton alloc] initWithFrame:CGRectMake(320.f*2, 0.f, 279.f/2, 40.f)];
//                    if (fiveInch) {
//                        //enterButtonCenterY = view.frame.size.height * 0.9;
//                        CGRect enterButtonRect  = enterButton.frame;
//                        enterButtonRect.size.width =  enterButtonRect.size.width + 30;
//                        enterButton.frame = enterButtonRect;
//                        
//                    }else if(sixInch){
//                        CGRect enterButtonRect  = enterButton.frame;
//                        enterButtonRect.size.width =  enterButtonRect.size.width + 30 +20;
//                        enterButton.frame = enterButtonRect;
//                    
//                    }else{}
//                    
//                }
//                else
//                {
//                    enterButton = [[UIButton alloc] initWithFrame:CGRectMake(320.f*2, 0.f, 279.f/2, 40.f)];
//                }
//                enterButton.clipsToBounds = YES;
//                enterButton.layer.cornerRadius = 3;
//            }
//            else
//            {
//               enterButton = [[UIButton alloc] initWithFrame:CGRectMake(320.f*2, 0.f+10, 279.f/2, 35.f)];
////                CGRect enterButtonRect  = enterButton.frame;//jiang
////                enterButtonRect.size.width =  enterButtonRect.size.width + 30;//jiang
////                enterButton.frame = enterButtonRect;//jiang
//            }
//            [enterButton setTitle:@"开启新橙社6.0" forState:UIControlStateNormal];
            enterButton.titleLabel.font = SystemFont(36/2);
//            [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            enterButton.titleLabel.textAlignment = NSTextAlignmentCenter;//JIANG
            [enterButton setBackgroundImage:[UIImage resizedImageWithName:@"guide_btn"] forState:UIControlStateNormal];
//            [enterButton setBackgroundImage:[UIImage resizedImageWithName:@"btn_login_highlighted"] forState:UIControlStateHighlighted];
            
//            [enterButton setBackgroundColor:UIColorFromRGB(0xef3636, 1)];
            //[enterButton setCenter:CGPointMake(320.f*2+self.view.center.x, IPHONE5? 500.f+11 :500.f - 88+30)];
            view = self.pageScroll.subviews[i];//JIANG
            view.userInteractionEnabled = YES;
            CGFloat enterButtonCenterY = 0;
            if (fiveInch) {
                enterButtonCenterY = view.frame.size.height * 0.9;
//                CGRect enterButtonRect  = enterButton.frame;
//                enterButtonRect.size.width =  enterButtonRect.size.width + 30;
//                enterButton.frame = enterButtonRect;
                
            }else if(sixInch){
                 enterButtonCenterY = view.frame.size.height * 0.9;
            }
            else if(xInch){
                enterButtonCenterY = view.frame.size.height * 0.85;
            }
                
            else{
                 enterButtonCenterY = IPHONE5? 500.f+11 :500.f - 88+30;
            }
           // CGFloat enterButtonCenterY = IPHONE5? 500.f+11 :500.f - 88+30;
            [enterButton setCenter:CGPointMake(view.frame.size.width * 0.5, enterButtonCenterY)];//JIANG

            
//            enterButton.backgroundColor = COLOR_ORANGE;
            [enterButton addTarget:self action:@selector(pressEnterButton:) forControlEvents:UIControlEventTouchUpInside];
            //[self.pageScroll addSubview:enterButton];
            
            [view addSubview:enterButton];//JIANG
            
            
        }
    }
    [self.view addSubview:page];
//    page.backgroundColor = [UIColor redColor];
    if (IOS7)
    {
        page.pageIndicatorTintColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
        page.currentPageIndicatorTintColor = DEFAULT_BUTTON_COLOR;
    }
    //page.hidden = YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    page.currentPage = scrollView.contentOffset.x/320;
    
    if (page.currentPage==2)
    {
        page.hidden = YES;
    }
    else
    {
        page.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
