//
//  MyNavBar.m
//  WLBase
//
//  Created by 雷王 on 2018/3/5.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "MyNavBar.h"

@implementation MyNavBar
- (void)hideLineOfNavtionBar
{
    UIView* sepa = [self.overlay viewWithTag:SeperatorLineTag];
    if ( sepa != nil )
    {
        sepa.hidden = YES;
    }
    
    if ([self respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list = self.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)obj;
                imageView.hidden = YES;
            }
        }
    }
}
- (void)showLineOfNavtionBar
{
    if ([self respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list = self.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)obj;
                imageView.image = nil;
                //imageView.backgroundColor = [UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1.0];
                imageView.hidden = NO;
            }
        }
    }
}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 25, 30, 30)];
        // [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [self.backBtn setImage:[UIImage imageNamed:@"left_arrow"] forState:UIControlStateNormal];
        [self.backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        // self.backBtn.backgroundColor = [UIColor redColor];
        [self addSubview:self.backBtn];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.center = CGPointMake(WIDTH/2,20+44/2);
        self.titleLabel.bounds = CGRectMake(0, 0, 200, 30);
        self.titleLabel.textColor = UIColorFromRGB(0x333333, 1.0);
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        self.rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 60 ,25,40 ,30)];
        //[self.rightBtn setTitle:@"下一步" forState:UIControlStateNormal];
        //        [self.rightBtn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self addSubview:self.rightBtn];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
