//
//  BannerView.m
//  bannerView
//
//  Created by kang zhang on 15/5/4.
//  Copyright (c) 2015年 zhk. All rights reserved.
//

#import "BannerView.h"
#import "BannerCollectionViewCell.h"
#define BannerCollectionViewCellID @"bannerCollectionCell"
#define kImageArrayCount  ( 10000 ) //左右各 5000 张可以循环

#define KBannerCollectionCellTag 0x0000789

@interface BannerView ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    //滚动的scrollView;
    UIScrollView         *_scrollView;
    

    

    
    //当前选中的index
    NSInteger            _currenIndex;
    
    //定时器
    NSTimer              *_timer;
    //是否显示pageController
    BOOL                  _isShowPageController;
    //
    

    NSMutableArray       *_urlArray;
    CGRect               _currentViewFrame;
    NSMutableArray       *_homeDataArray;;

}



@end

@implementation BannerView

-(instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)imageArray
{
    if (self = [super initWithFrame:frame]) {
        //轮播时图片需要在最前插入最后一张，在最后插入最前一张
        _imageArray = [[NSMutableArray alloc] initWithArray:imageArray];
        [_imageArray addObject:[imageArray firstObject]];
        [_imageArray insertObject:[imageArray lastObject] atIndex:0];
        _currentViewFrame = frame;
        
        _isShowPageController = [_imageArray count]==1 ? 0: 1;
        
        [self createBannerView];
    }
    return self;
}

#pragma mark ------------
#pragma mark ------------创建scrollView和上面的控件

-(void)createBannerView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _currentViewFrame.size.width, _currentViewFrame.size.height)];
    [_scrollView setPagingEnabled:YES];
    for (int i = 0; i < [_imageArray count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + i * _currentViewFrame.size.width, 0, _currentViewFrame.size.width, _currentViewFrame.size.height)];
        imageView.contentMode =  UIViewContentModeScaleAspectFill;
        [imageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        [imageView setTag:10000 + i];
        if ([[_imageArray objectAtIndex:i] isKindOfClass:[UIImage class]]) {
            [imageView setImage:[_imageArray objectAtIndex:i]];
        }
        else{
            //loadimagewith URL
        }
        [_scrollView addSubview:imageView];
    }
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    _scrollView.delegate = self;
    _currenIndex = 1;
    [_scrollView setContentOffset:CGPointMake(_currentViewFrame.size.width, 0)];
    [_scrollView setContentSize:CGSizeMake(_currentViewFrame.size.width * [_imageArray count], _currentViewFrame.size.height)];
   
    [self addSubview:_scrollView];
    
    if (_isShowPageController) {
        _pageConrol = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _currentViewFrame.size.height- 25, _currentViewFrame.size.width, 20)];
//        for (HomeBannerModel *dataModel in _imageArray) {
//            if ([dataModel.isTopBanner isEqualToString:@"1"]) {
//                _pageConrol = [[XCPageControl alloc] initWithFrame:CGRectMake(0, _currentViewFrame.size.height- 20, _currentViewFrame.size.width, 20)];
//
//            }
//        }

        [_pageConrol setNumberOfPages:[_imageArray count] -2];
        [_pageConrol setPageIndicatorTintColor:[UIColor colorWithRed:226/255.0f green:226/255.0f blue:226/255.0f alpha:1.0]];
        [_pageConrol setCurrentPageIndicatorTintColor:[UIColor colorWithRed:255/255.0f green:115/255.0f blue:5/255.0f alpha:1.0]];
        [_pageConrol setCurrentPage:0];
        [self addSubview:_pageConrol];
    }

}

#pragma mark ---------------
#pragma mark --------------- 图片的点击事件
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    if ([_delegate respondsToSelector:@selector(selectedView:andIndex:)]) {
        NSInteger tmpIndex = imageView.tag - 10000;
        if (tmpIndex == 0) {
            [_delegate performSelector:@selector(selectedView:andIndex:) withObject:self withObject:[NSNumber numberWithInteger:[_imageArray count] - 3]];
        }
        else if (tmpIndex == ([_imageArray count] - 1))
        {
            [_delegate performSelector:@selector(selectedView:andIndex:) withObject:self withObject:[NSNumber numberWithInteger:0]];
        }
        else{
            [_delegate performSelector:@selector(selectedView:andIndex:) withObject:self withObject:[NSNumber numberWithInteger:(tmpIndex - 1)]];
        }
    }
}

#pragma mark -----------------
#pragma mark ----------------- scorllView的代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int pag = (_collectionView.contentOffset.x + 0.5 * _collectionView.frame.size.width)/_collectionView.frame.size.width;
    
    
    int currentPage = pag%[_imageArray count];
    _pageConrol.currentPage = currentPage;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_timer) {
        
        [self stopTimer];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_isShowPageController) {
        
        [self createTimer];
    }
}

#pragma mark -------------
#pragma mark -------------  开始定时器
-(void)begainTimer
{
    if (_imageArray.count>1) {
        [self createTimer];
    }
}


#pragma mark -------------
#pragma mark -------------  创建定时器
-(void)createTimer
{    if (_timer) {
        return;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(changeCollectionCurrentValue) userInfo:nil repeats:YES];
    [self timerBegain];
}
//添加事件循环
-(void)timerBegain
{
    //[_timer setFireDate:[NSDate distantPast]];
    
    [[NSRunLoop  currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
//停止计时器
- (void)stopTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

-(void)changeCurrentIndex
{
    NSLog(@"11111");
    if (_currenIndex == [_imageArray count] -2) {
        _currenIndex++;
       [UIView animateWithDuration:0.3 animations:^{
           
            _scrollView.contentOffset = CGPointMake(_currenIndex * _currentViewFrame.size.width, 0);
       } completion:^(BOOL finished) {
           _scrollView.contentOffset = CGPointMake(_currentViewFrame.size.width, 0);
           _currenIndex = 1;
           _pageConrol.currentPage = _currenIndex - 1;
       }];
    }
    else {
        _currenIndex ++ ;
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentOffset = CGPointMake(_currentViewFrame.size.width * _currenIndex, 0);
        } completion:^(BOOL finished) {
            
            _pageConrol.currentPage = _currenIndex - 1;
            
        }];
    }
}

- (void)changeCollectionCurrentValue
{
    //计算pagsControl
    NSInteger index = _collectionView.contentOffset.x/_collectionView.frame.size.width;
    index = (index+1) % ( kImageArrayCount * _imageArray.count );
    
    
    //显示的图片
    CGFloat fl = _collectionView.frame.size.width * index;
    [_collectionView setContentOffset:CGPointMake(fl, 0) animated:YES];
}

-(instancetype)initWithFrame:(CGRect)frame andUrlArray:(NSArray *)urlArray
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
//-------
-(instancetype)initWithFrame:(CGRect)frame andDataOfHomePageMedel:(NSArray *)homeBannerDataArray withViewController:(UIViewController*)viewController  isNeedSeparator:(BOOL)isNeedSeparator
{
    //3.1.3
//    for (HomeBannerModel *dataModel in homeBannerDataArray) {
//        dataModel.isBanner = @"1";
//    }

    if (self = [super initWithFrame:frame]) {
        _imageArray = [NSMutableArray arrayWithArray:homeBannerDataArray];

        _currentViewFrame = frame;
        self.controller = viewController;
        
        _isShowPageController = YES;
        if (_imageArray.count == 1) {
            _isShowPageController = NO;
        }
        
        [self createCollectionView];
        
        if (isNeedSeparator)
        {
            [self createSeparoatorLine];
        }
    }
    return self;
}
- (void)createCollectionView
{
    //创建collection
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsZero;
    
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _currentViewFrame.size.width, _currentViewFrame.size.height) collectionViewLayout:layout];
    layout.itemSize = CGSizeMake(_currentViewFrame.size.width, _currentViewFrame.size.height);
    
    [_collectionView registerClass:[BannerCollectionViewCell class] forCellWithReuseIdentifier:BannerCollectionViewCellID];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self  addSubview:_collectionView];
    

    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:kImageArrayCount* 0.5 *[_imageArray count] inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    _collectionView.pagingEnabled = YES;
    
    //创建pagecontrol
    if (_isShowPageController) {
        //        _pageConrol = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _currentViewFrame.size.height - 25.0f/2, _currentViewFrame.size.width, 13.0f/2)];
        _pageConrol = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _currentViewFrame.size.height - (_currentViewFrame.size.height/10.0*0.5>25.0f/2?_currentViewFrame.size.height/10.0*0.5:25.0f/2), _currentViewFrame.size.width, 13.0f/2)];
//        for (DataOfHomePageMedel *dataModel in _imageArray) {
//            if ([dataModel.isTopBanner isEqualToString:@"1"]) {
//                        _pageConrol = [[XCPageControl alloc] initWithFrame:CGRectMake(0, _currentViewFrame.size.height - 15.0f/2, _currentViewFrame.size.width, 13.0f/2)];
//
//            }
//        }


        [_pageConrol setNumberOfPages:[_imageArray count]];
        [_pageConrol setPageIndicatorTintColor:[UIColor colorWithRed:226/255.0f green:226/255.0f blue:226/255.0f alpha:1.0]];
        [_pageConrol setCurrentPageIndicatorTintColor:[UIColor colorWithRed:255/255.0f green:115/255.0f blue:5/255.0f alpha:1.0]];
        [_pageConrol setCurrentPage:0];
  
        [self addSubview:_pageConrol];
        
        [self begainTimer];
        
        _collectionView.scrollEnabled = YES;
        
    }else{
        
        _collectionView.scrollEnabled = NO;
        _pageConrol = nil;
    }
    
    _collectionView.clipsToBounds = NO;
}

-(void)createSeparoatorLine
{
    //seperator line above
    UIView* separatorLineAbove = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, KSeparatorLineHeight)];
    separatorLineAbove.backgroundColor = [UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1.0];
    [self addSubview:separatorLineAbove];
    
    //seperator line bottom
    UIView* separatorLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-KSeparatorLineHeight, WIDTH, KSeparatorLineHeight)];
    separatorLineBottom.backgroundColor = [UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1.0];
    [self addSubview:separatorLineBottom];
}

#pragma UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kImageArrayCount * (_imageArray.count);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BannerCollectionViewCellID forIndexPath:indexPath];
    NSInteger cellIndex = indexPath.item%_imageArray.count;
    cell.tag = cellIndex + KBannerCollectionCellTag;
    
    HomeBannerModel *dataModel = _imageArray[indexPath.item%_imageArray.count];
    cell.model = dataModel;
    cell.backgroundColor = UIColorFromRGB(0xefefefef, 1.0);
    
    DynamicForwardBtn *dyWardBtn = [[DynamicForwardBtn alloc] initWithFrame:cell.frame viewcontroller:self.controller dataSource:dataModel isNeedFocusImg:NO];
    if (_motherVC)
    {
        dyWardBtn.delegate = _motherVC;
    }
    if ([self.imageSource isEqualToString:@"1"]) {
        
    }
    else{
    [collectionView  addSubview:dyWardBtn];
    }
    
    return cell;
}

//获取banner的image btn, 用于缩放
-(UIButton*)imageBtnWithCurrentFocus
{
    BannerCollectionViewCell *cell = [self viewWithTag:self.pageConrol.currentPage + KBannerCollectionCellTag];
    return cell.image;
}


@end
