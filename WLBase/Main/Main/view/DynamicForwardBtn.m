//
//  DynamicForwardBtn.m
//  WLBase
//
//  Created by 雷王 on 2018/6/2.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "DynamicForwardBtn.h"
#import "HomeBannerModel.h"
#import "WLConsultViewController.h"
#import "WLHelperViewController.h"
@interface DynamicForwardBtn ()<UIAlertViewDelegate>

@property (nonatomic, weak) UIViewController* parentVC;

@property (nonatomic, strong) HomeBannerModel* dataSource;

@end

@implementation DynamicForwardBtn

- (instancetype)initWithFrame:(CGRect)frame viewcontroller:(UIViewController*)viewcontroller dataSource:(HomeBannerModel*)dataSource isNeedFocusImg:(BOOL)isNeedFocusImg
{
    if ( self = [super initWithFrame:frame] ) {
        
        self.parentVC = viewcontroller;
        self.dataSource = dataSource;
//        self.imageView = [[UIImageView alloc] init];
//        UIImage *image =[UIImage imageNamed:@"deleate"];
//        self.imageView.image=image;
//        self.imageView.frame=CGRectMake(frame.size.width-image.size.width/2.0,-image.size.height/2.0, image.size.width, image.size.height);
//        self.imageView.hidden=YES;
//        self.imageView.tag=999;
//        [self addSubview:self.imageView];
        if (isNeedFocusImg) {
            UIImage* img = [[UIImage imageNamed:@"normal_btn_focus"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            [self setBackgroundImage:img forState:UIControlStateHighlighted];
        }
        
        [self addTarget:self action:@selector(dynamicHandleForward:) forControlEvents:UIControlEventTouchUpInside];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self
                                                                                              action:@selector(choose:)];
        longPress.minimumPressDuration = 1.0;
        [self addGestureRecognizer:longPress];
        
    }
    return self;
}

#pragma mark - 长按手势
- (void)choose:(UIGestureRecognizer *)ges
{
    DynamicForwardBtn *btn = (DynamicForwardBtn *)[ges view];
    btn.userInteractionEnabled=NO;
    if ([self longProgress]) {
        [self longProgress]();
    }
}

-(void)dynamicHandleForward:(id)param
{
    BOOL isAnimal = YES;

    switch ([self.dataSource.processId integerValue]) {
        case DynamicForwardType1:
        {
                    WLConsultViewController *vc = [[WLConsultViewController alloc] init];
                    [self.parentVC.navigationController pushViewController:vc animated:isAnimal];
        }
            break;
        case DynamicForwardType2:
        {
                    WLHelperViewController *vc = [[WLHelperViewController alloc] init];
                    [self.parentVC.navigationController pushViewController:vc animated:isAnimal];
        }
            break;
        case DynamicForwardType3:
        {
            //        SupportTenementViewController *vc = [[SupportTenementViewController alloc] init];
            //        [self.parentVC.navigationController pushViewController:vc animated:isAnimal];
        }
            break;
        case DynamicForwardType4:
        {
            //        SupportTenementViewController *vc = [[SupportTenementViewController alloc] init];
            //        [self.parentVC.navigationController pushViewController:vc animated:isAnimal];
        }
            break;
            
        default:
            break;
    }

    
}
@end
