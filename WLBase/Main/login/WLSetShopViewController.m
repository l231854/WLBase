//
//  WLSetShopViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/21.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLSetShopViewController.h"

@interface WLSetShopViewController ()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UITextView *textView;

@end

@implementation WLSetShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title=@"开店小助手";
    [self createUI];
}
#pragma mark --创建UI
- (void)createUI{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame=CGRectMake(0, 0, WIDTH, WLsize(514.0));
    self.imageView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:self.imageView];
    self.textView=[[UITextView alloc] init];
    self.textView.frame=CGRectMake(0, CGRectGetMaxY(self.imageView.frame), WIDTH, WLsize(77.0));
    self.textView.text=@"图文并茂";
    [self.view addSubview:self.textView];
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
