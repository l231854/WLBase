//
//  BannerCollectionViewCell.m
//  CommunityService
//
//  Created by 索晓晓 on 15/7/25.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import "BannerCollectionViewCell.h"
#import "HomeBannerModel.h"

@interface BannerCollectionViewCell ()



@property (nonatomic , strong)UIView *separatorLineAbove;


@property (nonatomic , strong)UIView *separatorLineBottom;

@end

@implementation BannerCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.image = [[UIButton alloc] init];
        self.image.tag = 0x123456789;
        self.image.userInteractionEnabled = YES;
        
        
        self.clipsToBounds = NO;
        
        [self.contentView addSubview:self.image];
        
        self.autoresizesSubviews = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.contentView.autoresizesSubviews = YES;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}


- (void)setModel:(HomeBannerModel *)model
{
    _model = model;
    
    //[self.image setImage:[UIImage imageNamed:@"pic_null"] forState:UIControlStateNormal];
    
//    self.image.autoresizesSubviews = YES;
//    self.image.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    __weak UIButton* weak_image = self.image;
    [[weak_image imageView] setContentMode:UIViewContentModeCenter];
    if (model.headImage.length>0&&model.headImage!=nil) {
        [self.image setImage:[UIImage imageNamed:model.headImage] forState:UIControlStateNormal];
    }
    else{
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.headImageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
    {
        //weak_image.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        if (!error)
        {
            //保存Image
//            model.headImage = image;
            
            //设置图片按比例填满
            weak_image.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            [[weak_image imageView] setContentMode:UIViewContentModeScaleAspectFill];
            weak_image.contentHorizontalAlignment= UIControlContentHorizontalAlignmentFill;
            weak_image.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
        }
    }];
    }
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    self.image.frame = self.bounds;
}
@end
