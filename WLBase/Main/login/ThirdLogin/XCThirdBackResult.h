//
//  XCThirdLoginParam.h
//  CommunityService
//
//  Created by zhangmm on 15/7/17.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCThirdBackResult : NSObject

/**用户昵称*/
@property (copy, nonatomic)NSString *custNickName ;

/**用户openid*/
@property (copy, nonatomic)NSString *thridUserId;
/**用户性别*/
@property (copy, nonatomic)NSString *custSex;
/**用户头像*/
@property (copy, nonatomic)NSString *custHeadpic;
@end
