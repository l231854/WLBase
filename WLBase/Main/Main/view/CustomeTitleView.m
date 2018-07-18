//
//  CustomeTitleView.m
//  WLBase
//
//  Created by 雷王 on 2018/3/7.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "CustomeTitleView.h"

@implementation CustomeTitleView
// 如果这个没有调用父类的方法可以不用写该方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
// 这个重写方法为重点
- (void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(0, 0, self.superview.bounds.size.width,         self.superview.bounds.size.height)];
}



@end
