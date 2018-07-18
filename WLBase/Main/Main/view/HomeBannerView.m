//
//  HomeBannerView.m
//  WLBase
//
//  Created by 雷王 on 2018/6/2.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "HomeBannerView.h"
#import "HomeBannerModel.h"
#define KImageWidth 60.0/375*WIDTH
@implementation HomeBannerView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
    
}
+(HomeBannerView *)initWithFrame:(CGRect )frame andModel:(HomeBannerModel *)Model viewController:(UIViewController*)viewController
{
    HomeBannerView *view = [[HomeBannerView alloc] initWithFrame:frame];
    view.backgroundColor =[UIColor whiteColor];
    view.imageView = [[UIImageView alloc] init];
    //    view.imageView.frame = CGRectMake((frame.size.width-44.0/375*WIDTH)/2, 10.0/667*HEIGHT, 44.0/375*WIDTH,44.0/375*WIDTH);
    view.imageView.frame = CGRectMake((frame.size.width-KImageWidth)/2, (frame.size.height-KImageWidth)/2.0, KImageWidth,KImageWidth);
    
//    [view.imageView sd_setImageWithURL:[NSURL URLWithString:Model.headImageUrl] placeholderImage:[UIImage imageNamed:@"pic_null"]];
    [view.imageView setImage:[UIImage imageNamed:Model.headImageUrl]];

    [view addSubview:view.imageView];
    
    view.lbOfTitle = [[UILabel alloc] init];
    view.lbOfTitle.frame=CGRectMake(0, CGRectGetMaxY(view.imageView.frame)+7.0/375*WIDTH, view.frame.size.width, view.frame.size.height-CGRectGetMaxY(view.imageView.frame)-7.0/375*WIDTH);
    view.lbOfTitle.font = [UIFont systemFontOfSize:14/375.0*WIDTH];
    view.lbOfTitle.textColor = UIColorFromRGB(0x666666, 1);
    view.lbOfTitle.text = Model.title;
    if ([Model.title isEqualToString:@"更多"]) {
        view.lbOfTitle.hidden=YES;
//        view.imageView.frame = CGRectMake((frame.size.width-KImageWidth)/2, (frame.size.height-KImageWidth)/2.0+(view.lbOfTitle.frame.size.height+7)/2.0, KImageWidth,KImageWidth);

    }
    else{
        view.lbOfTitle.hidden=NO;

    }
    view.lbOfTitle.textAlignment=NSTextAlignmentCenter;
    [view addSubview:view.lbOfTitle];
   
    view.entranceBtn= [[DynamicForwardBtn alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) viewcontroller:viewController dataSource:Model isNeedFocusImg:YES];
    __weak typeof(view)weakSelf = view;
    view.entranceBtn.longProgress = ^{
        weakSelf.imageViewOfDelet.hidden=NO;
    };
    [view addSubview:view.entranceBtn];
    view.imageViewOfDelet = [[UIImageView alloc] init];
    UIImage *image =[UIImage imageNamed:@"deleate"];
    CGFloat ww=20;
    view.imageViewOfDelet.image=image;
    view.imageViewOfDelet.frame=CGRectMake(CGRectGetMaxX(view.imageView.frame)-ww/2.0,view.imageView.frame.origin.y-ww/2.0, ww, ww);
    view.imageViewOfDelet.hidden=YES;
    view.imageViewOfDelet.tag=[Model.processId integerValue];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(clickDelete:)];
    view.imageViewOfDelet.userInteractionEnabled=YES;
    [view.imageViewOfDelet addGestureRecognizer:ges];
    [view addSubview:view.imageViewOfDelet];
    

    return view;
}
#pragma mark - 点击删除
- (void)clickDelete:(UIGestureRecognizer *)ges
{
    NSString *processId = [NSString stringWithFormat:@"%ld",[ges view].tag];
    if ([self clickDelet]) {
        [self clickDelet](processId);
    }
}


@end
