//
//  WLFlyViewController.h
//  WLBase
//
//  Created by 雷王 on 2018/7/19.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "IFlyMSC/IFlyMSC.h"
@class IFlySpeechSynthesizer;
@interface WLFlyViewController : BaseViewController<IFlySpeechSynthesizerDelegate>
@property (nonatomic, strong) IFlySpeechSynthesizer * iFlySpeechSynthesizer;

@end
