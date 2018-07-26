//
//  UIView+Badge.m
//  CommunityService
//
//  Created by 雷王 on 16/8/4.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "UIView+Badge.h"

#import <QuartzCore/QuartzCore.h>

#import <objc/runtime.h>

#define BadgeLabelKey @"__BadgeLabelKey"

#define DEGREES_TO_RADIANS(n)  (n/180.0f) *M_PI

@interface BadgeLabel : UIView

@property(nonatomic,copy)  NSString *text;
@property(nonatomic,strong) UIFont *font;
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic,strong) UIColor *bgColor;
@property(nonatomic) BOOL isCicle;
@end

@implementation BadgeLabel

-(id)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame:frame]) {
        
        self.text =@"";
        self.font =[UIFont systemFontOfSize:12.0f];
        self.textColor =[UIColor whiteColor];
        self.isCicle=NO;
        self.backgroundColor =[UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    CGFloat wdith =self.frame.size.width;
    CGFloat height =self.frame.size.height;
    if (self.isCicle) {
        // 获取图形上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
               /**
         *  画空心圆
         */
        CGRect bigRect = CGRectMake(1, 1, 8, 8);
        
        //设置空心圆的线条宽度
        CGContextSetLineWidth(ctx, 1);
        //以矩形bigRect为依据画一个圆
        CGContextAddEllipseInRect(ctx, bigRect);
        //填充当前绘画区域的颜色
        [UIColorFromRGB(0xff7f00, 1) set];

        //(如果是画圆会沿着矩形外围描画出指定宽度的（圆线）空心圆)/（根据上下文的内容渲染图层）
        CGContextStrokePath(ctx);
        UIBezierPath *bezierPath =[UIBezierPath bezierPath];
        [bezierPath addArcWithCenter:CGPointMake(5, 5) radius:7.0/2 startAngle:DEGREES_TO_RADIANS(366) endAngle:DEGREES_TO_RADIANS(0) clockwise:YES];
        [bezierPath closePath];
//        CGContextRef con = UIGraphicsGetCurrentContext();
//        CGContextSetFillColorWithColor(con, [UIColor redColor].CGColor);
            [[UIColor whiteColor] setFill];
            
        
        [bezierPath fill];

        return;
    }
    UIBezierPath *bezierPath =[UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(wdith/2, height/2) radius:wdith/2 startAngle:DEGREES_TO_RADIANS(366) endAngle:DEGREES_TO_RADIANS(0) clockwise:YES];
    [bezierPath closePath];
    CGContextRef con = UIGraphicsGetCurrentContext();
    if (self.bgColor) {
        CGContextSetFillColorWithColor(con, self.bgColor.CGColor);
        [self.bgColor setFill];
         }
    else{
    CGContextSetFillColorWithColor(con, [UIColor redColor].CGColor);
        [[UIColor redColor] setFill];

    }
    
    [bezierPath fill];
    
    if (IOS7) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.alignment =NSTextAlignmentCenter;
        
        NSArray *arrayObjs =[NSArray arrayWithObjects:self.textColor,self.font,paragraphStyle,nil];
        NSArray *arrayKeys =[NSArray arrayWithObjects:NSForegroundColorAttributeName,NSFontAttributeName,NSParagraphStyleAttributeName,nil];
        NSDictionary *dict=[NSDictionary dictionaryWithObjects:arrayObjs forKeys:arrayKeys];
        
        [self.text drawInRect:CGRectMake(0, 2, wdith, height) withAttributes:dict];
    }
    else{
        
        CGSize sizeText =[self.text sizeWithFont:self.font];
        [self.textColor set];
        [self.text drawInRect:CGRectMake((wdith -sizeText.width)/2, (height -sizeText.height)/2, sizeText.width, sizeText.height) withFont:self.font lineBreakMode:NSLineBreakByCharWrapping];
    }
    
}

-(void)setText:(NSString *)text{
    
    _text =[text copy];
    
    [self setNeedsDisplay];
}

@end

@implementation UIView (Badge)

-(void)setBadgeLabel:(BadgeLabel *)label{
    
    objc_setAssociatedObject(self, BadgeLabelKey, label,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BadgeLabel *)badgeLabel{
    
    return objc_getAssociatedObject(self, BadgeLabelKey);
}
-(void)setRedBadge:(BOOL)flag isInt:(BOOL)isint
{
    if (flag) {
//    BadgeLabel *badgeLabel =(BadgeLabel *)[self badgeLabel];
        BadgeLabel *badgeLabel;

    CGFloat height = 15.0;
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)self;
        if (btn.titleLabel.text.length >0) {
            height =  4.0/btn.titleLabel.text.length * 15.0;

        }
        else
        {
            badgeLabel =[[BadgeLabel alloc] initWithFrame:CGRectMake(self.frame.size.width-height, 6, 8, 8)];

        }

    }
        
        BOOL flag = YES;
        for (UIView *view in [self subviews]) {
            if ([view isKindOfClass:[BadgeLabel class]]) {
                flag =NO;
            }
        }
        if (flag) {
            if (isint) {
                int hh = self.frame.size.width-height;
                badgeLabel =[[BadgeLabel alloc] initWithFrame:CGRectMake(hh, 6, 8, 8)];
 
            }
            else{
            badgeLabel =[[BadgeLabel alloc] initWithFrame:CGRectMake(self.frame.size.width-height, 6, 8, 8)];
            }

            [self setBadgeLabel:badgeLabel];
            
            
            [self addSubview:badgeLabel];
 
        }
       }
    else{
        for (UIView *view in [self subviews]) {
            if ([view isKindOfClass:[BadgeLabel class]]) {
                BadgeLabel *lab = (BadgeLabel *)view;
                [lab removeFromSuperview];
            }
        }
    }
    
}

-(void)setBadge:(NSString *)badgeString{
    BadgeLabel *badgeLabel =(BadgeLabel *)[self badgeLabel];
    if (badgeString ==nil || [badgeString isEqualToString:@""] || [badgeString isEqualToString:@"0"]) {
        //如果badgeString 为nil、空字符串、0 ，则不显示，直接返回
        [badgeLabel removeFromSuperview];
        return;
    }
    if (badgeLabel ==nil || ![badgeLabel isKindOfClass:[BadgeLabel class]]) {
        badgeLabel =[[BadgeLabel alloc] initWithFrame:CGRectMake(self.frame.size.width -12, 0, 16, 16)];
        [self setBadgeLabel:badgeLabel];
    }
    if ([badgeString integerValue] >99 && ![badgeString isEqualToString:@""]) {
        badgeString =@"99+";
        [badgeLabel setFont:[UIFont systemFontOfSize:8.0f]];
        
    }
    badgeLabel.text =badgeString;
    
    [self addSubview:badgeLabel];
}
-(void)setBadge:(NSString *)badgeString andColor:(UIColor *)color andTextColor:(UIColor *)textColor andRadius:(CGFloat)r{
    BadgeLabel *badgeLabel =(BadgeLabel *)[self badgeLabel];
    if (badgeString ==nil || [badgeString isEqualToString:@""] || [badgeString isEqualToString:@"0"]) {
        //如果badgeString 为nil、空字符串、0 ，则不显示，直接返回
        [badgeLabel removeFromSuperview];
        return;
    }
    if (badgeLabel ==nil || ![badgeLabel isKindOfClass:[BadgeLabel class]]) {
        badgeLabel =[[BadgeLabel alloc] initWithFrame:CGRectMake(self.frame.size.width -r+10, -2, r, r)];
        [badgeLabel setFont:[UIFont systemFontOfSize:14.0f]];

        [self setBadgeLabel:badgeLabel];
    }
    if ([badgeString integerValue] >99 && ![badgeString isEqualToString:@""]) {
        badgeString =@"99+";
        [badgeLabel setFont:[UIFont systemFontOfSize:8.0f]];
        
    }
    badgeLabel.text =badgeString;
    badgeLabel.textColor=textColor;
    badgeLabel.bgColor =color;
    [self addSubview:badgeLabel];
}

-(void)setBadgeandColor:(UIColor *)color
{
    BadgeLabel *badgeLabel =(BadgeLabel *)[self badgeLabel];
    if (badgeLabel ==nil || ![badgeLabel isKindOfClass:[BadgeLabel class]]) {
        badgeLabel =[[BadgeLabel alloc] initWithFrame:CGRectMake(self.frame.size.width-1, 1, 10, 10)];

        [self setBadgeLabel:badgeLabel];
    }
     badgeLabel.bgColor =color;
    badgeLabel.isCicle=YES;
    [self addSubview:badgeLabel];

}
-(void)setNewBadge:(NSString *)badgeString
{
    UILabel *lbOfBall = [[UILabel alloc] init];
    lbOfBall.frame=CGRectMake(self.frame.size.width-18, 0, 20, 20);
    lbOfBall.backgroundColor=WLORANGColor;
    lbOfBall.layer.masksToBounds=YES;
//    lbOfBall.layer.borderWidth=1.0;
    lbOfBall.layer.cornerRadius=lbOfBall.frame.size.width/2.0;
//    lbOfBall.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    lbOfBall.textColor=[UIColor whiteColor];
    if (badgeString.length==1) {
        lbOfBall.font=[UIFont systemFontOfSize:14];
    }
    else{
        if ([badgeString intValue]>99) {
            badgeString=@"99";
        }
        lbOfBall.font=[UIFont systemFontOfSize:12];

    }
    lbOfBall.textAlignment=NSTextAlignmentCenter;
    lbOfBall.text=badgeString;
    [self addSubview:lbOfBall];
    
}
-(void)setNew2Badge:(NSString *)badgeString
{
    UILabel *lbOfBall = [[UILabel alloc] init];
    lbOfBall.frame=CGRectMake(self.frame.size.width-18, -3, 20, 20);
    lbOfBall.backgroundColor=[UIColor redColor];
    lbOfBall.layer.masksToBounds=YES;
    //    lbOfBall.layer.borderWidth=1.0;
    lbOfBall.layer.cornerRadius=lbOfBall.frame.size.width/2.0;
    //    lbOfBall.layer.borderColor=UIColorFromRGB(0xBBBBBB, 1).CGColor;
    lbOfBall.textColor=[UIColor whiteColor];
    if (badgeString.length==1) {
        lbOfBall.font=[UIFont systemFontOfSize:14];
    }
    else{
        if ([badgeString intValue]>99) {
            badgeString=@"99";
        }
        lbOfBall.font=[UIFont systemFontOfSize:12];
        
    }
    lbOfBall.textAlignment=NSTextAlignmentCenter;
    lbOfBall.text=badgeString;
    [self addSubview:lbOfBall];
    
}

@end
