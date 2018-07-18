//
//  DynamicForwardBtn.h
//  WLBase
//
//  Created by 雷王 on 2018/6/2.
//  Copyright © 2018年 WL. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    DynamicForwardType1=1,
    DynamicForwardType2=2,
    DynamicForwardType3=3,
    DynamicForwardType4=4,

}DynamicForwardType;


@protocol DynamicForwardBtnDelegate <NSObject>

-(void)dynamicForwardBtnEnterNewVC;

@end
@class HomeBannerModel;
@interface DynamicForwardBtn : UIButton
@property(nonatomic, weak)id delegate;
@property (nonatomic,copy) void (^longProgress)();
- (instancetype)initWithFrame:(CGRect)frame viewcontroller:(UIViewController*)viewcontroller dataSource:(HomeBannerModel*)dataSource isNeedFocusImg:(BOOL)isNeedFocusImg;

@end
