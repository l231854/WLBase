//
//  MobileData.h
//  CommunityService
//
//  Created by VincentDeng on 15/5/14.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MobileData : NSObject

/*设备token*/
@property (copy, nonatomic)NSString *deviceToken;

/***************************   个人信息     ***************************/
/*积分token*/
@property (copy, nonatomic)NSString *token ;
/*用户id*/
@property (copy, nonatomic)NSString *custID ;

/**我的背景图片*/
@property (copy, nonatomic)NSString *custBackground ;
/**用户登录（或绑定）手机号*/
@property (copy, nonatomic)NSString *custPhone;

/**用户目前的橙贝数值*/
@property (copy, nonatomic)NSString *myIntegral;

/**用户昵称*/
@property (copy, nonatomic)NSString *custNickName ;

/**用户性别*/
@property (copy, nonatomic)NSString *custSex;
/**用户头像*/
@property (copy, nonatomic)NSString *custHeadpic ;

/**用户邀请*/
@property (copy, nonatomic)NSString * custInviteKey;
/**用户邀请码id*/
@property (copy, nonatomic)NSString * inviteId;
/**连续分享天数*/
@property (copy, nonatomic)NSString *operateDays;




+ (MobileData *) sharedInstance;


@end
