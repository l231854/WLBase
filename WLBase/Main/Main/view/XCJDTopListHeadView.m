//
//  XCJDTopListHeadView.m
//  CommunityService
//
//  Created by 雷王 on 2017/9/11.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "XCJDTopListHeadView.h"
#import "UIView+Badge.h"
#import "HomeHeadTitleModel.h"
#define KCount1 4
#define Kcount2 5
#define SelectColor      [UIColor blackColor]
#define NormalColor      [UIColor grayColor]
#define SelectLineColor      [UIColor orangeColor]
#define KBallWidth 10
@interface XCJDTopListHeadView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollview;

@end


@implementation XCJDTopListHeadView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.selectIndex = 1;
    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    self.scrollview = [[UIScrollView alloc] init];
    self.scrollview.frame = self.bounds;
    CGFloat width = WIDTH/self.count;
    self.scrollview.contentSize = CGSizeMake(width*self.arrayOfData.count, 0);
    
    self.scrollview.bounces = NO;
    
    self.scrollview.showsHorizontalScrollIndicator = NO;
    
    self.scrollview.showsVerticalScrollIndicator = NO;
    
//    self.scrollview.backgroundColor = UIColorFromRGB(0xf4f4f4, 1.0);
    self.scrollview.backgroundColor = [UIColor whiteColor];

    self.scrollview.delegate = self;
    
    [self addSubview:self.scrollview];
    
    
    
    for (int i = 0; i < self.arrayOfData.count; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(i*width, 0, width, self.frame.size.height);
        view.userInteractionEnabled = YES;
        view.tag = i+1;
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCategory:)];
        [view addGestureRecognizer:ges];
        [self.scrollview addSubview:view];
        
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(0, 0, width, self.frame.size.height-2);
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        HomeHeadTitleModel *info = [self.arrayOfData objectAtIndex:i];
        [button setTitle:info.title forState:UIControlStateNormal];
        button.tag = i+1;
        [button setTitleColor:NormalColor forState:UIControlStateNormal];
        button.userInteractionEnabled =NO;
        
        [button setRedBadge:NO isInt:NO];
        
        //        [button addTarget:self action:@selector(clickCategory:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        UILabel *lb = [[UILabel alloc] init];
//        lb.frame = CGRectMake(5.0/375*WIDTH, CGRectGetMaxY(button.frame)-1, width-10.0/375*WIDTH, 2);
        lb.frame = CGRectMake((width-KBallWidth)/2.0, CGRectGetMaxY(button.frame)-15, KBallWidth, KBallWidth);
        lb.layer.masksToBounds=YES;
        lb.layer.cornerRadius=KBallWidth/2.0;
        lb.backgroundColor = [UIColor whiteColor];
        [view addSubview:lb];
        if (i==self.selectIndex-1) {
            [button setTitleColor:SelectColor forState:UIControlStateNormal];
            lb.backgroundColor = SelectLineColor;
            
        }
//        if (self.selectIndex >4 ) {
//            if (self.selectIndex == self.arrayOfData.count) {
//                [self.scrollview setContentOffset:CGPointMake((WIDTH * (self.selectIndex-Kcount2))/5, 0) animated:NO];
//
//            }
//            else{
//                [self.scrollview setContentOffset:CGPointMake((WIDTH * (self.selectIndex-KCount1))/5, 0) animated:NO];
//
//            }
//        }
//        else
//        {
//            [self.scrollview setContentOffset:CGPointMake(0, 0) animated:NO];
//
//        }

    }
//    UILabel *lbOfline2 = [[UILabel alloc] init];
//    lbOfline2.frame = CGRectMake(0, 0, width*self.arrayOfData.count, 1.0f);
//    lbOfline2.backgroundColor = KSeparatorLineColor;
//    [self.scrollview addSubview:lbOfline2];
    
//    UILabel *lbOfline1 = [[UILabel alloc] init];
//
////    lbOfline1.frame = CGRectMake(0, self.bounds.size.height -0.5, width*self.arrayOfData.count, 1.0f/2.0);
//    lbOfline1.frame = CGRectMake(0, self.bounds.size.height -1, width*self.arrayOfData.count, 1.0f);
//
//    lbOfline1.backgroundColor = KSeparatorLineColor;
//    [self.scrollview addSubview:lbOfline1];
    
}


- (void)clickCategory:(UIGestureRecognizer *)sender
{
    
    UIView *oldView = (UIView *)[self.scrollview viewWithTag:self.selectIndex];
    for (UIView *obj in [oldView subviews]) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            [btn setTitleColor:NormalColor forState:UIControlStateNormal];
            
            
        }
        else if ([obj isKindOfClass:[UILabel class]])
        {
            UILabel *lb = (UILabel *)obj;
            lb.backgroundColor =[UIColor whiteColor];
            
        }
    }
    
    UIView *view = [sender view];
    self.selectIndex = view.tag;
    
//    if (self.selectIndex >=4 ) {
//        if (self.selectIndex == self.arrayOfData.count) {
//            [self.scrollview setContentOffset:CGPointMake((WIDTH * (self.selectIndex-Kcount2))/4.5, 0) animated:NO];
//            
//        }
//        else{
//            
//            [self.scrollview setContentOffset:CGPointMake((WIDTH * (self.selectIndex-KCount1))/4.5, 0) animated:NO];
//        }
//    }
//    else
//    {
//        [self.scrollview setContentOffset:CGPointMake(0, 0) animated:NO];
//        
//    }

    
    for (UIView *obj in [view subviews]) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            [btn setTitleColor:SelectColor forState:UIControlStateNormal];
            
            [btn setRedBadge:NO isInt:NO];
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"newType"]];
            
            if ([array isKindOfClass:[NSMutableArray class]]) {
                
                
                if (array != nil && array.count>0) {
                    NSString *strtype = [NSString stringWithFormat:@"%ld",btn.tag];
                    [array removeObject:strtype];
                    
                    if (array == nil || array.count==0) {
                        
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"newType"];
//                        [[NSNotificationCenter defaultCenter] postNotificationName:KNewTopicUnReadNotification object:nil userInfo:@{@"hasBlockNewNote": @"0"}];
                        
                    }
                    else{
                        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"newType"];
                    }
                    
                }
            }
        }
        else if ([obj isKindOfClass:[UILabel class]])
        {
            UILabel *lb = (UILabel *)obj;
            lb.backgroundColor = SelectLineColor;
            
        }
    }
  if ([self clickCategory]) {
        [self clickCategory]([self.arrayOfData objectAtIndex:view.tag -1],self.selectIndex);
    }
}


- (void)handleSwipForm:(BOOL)flag
{
    NSInteger te;
    if (flag) {
        te= -1;
    }
    else{
        te = 1;
    }
    for (UIView *oldView in self.scrollview.subviews) {
        
        
        for (UIView *obj in [oldView subviews]) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)obj;
                [btn setTitleColor:UIColorFromRGB(0x333333, 1) forState:UIControlStateNormal];
            }
            else if ([obj isKindOfClass:[UILabel class]])
            {
                UILabel *lb = (UILabel *)obj;
                lb.backgroundColor =[UIColor whiteColor];
                
            }
        }
    }
    UIView *view = (UIView *)[self.scrollview viewWithTag:self.selectIndex];
    
    for (UIView *obj in [view subviews]) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            [btn setTitleColor:DEFAULT_BUTTON_COLOR forState:UIControlStateNormal];
            [btn setRedBadge:NO isInt:NO];
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"newType"]];
            if ([array isKindOfClass:[NSMutableArray class]]) {
                if (array != nil &&array.count>0) {
                    [array removeObject:[NSString stringWithFormat:@"%ld",btn.tag]];
                    if (array == nil || array.count==0) {
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"newType"];
//                        [[NSNotificationCenter defaultCenter] postNotificationName:KNewTopicUnReadNotification object:nil userInfo:@{@"hasBlockNewNote": @"0"}];
                        
                    }
                    else{
                        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"newType"];
                    }
                    
                }
            }
        }
        else if ([obj isKindOfClass:[UILabel class]])
        {
            UILabel *lb = (UILabel *)obj;
            lb.backgroundColor = DEFAULT_BUTTON_COLOR;
            
        }
    }
    if (self.selectIndex >=4 ) {
        if (self.selectIndex == self.arrayOfData.count) {
            [self.scrollview setContentOffset:CGPointMake((WIDTH * (self.selectIndex-Kcount2))/4.5, 0) animated:YES];
        }
        else{
            
            [self.scrollview setContentOffset:CGPointMake((WIDTH * (self.selectIndex-KCount1))/4.5, 0) animated:YES];
        }
    }
    else
    {
        [self.scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }
    if ([self clickCategory]) {
        [self clickCategory]([self.arrayOfData objectAtIndex:self.selectIndex -1],self.selectIndex);
    }
}

@end
