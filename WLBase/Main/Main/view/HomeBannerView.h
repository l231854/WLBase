//
//  HomeBannerView.h
//  WLBase
//
//  Created by 雷王 on 2018/6/2.
//  Copyright © 2018年 WL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeBannerModel;
@interface HomeBannerView : UIView
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImageView *imageViewOfDelet;

@property (nonatomic,strong) UILabel *lbOfTitle;
@property (nonatomic,strong) DynamicForwardBtn       *entranceBtn;
@property (nonatomic,copy) void (^clickDelet)(NSString *p);

+(HomeBannerView *)initWithFrame:(CGRect )frame andModel:(HomeBannerModel *)Model viewController:(UIViewController*)viewController;

@end
