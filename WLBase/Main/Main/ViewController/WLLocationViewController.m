//
//  WLLocationViewController.m
//  WLBase
//
//  Created by 雷王 on 2018/7/18.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLLocationViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
@interface WLLocationViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,UITextFieldDelegate,BMKPoiSearchDelegate,UIGestureRecognizerDelegate>
{
    BOOL isFirsrtInstall;
    UITextField                              *searchTextField;

}
@property (nonatomic,strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKPoiSearch *searcher;
@property (nonatomic,strong) UIView *viewOfSearch;
@property (nonatomic,strong) UIView *viewOfBottom;

//当前所在城市
@property (nonatomic,strong) NSString *currentCity;

@end

@implementation WLLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"店铺介绍";
    isFirsrtInstall = YES;
    [self createUI];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}
#pragma mark --创建UI
- (void)createUI{
    self.mapView=[[BMKMapView alloc] init];
    self.mapView.frame=CGRectMake(0, 0, WIDTH, HEIGHT-130-XCStatusBar);
    self.mapView.delegate=self;
    self.mapView.isSelectedAnnotationViewFront = YES;

    [self.view addSubview:self.mapView];
    
    //修改定位方式，去除圆点周围蓝色圆圈
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc] init];
    [displayParam setIsRotateAngleValid:NO];
    [displayParam setIsAccuracyCircleShow:NO];
    [self.mapView updateLocationViewWithParam:displayParam];
    [self.mapView setZoomLevel:17.0];
    
    UIButton *btnOfRefresh = [[UIButton alloc] init];
    btnOfRefresh.frame = CGRectMake(5, self.mapView.frame.size.height-41, 36, 36);
    [btnOfRefresh setBackgroundImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [btnOfRefresh addTarget:self action:@selector(clickRefresh) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:btnOfRefresh];
    
    _locService = [[BMKLocationService alloc]init];
    _locService.desiredAccuracy = kCLLocationAccuracyBest;
    
    self.mapView.delegate = self;
    _locService.delegate = self;
    [self createSearchView];
    
    
    //设置搜索
    //初始化搜索对象 ，并设置代理
    _searcher =[[BMKPoiSearch alloc]init];
    _searcher.delegate = self;
    
    [self createBottomView];
 

}

#pragma mark -- 创建搜索view
-(void)createSearchView
{
    self.viewOfSearch=[[UIView alloc] init];
    self.viewOfSearch.frame=CGRectMake(0, 0, WIDTH, 50);
    self.viewOfSearch.backgroundColor=[UIColor grayColor];
    [self.view addSubview:self.viewOfSearch];
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(15, 10, WIDTH-100, 30);
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds=YES;
    view.layer.cornerRadius=4;
    [self.viewOfSearch addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(11.0/375*WIDTH, (view.frame.size.height-16/667.0*HEIGHT)/2.0, 16/667.0*HEIGHT, 16/667.0*HEIGHT);
    imageView.image = [UIImage imageNamed:@"input_icon_search"];
    [view addSubview:imageView];
    
    searchTextField=[[UITextField alloc] init];
    searchTextField.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+9.0/375*WIDTH, 0, view.frame.size.width-imageView.frame.size.width-9.0/375*WIDTH-90, view.frame.size.height);
    searchTextField.backgroundColor=[UIColor whiteColor];
    searchTextField.delegate=self;
    searchTextField.font=[UIFont systemFontOfSize:14.0/667*HEIGHT];
    searchTextField.placeholder=@"输入地址";
    [view addSubview:searchTextField];
    
    UIButton *btnOfSearch = [[UIButton alloc] init];
    btnOfSearch.frame=CGRectMake(WIDTH-60,(self.viewOfSearch.frame.size.height-40)/2.0, 40, 40);
    [btnOfSearch setTitle:@"搜索" forState:UIControlStateNormal];
    [btnOfSearch setTitleColor:UIColorFromRGB(0x333333, 1) forState:UIControlStateNormal];
    [btnOfSearch addTarget:self action:@selector(clickSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.viewOfSearch addSubview:btnOfSearch];
}

#pragma mark --创建下面的view
-(void)createBottomView
{
    self.viewOfBottom=[[UIView alloc] init];
    self.viewOfBottom.frame=CGRectMake(0, CGRectGetMaxY(self.mapView.frame), WIDTH, 130);
    self.viewOfBottom.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.viewOfBottom];
    CGFloat sep=15;
    CGFloat h=30;
    CGFloat seph=20;
    for (int i=0; i<2; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame =CGRectMake(sep,seph,WIDTH-sep*2, h);
        seph=seph+h+10;
        [btn setTitleColor:UIColorFromRGB(0x666666, 1) forState:UIControlStateNormal];
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=4;
        btn.tag=i+1;
        btn.titleLabel.textAlignment=NSTextAlignmentCenter;
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        btn.layer.borderWidth=1;
        btn.layer.borderColor=UIColorFromRGB(0x999999, 1).CGColor;
        if (i==0) {
            [btn setTitle:@"确定" forState:UIControlStateNormal];
        }
        else{
            [btn setTitle:@"取消" forState:UIControlStateNormal];

        }
        [btn addTarget:self action:@selector(clickBottomView:) forControlEvents:UIControlEventTouchUpInside];
        [self.viewOfBottom addSubview:btn];
    }
}
#pragma mark --底部view按钮点击事件
- (void)clickBottomView:(UIButton *)button
{
    NSInteger tag=button.tag;
    if (tag==1) {
        NSLog(@"点击确定");
    }else if (tag==2)
    {
        NSLog(@"点击取消");

    }
}
#pragma mark --点击刷新
- (void)clickRefresh
{
    [self.mapView setShowsUserLocation:NO];
    [_locService stopUserLocationService];
    isFirsrtInstall = YES;

    [_mapView setShowsUserLocation:YES];
    [_locService startUserLocationService];
}
#pragma mark --点击搜索
- (void)clickSearch
{
    [searchTextField resignFirstResponder];
    //请求参数类BMKCitySearchOption
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= self.currentCity;
//    citySearchOption.city= @"上海";

    citySearchOption.keyword = searchTextField.text;
    //发起城市内POI检索
    BOOL flag = [_searcher poiSearchInCity:citySearchOption];
    if(flag) {
        NSLog(@"城市内检索发送成功");
    }
    else {
        NSLog(@"城市内检索发送失败");
    }
}

#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode;
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < poiResult.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [poiResult.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
    } else if (errorCode == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}

//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

    _searcher.delegate = nil;
    _mapView.delegate=nil;
    [_mapView setShowsUserLocation:NO];
    [_locService stopUserLocationService];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView setShowsUserLocation:YES];
    [_locService startUserLocationService];
    
}
-(void)viewDidAppear:(BOOL)animated{
    __weak typeof(self) weakSelf = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

#pragma BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    if (isFirsrtInstall) {
        BMKMapStatus *staus = [[BMKMapStatus alloc] init];
        staus.fLevel = 17.0f;
        staus.targetGeoPt = userLocation.location.coordinate;
        [_mapView setMapStatus:staus withAnimation:YES];
        isFirsrtInstall = NO;
    }
    [_mapView updateLocationData:userLocation];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //将获得的所有信息显示到label上
            self.currentCity = placemark.name;
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            NSLog(@"city = %@", city);
            self.currentCity = city;
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
}
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
