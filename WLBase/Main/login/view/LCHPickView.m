//
//  LCHPickView.m
//  CustomPickView
//
//  Created by 李聪会 on 15/5/5.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import "LCHPickView.h"
#import "AppDelegate.h"
@implementation LCHPickView
{
    CGRect rect;
    
    
}
#pragma mark------视图消失----------
- (void)dismissPickView:(id*)sender
{
   
    [UIView animateWithDuration:0.25 animations:^{
        self.BgView.hidden = YES;
        
        self.frame = CGRectMake(0, rect.origin.y, WIDTH, 216);
        // self.BgView.frame =CGRectMake(0, 667, 375, 667);
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark------确定按钮方法----------
- (void)sureBntClick:(UIButton*)sureBtn
{
    
    if ([self.delegate respondsToSelector:@selector(pickView:withLeftRow:withRightRow:withMiddleRow:)]) {
        
        [self.delegate pickView:self withLeftRow:_selectRowInLeftComponent withRightRow:_selectRowInRightComponent withMiddleRow:_selectRowInmiddleComponent];
        
        [self dismissPickView:nil];
        
    }
}
#pragma mark------视图出线----------
- (void)showInView
{
   
    [UIView animateWithDuration:0.25 animations:^{
        self.BgView.hidden = NO;
        
        self.frame = CGRectMake(0, rect.origin.y-216, WIDTH, 216);
        //self.BgView.frame =CGRectMake(0, 0, 375, 667);
        
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark------重写初始化方法----------
- (id)initWithTitle:(NSString*)title withleftArray:(NSArray*)leftDateArray withMiddleArr:(NSArray*)middleDateArr withRightArray:(NSArray*)rightArray  delegate:(id)delegate
{
    self = [super init];
    if (self) {
        self. delegate = delegate;
        self.frame = CGRectMake(0, HEIGHT, WIDTH, 216);
        CGRect frame = self.frame;
        rect = frame;
        self.leftArr = leftDateArray;
        self.rightArr = rightArray;
        self.middleArr =middleDateArr;
        self.backgroundColor = [UIColor redColor];
        float  height = 40;
        float  width  = 60;
        
        UIView *upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, height+10)];
        upView.backgroundColor = [UIColor whiteColor];
        
        UILabel *lbOfsep =[[UILabel alloc] init];
        lbOfsep.frame=CGRectMake(0, upView.frame.size.height-1.0,upView.frame.size.width, 1.0);
        lbOfsep.backgroundColor=WLSEPLBColor;
        [upView addSubview:lbOfsep];
        [self addSubview:upView];
        
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:UIColorFromInt(0, 118, 255, 1) forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelBtn setFrame:CGRectMake(0, 2, width, height)];
        [upView addSubview:cancelBtn];
        [cancelBtn addTarget:self action:@selector(dismissPickView:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setFrame:CGRectMake(frame.size.width-width,2, width, height)];
        [sureBtn setTitleColor:UIColorFromInt(0, 118, 255, 1) forState:UIControlStateNormal];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [upView addSubview:sureBtn];
        
        [sureBtn addTarget:self action:@selector(sureBntClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancelBtn.frame), 0, frame.size.width-2*width, height+4)];
        titleLabel.text = title;
        titleLabel.textColor = UIColorFromInt(51, 51, 51, 1);
        titleLabel.textAlignment =  NSTextAlignmentCenter ;
        [upView addSubview:titleLabel];
        
        _pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(upView.frame), frame.size.width, 166)];
        [_pick setBackgroundColor:[UIColor whiteColor]];
        _pick.delegate = self;
        _pick.dataSource = self;
        
        self.BgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        self.BgView.backgroundColor  =[UIColor blackColor];
        self.BgView.alpha = 0.4;
        self.BgView.hidden = YES;
        AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [app.window addSubview:self.BgView];
        [app.window addSubview:self];
         [self addSubview:_pick];
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPickView:)];
        gestureRecognizer.numberOfTapsRequired =1;
        gestureRecognizer.numberOfTouchesRequired = 1;
        [self.BgView addGestureRecognizer:gestureRecognizer];
        
    }
    return self;
}

#pragma mark------pickview代理----------
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.leftArr&&self.rightArr&&self.middleArr) {
        return 3;
    }else if (self.leftArr&&!self.rightArr&&self.middleArr)
    {
        return 2;
    }else
    {
        return 1;
    }
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    
    if (component==0) {
        return self.leftArr.count;
    }else if (component==1)
    {
        return self.middleArr.count;
    }else
    {
        return self.rightArr.count;
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    
    return 34.0;
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    //设置分割线的颜色
    
    for(UIView *singleLine in pickerView.subviews)
        
    {
        
        if (singleLine.frame.size.height < 1)
            
        {
            
            singleLine.backgroundColor = WLSEPLBColor;
            
        }
        
    }
    

    UIView *viewAll = [[UIView alloc] init];
    viewAll.frame=CGRectMake(0, 0, pickerView.bounds.size.width, 40);
    

    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColorFromInt(51, 51, 51, 1);
    label.font = [UIFont systemFontOfSize:18];
    label.frame = CGRectMake(0,(viewAll.frame.size.height-34)/2.0, pickerView.bounds.size.width, 34);
    [viewAll addSubview:label];
    if (component==0) {
        if (self.leftArr && self.leftArr.count > 0) {
            label.text = self.leftArr[row];
        }
        
    }else if (component==2)
    {
        if (self.rightArr && self.rightArr.count > 0) {
            label.text = self.rightArr[row];
        }
        //        return [self.rightArr objectAtIndex:row];
    }else
    {
        if (self.middleArr && self.middleArr.count > 0) {
            label.text = self.middleArr[row];
        }
        
    }
    
    return viewAll;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component==0) {
        _selectRowInLeftComponent = row;
    }else if (component==1)
    {
        _selectRowInmiddleComponent = row;

       
    }else
    {
         _selectRowInRightComponent = row;
    }
}/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
