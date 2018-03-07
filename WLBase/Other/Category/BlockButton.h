//
//  BlockButton.h
//  WLBase
//
//  Created by 雷王 on 2018/3/5.
//  Copyright © 2018年 WL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlockButton;

typedef void (^TouchButton)(BlockButton*);

@interface BlockButton : UIButton

@property(nonatomic,copy)TouchButton block;

@property(nonatomic,copy)TouchButton longPressBlock;

@property(nonatomic,strong) UILongPressGestureRecognizer* longPressGes;


//判断按钮是否点击状态。
@property(nonatomic,assign)BOOL isSelect;

@end

