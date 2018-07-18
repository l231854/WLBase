//
//  UIIMage+Empress.m
//  CommunityService
//
//  Created by VincentDeng on 15/6/22.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import "UIIMage+Empress.h"

@implementation UIImage(UIIMage_Empress)

-(UIImage*)getEmpressImge
{
    
  
#ifdef KSupportWebp//如果支持webp, 压缩比降低
    //压缩图片 //按照最大iPhone6 最大分辨率的3倍压缩上传 (1)
    CGFloat empressScale = /*WIDTH*/414 / (double)self.size.width * 3;
    if (empressScale<1) {
        UIImage *newImage = [self imageWithImageSimple:self scaledToSize:CGSizeMake(self.size.width*empressScale, self.size.height*empressScale)];
        
        NSData *ImgData = UIImageJPEGRepresentation(newImage, 0.5);
        
        CGFloat me = ImgData.length/1024.0/1024;
        NSLog(@"meLast------%.4f",me);
        UIImage *resultImg = [[UIImage alloc] initWithData:ImgData];
        return resultImg;//TODO
    }
#else
    //压缩图片 //按照最大iPhone6 最大分辨率的2倍压缩上传 (0.8)
    CGFloat empressScale = /*WIDTH*/414 / (double)self.size.width *2;
    if (empressScale<1) {
        
        UIImage *newImage = [self imageWithImageSimple:self scaledToSize:CGSizeMake(self.size.width*empressScale, self.size.height*empressScale)];
        NSData *ImgData = UIImageJPEGRepresentation(newImage, 0.5);
        UIImage *resultImg = [[UIImage alloc] initWithData:ImgData];
        return resultImg;//TODO
    }
#endif
    return self;
}

//压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    CGFloat meBefore = UIImageJPEGRepresentation(image, 1.0).length/1024.0/1024;
    NSLog(@"meBefore-------%.4f",meBefore);
    //  创建一个图形上下文形象
    UIGraphicsBeginImageContext(newSize);
    
    // new size  告诉旧图片画在这个新的环境,新的所需的大小
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    //  从上下文的新形象
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    NSData *ImgData = UIImageJPEGRepresentation(newImage, 1.0);
    CGFloat meAfter = ImgData.length/1024.0/1024;
    NSLog(@"meAfter-------%.4f",meAfter);

    //  结束的上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
