//
//  LoginAudomaticly.m
//  CommunityService
//
//  Created by zhangmm on 15/4/15.
//  Copyright (c) 2015年 movitech. All rights reserved.
// 自动登录
#define kNewLoginUrl @"/rest/v2/user/checkPassword"

#import "LoginAudomaticly.h"
#import "MyKeyChainHelper.h"
//#import  "LoginAndOut.h"
//#import "LoginViewController.h"
@implementation LoginAudomaticly

+(void)loginAudomaticlyWithUserName:(NSString*)userName password:(NSString *)pwd{


//    NSString *path = [NSString stringWithFormat:@"%@%@",server,kNewLoginUrl];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                         userName,@"tel",
//                         pwd,@"password",
//                         [MobileData sharedInstance].deviceToken?[MobileData sharedInstance].deviceToken:@"1234",@"deviceid",
//                         @"0",@"isAndroid",nil];
//    [HttpRequest getWebData:dic path:path method:@"POST" ishowLoading:YES success:^(id object) {
//        if (object) {
//            
//            if([object[@"result"] intValue] == 1)
//            {
//               
//                [LoginAndOut manager];
//                [LoginAndOut loginWithObjcet:object isRegist:NO];
//                
//               
//                [MyKeyChainHelper deleteWithUserNameService:KEY_XC_USERNAME psaawordService:KEY_XC_PASSWORD];
//                             //保存用户名、密码
//                [MyKeyChainHelper saveUserName:userName userNameService:KEY_XC_USERNAME psaaword:pwd psaawordService:KEY_XC_PASSWORD];
//                
//                NSLog(@"3——————%@",[MyKeyChainHelper getUserNameWithService:KEY_XC_USERNAME]);
//                NSLog(@"3——————%@",[MyKeyChainHelper getUserNameWithService:KEY_XC_PASSWORD]);
//                return ;
//            }
//           
//          }
//    
//
////        [[LoginViewController alloc] init];
//
//        
//    } fail:^(NSString *msg) {
//        NSLog(@"%@", msg);
////        [LoginAndOut manager];
////        [LoginAndOut logout];
//    }];
    
}


+(void)loginAudomaticlyWithUserName:(NSString*)userName password:(NSString *)pwd controller:(UIViewController *)controller
{
    
    
//    NSString *path = [NSString stringWithFormat:@"%@%@",server,kNewLoginUrl];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                         userName,@"tel",
//                         pwd,@"password",
//                         [MobileData sharedInstance].deviceToken?[MobileData sharedInstance].deviceToken:@"1234",@"deviceid",
//                         @"0",@"isAndroid",nil];
//    [HttpRequest getWebData:dic path:path method:@"POST" ishowLoading:YES success:^(id object) {
//        if (object) {
//        
//        NSInteger result =    [object[@"result"] integerValue];
////            result = 0;
//            if(result && result == 1)
//            {
//                
//                [LoginAndOut manager];
//                [LoginAndOut loginWithObjcet:object isRegist:NO];
//                
//                
//                [MyKeyChainHelper deleteWithUserNameService:KEY_XC_USERNAME psaawordService:KEY_XC_PASSWORD];
//                //保存用户名、密码
//                [MyKeyChainHelper saveUserName:userName userNameService:KEY_XC_USERNAME psaaword:pwd psaawordService:KEY_XC_PASSWORD];
//                
//                NSLog(@"3——————%@",[MyKeyChainHelper getUserNameWithService:KEY_XC_USERNAME]);
//                NSLog(@"3——————%@",[MyKeyChainHelper getUserNameWithService:KEY_XC_PASSWORD]);
//                return ;
//            }
//            
//        }
//      
//        LoginViewController *loginVc =   [[LoginViewController alloc] init];
//        loginVc.controller = controller;
//        [controller.navigationController pushViewController:loginVc animated:YES];
//        
//    } fail:^(NSString *msg) {
//        NSLog(@"%@", msg);
//        //        [LoginAndOut manager];
//        //        [LoginAndOut logout];
//        LoginViewController *loginVc =   [[LoginViewController alloc] init];
//        loginVc.controller = controller;
//        [controller.navigationController pushViewController:loginVc animated:YES];
//    }];
    
}

@end
