//
//  BaseViewController.h
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNavBar.h"
#import "MBProgressHUD+ZH.h"

typedef void(^BaseFailLoadingBlock)(NSString *str,id param);

@interface BaseViewController : UIViewController

@property (nonatomic, retain) UIView* fakeNavView;
@property(nonatomic,retain) MyNavBar* myNavBar;

//存放
@property (nonatomic,strong) NSMutableArray *arrayOfTextfield;
@property (nonatomic,strong) UIImageView *viewOfGoToHome;

//取消所有textfeld相应
-(void)clickOther;
- (void)createBallOfGoToHome;
@property(nonatomic,strong)BaseFailLoadingBlock baseFailLoadingBlock;
-(void)buildBackBarButtonItemWhiteColor;

-(void)buildBackBarButtonItemGrayCoolr;

-(void)setTitleBarTitleStyle;

//设置导航栏不透明＋白色
-(void)setNavBarWhiteAndUntransparent;
//设置导航栏透明
-(void)setNaviBarTransParent;

//导航栏是否需要透明
@property (nonatomic) BOOL isNeedTrans;
//导航栏是否隐藏分割线
@property (nonatomic) BOOL isShowLine;

//视图是否不需要加入统计
@property (nonatomic) BOOL isDontNeedToCal;

@property (nonatomic) BOOL isNeedWhite;

@property (nonatomic) BOOL isCloseLeftPanBackGes;


@property (nonatomic, strong) UIAlertView *autoDismissAlert;

@property (strong,nonatomic) UIImageView *showImageViewbg;

@property (strong,nonatomic) UIImageView *showImageView;

@property (strong,nonatomic)UILabel *lbshowTip;


//服务器不支持表情输入发送
//判断字符串中是否含有表情
- (BOOL)stringContainsEmoji:(NSString *)string andMsg:(NSString *)msg;


-(void)backBtnClicked:(id)param;
-(void)cancel;


-(void)showAutoDismissAlert:(NSString*)title;

/**
 *  加载过程中的显示动画
 *
 *  @param isShow 是否显示
 */
- (void)showWaitLoadingView:(BOOL)isShow;

/**
 *  无数据情况下，显示的页面
 *
 *  @param isShow 是否显示
 *  @param title  显示的无数据提示
 */
- (void)showNoDataView:(BOOL)isShow title:(NSString *)title;
//- (void)showNoDataView:(BOOL)isShow title:(NSString *)title inView:(UIView *)view;

/**
 *  加载失败，显示的页面
 *
 *  @param isShow    是否显示
 *  @param failBlock 加载失败后的block
 */
- (void)showFailRequestView:(BOOL)isShow failBlock:(void(^)( id obj))failBlock;

-(void)setExtraCellLineHidden: (UITableView *)tableView;

- (long)getTimesReturnTime:(NSString*)time;
//- (BOOL)gettimeDiffence:(MyOrderItems*)item;
//- (BOOL)getDaytimeDiffence:(MyOrderItems*)item withIsquit:(BOOL)isQuit;



@end

