//
//  UINavigationBar+Awesome.m
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import "UINavigationBar+Awesome.h"
#import <objc/runtime.h>


@implementation UINavigationBar (Awesome)
static char overlayKey;
static char emptyImageKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)emptyImage
{
    return objc_getAssociatedObject(self, &emptyImageKey);
}

- (void)setEmptyImage:(UIImage *)image
{
    objc_setAssociatedObject(self, &emptyImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
//    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    if (!self.overlay) {
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];

    }
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
        
        UIView* separatorLineWidth = [[UIView alloc] init];
        separatorLineWidth.frame = CGRectMake(0, self.bounds.size.height+20-1, WIDTH, 1);
        separatorLineWidth.backgroundColor = UIColorFromRGB(0xd9d9d9, 1.0) ;
        separatorLineWidth.tag = SeperatorLineTag;
    separatorLineWidth.hidden = YES;

        [self.overlay addSubview:separatorLineWidth];
//    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)lt_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)lt_setContentAlpha:(CGFloat)alpha
{
    if (!self.overlay) {
        [self lt_setBackgroundColor:self.barTintColor];
    }
    [self setAlpha:alpha forSubviewsOfView:self];
    if (alpha == 1) {
        if (!self.emptyImage) {
            self.emptyImage = [UIImage new];
        }
        self.backIndicatorImage = self.emptyImage;
    }
}

- (void)setAlpha:(CGFloat)alpha forSubviewsOfView:(UIView *)view
{
    for (UIView *subview in view.subviews) {
        if (subview == self.overlay
            ||
            [subview isKindOfClass:[UISegmentedControl class]]//titile view是UISegmentedControl不改变它的alpha
            )
        {
            continue;
        }
        subview.alpha = alpha;
        [self setAlpha:alpha forSubviewsOfView:subview];
    }
}

- (void)lt_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:nil];

//    [self.overlay removeFromSuperview];
//    self.overlay = nil;
}

- (void)hideLineOfNavtionBar
{
    //show horizontal separator line
    UIView* sepa = [self.overlay viewWithTag:SeperatorLineTag];
    if ( sepa != nil )
    {
        sepa.hidden = YES;
    }
    
    if ([self respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list = self.subviews;
//        UIView *view = (UIView *)[list objectAtIndex:0];
//        view.hidden = YES;
        Class backgroundClass = NSClassFromString(@"_UIBarBackground");
        for (UIView *view in list) {
            if ([view isKindOfClass:backgroundClass])
            {
                view.hidden = YES;
            }
        }

        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)obj;
                imageView.hidden = YES;
            }
        }
    }
}
- (void)showLineOfNavtionBar:(BOOL)isShow
{
    //show horizontal separator line
    UIView* sepa = [self.overlay viewWithTag:SeperatorLineTag];
    if ( sepa != nil )
    {
        sepa.hidden = isShow;
    }
    if ([self respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list = self.subviews;

        Class backgroundClass = NSClassFromString(@"_UIBarBackground");
        for (UIView *view in list) {
            if ([view isKindOfClass:backgroundClass])
            {
                view.hidden = NO;
            }
        }
        for (id obj in list) {
            if ([obj isKindOfClass:[UIView class]]) {
                UIView *view = (UIView *)obj;
                view.hidden = NO;
            }
//            else if ([obj isKindOfClass:[UIBarBackground ]])
        }
    }

   //    if ([self respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
//        NSArray *list = self.subviews;
//        for (id obj in list) {
//            if ([obj isKindOfClass:[UIImageView class]]) {
//                UIImageView *imageView = (UIImageView *)obj;
//                imageView.image = nil;
//                //imageView.backgroundColor = KSeparatorLineColor;// [UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1.0];
//                imageView.hidden = NO;
//            }
//        }
//    }
}
@end
