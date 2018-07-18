//
//  XCWebViewController.m
//  CommunityService
//
//  Created by 雷王 on 2017/7/11.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "XCWebViewController2.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface XCWebViewController2 ()<UIWebViewDelegate>
{
    MBProgressHUD *_hud;
    
}
@property (strong, nonatomic)  UIWebView *webView;

@end

@implementation XCWebViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.strurl=@"http://180.76.162.182/scene";

    [self createUI];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //发起登录，TODO, important
    self.navigationController.navigationBar.hidden = YES;
    [self initNavigationItem];
    
}
#pragma mark-- 创建UI
//初始化navigationItem
- (void)initNavigationItem
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationItem.leftBarButtonItem = nil;
    self.navigationController.navigationItem.rightBarButtonItem = nil;
    self.navigationController.navigationItem.titleView = nil;
    self.navigationController.title = nil;
    UINavigationController *nav = self.navigationController;
    UIColor *color = DEFAULT_BackgroundView_COLOR;
    [nav.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    [nav.navigationBar hideLineOfNavtionBar];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (void)createUI{
    //webView设置
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[UIWebView alloc] init];
    if (IOS11) {
        self.webView.frame =CGRectMake(0, 0, WIDTH, HEIGHT-XCTbaBar);
    }
    else{
        self.webView.frame =CGRectMake(0, 20, WIDTH, HEIGHT-XCTbaBar-20);
        
    }    self.webView.delegate = self;
    [self.webView setOpaque:YES];
    [self.webView setDataDetectorTypes:UIDataDetectorTypeNone];
    [self.webView setBackgroundColor:[UIColor whiteColor]];
    [self.webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.webView.scalesPageToFit = YES;
//    self.webView.scrollView.bounces=NO;

    [self.view addSubview:self.webView];
    
    
    NSURL *URL =[NSURL URLWithString:self.strurl];

    NSURLRequest * request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
  }
-(void)loadUrl:(id)param
{

  
    NSURL *URL = [NSURL URLWithString:self.strurl];
    NSURLRequest * request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
}

- (void )webViewDidStartLoad:(UIWebView  *)webView
{
    NSLog(@"webViewDidStartLoad");
    if (_hud==nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    }
    
    
}
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    if (_hud) {
        [_hud hide:YES];
        _hud=nil;
    }
    //幸运大转盘
    JSContext *contentJS = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    __block XCWebViewController *blockSelf = self;

    contentJS[@"tokenExpried"] = ^() {

//        
        NSLog(@"js调用oc---------The End-------");
    };
    
    
    NSLog(@"webViewDidFinishLoad");
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError:%@", error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
