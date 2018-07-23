//
//  LCHPickView.h
//  CustomPickView
//
//  Created by 李聪会 on 15/5/5.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCHPickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
//确定按钮的回调
typedef void(^SureBlock)(NSInteger leftRow,NSInteger midRow,NSInteger rightRow,LCHPickView *pick);
//代理
@property (nonatomic,unsafe_unretained)id delegate;
//创建pickview
@property (nonatomic,retain)UIPickerView *pick;
//第0区的数组
@property (nonatomic,retain)NSArray *leftArr;
//第三个区的数组
@property (nonatomic,retain)NSArray *rightArr;
//第二个区的数组
@property (nonatomic,retain)NSArray *middleArr;
//选择第0区的哪一行
@property (nonatomic,unsafe_unretained)NSInteger selectRowInLeftComponent;
//选择中间的区
@property (nonatomic,unsafe_unretained)NSInteger selectRowInmiddleComponent;
//选择第3区的哪一行
@property (nonatomic,unsafe_unretained)NSInteger selectRowInRightComponent;
//灰色的背景
@property (nonatomic,strong) UIView *BgView;
//回调block
@property (nonatomic,strong) SureBlock  sureBtnBlock;
//展现视图
- (void)showInView;
//初始化方法：参数说明：titlte（中间label的显示文本）leftDateArray（左边数据源）rightArray：（右边数据源） delegate：（代理对象）
- (id)initWithTitle:(NSString*)title withleftArray:(NSArray*)leftDateArray withMiddleArr:(NSArray*)middleDateArr withRightArray:(NSArray*)rightArray  delegate:(id)delegate;
@end

//代理方法
@protocol LCHPikhViewDelegate <NSObject>

- (void)pickView:(LCHPickView*)pickView withLeftRow:(NSInteger)leftRow withRightRow:(NSInteger)rightRow withMiddleRow:(NSInteger)middleRow;

@end
