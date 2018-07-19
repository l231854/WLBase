//
//  XCPageControl.m
//  CommunityService
//
//  Created by 雷王 on 2018/4/25.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "XCPageControl.h"

@implementation XCPageControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
       
    }
    return self;
}
-(void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
//        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        UIView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGRect rect =subview.frame;
//        UIImage *image =[UIImage imageNamed:@"slider_icon_cur"];

        CGFloat ww=12;
        CGFloat hh = 2.2;
        subview.frame = CGRectMake(rect.origin.x,rect.origin.y, ww,hh);

            if (subviewIndex == currentPage){
                subview.layer.cornerRadius = 1;
                subview.layer.masksToBounds = YES;
            }
            else
            {
                subview.layer.cornerRadius = 1;
                subview.layer.masksToBounds = YES;
                
            }
       
    }
}

@end
