//
//  BannerView.h
//  bannerView
//
//  Created by kang zhang on 15/5/4.
//  Copyright (c) 2015年 zhk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBannerModel.h"
#import "DynamicForwardBtn.h"
#import "XCPageControl.h"
@class BannerView;
@protocol BannerViewProtocol <NSObject>


@optional
-(void)selectedView:(BannerView *)view andIndex:(NSNumber *)integer;

@end

@interface BannerView : UIView

//滚动的视图
@property (nonatomic,strong) UICollectionView* collectionView;

//显示的pageConrol
@property (nonatomic,strong) UIPageControl *pageConrol;
//@property (nonatomic,strong) XCPageControl *pageConrol;

@property (nonatomic,strong)  NSMutableArray* imageArray;//model array


@property (nonatomic,strong)  NSString *imageSource;//model array


@property (nonatomic,weak) UIViewController *controller;
@property (nonatomic, assign) id<BannerViewProtocol>delegate;

@property(nonatomic, weak)UIViewController *motherVC;       //容器视图

//定时器时间
@property (nonatomic, assign) NSTimeInterval timerTimer;

//以图片形式初始化
-(instancetype) initWithFrame:(CGRect)frame andArray:(NSArray *)imageArray;


-(instancetype)initWithFrame:(CGRect)frame andDataOfHomePageMedel:(NSArray *)homeBannerDataArray withViewController:(UIViewController*)viewController isNeedSeparator:(BOOL)isNeedSeparator;

//开始计时器
-(void)begainTimer;

//停止计时器
-(void)stopTimer;

//获取banner的image btn, 用于缩放
-(UIButton*)imageBtnWithCurrentFocus;


@end
