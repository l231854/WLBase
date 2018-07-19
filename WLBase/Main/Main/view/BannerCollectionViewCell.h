//
//  BannerCollectionViewCell.h
//  CommunityService
//
//  Created by 索晓晓 on 15/7/25.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HomeBannerModel;
@interface BannerCollectionViewCell : UICollectionViewCell


@property (nonatomic ,strong)HomeBannerModel *model;

@property (nonatomic ,strong)UIButton *image;

@end
