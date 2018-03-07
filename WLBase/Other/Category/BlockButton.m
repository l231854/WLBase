//
//  BlockButton.m
//  WLBase
//
//  Created by 雷王 on 2018/3/5.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "BlockButton.h"
#import <QuartzCore/QuartzCore.h>//这里要注意，如果想使用UIButton的layer属性更改button样式，要添加QuartzCore.framewor并且在头文件导入。
@implementation BlockButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //        UIImage* img = [[UIImage imageNamed:@"normal_btn_focus"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        //        [self setBackgroundImage:img forState:UIControlStateHighlighted];
        //        self.layer.masksToBounds = YES;
        
        //        //先移除所有其他click事件
        //        [self removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //        self.longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        //        [self addGestureRecognizer:self.longPressGes];
    }
    return self;
}

//-(void)longPressAction:(id)sender
//{
//    [self removeGestureRecognizer:self.longPressGes];
//
//    if (_longPressBlock)
//    {
//        _longPressBlock(self);
//    }
//
//    [self addGestureRecognizer:self.longPressGes];
//}

- (void)touchAction:(id)sender
{
    if (_block)
    {
        _block(self);
    }
}

@end


