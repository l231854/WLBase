//
//  MyNavBar.h
//  WLBase
//
//  Created by 雷王 on 2018/3/5.
//  Copyright © 2018年 WL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNavBar : UINavigationBar
@property(nonatomic,retain)UIButton *backBtn;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UIButton *rightBtn;
@property (nonatomic,strong)UIView *overlay;
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)hideLineOfNavtionBar;
- (void)showLineOfNavtionBar;
@end
