//
//  TabBarButton.m
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#import "TabBarButton.h"
#define XCTabBarButtonImageRatio 0.6
#import "UIView+Extension.h"

#define KTabNumBubbleFrame ( CGRectMake(self.frame.size.width*0.55, 2, width, height) )
@interface TabBarButton ()


@end

@implementation TabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView.contentMode = UIViewContentModeCenter;
        
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
        
        [self setTitleColor:WLTabbarNormalColor forState:UIControlStateNormal];
        [self setTitleColor:WLTabbarSelectedColor forState:UIControlStateSelected];

         }
    return self;
}



- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = self.width;
    CGFloat imageH = self.height * XCTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = self.height * XCTabBarButtonImageRatio;
    CGFloat titleW = self.width;
    CGFloat titleH = self.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    
    [self setTitle:item.title forState:UIControlStateNormal];
    
    [self setImage:item.image forState:UIControlStateNormal];
    
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
    
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    
}


- (void)removeFromSuperview
{
    [super removeFromSuperview];
    
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  当利用KVO监听到某个对象的属性改变了, 就会调用这个方法
 *
 *  @param keyPath 被改变的属性的名称
 *  @param object  被监听的那个对象
 *  @param change  存放者被改变属性的值
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    
    
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
}

- (void)setHighlighted:(BOOL)highlighted { }

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
