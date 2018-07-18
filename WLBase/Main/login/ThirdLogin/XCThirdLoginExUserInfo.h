//
//  XCThirdLoginExUserInfo.h
//  CommunityService
//
//  Created by zhangmm on 15/7/15.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCThirdLoginExUserInfo : NSObject
//微信
/**城市*/
//@property (copy, nonatomic)NSString *city ;
///**省份*/
//@property (copy, nonatomic)NSString *province;
/**用户昵称*/
@property (copy, nonatomic)NSString *nickname ;
/**微博用户昵称*/
@property (copy, nonatomic)NSString *name;
/**weixin用户openid*/
@property (copy, nonatomic)NSString *openid;
/**weixin用户openid*/
@property (copy, nonatomic)NSString *unionid;
/**weibo用户id*/
@property (copy, nonatomic)NSString *idstr;
/**用户性别*/
@property (copy, nonatomic)NSString *sex;
/**用户头像*/
@property (copy, nonatomic)NSString *headimgurl;

//QQ
/**用户头像50*/
@property (copy, nonatomic)NSString *figureurl_qq_1;
/**用户头像100*/
//@property (copy, nonatomic)NSString *figureurl_qq_2;
@property (copy, nonatomic)NSString *gender;

@property (copy, nonatomic)NSString *profile_image_url;
//city = "\U6b66\U6c49";
//figureurl = "http://qzapp.qlogo.cn/qzapp/1103839269/BEC9ED486EACD03D3E8E9BBFA70183F1/30";
//"figureurl_1" = "http://qzapp.qlogo.cn/qzapp/1103839269/BEC9ED486EACD03D3E8E9BBFA70183F1/50";
//"figureurl_2" = "http://qzapp.qlogo.cn/qzapp/1103839269/BEC9ED486EACD03D3E8E9BBFA70183F1/100";
//"figureurl_qq_1" = "http://q.qlogo.cn/qqapp/1103839269/BEC9ED486EACD03D3E8E9BBFA70183F1/40";
//"figureurl_qq_2" = "http://q.qlogo.cn/qqapp/1103839269/BEC9ED486EACD03D3E8E9BBFA70183F1/100";
//gender = "\U5973";
//"is_lost" = 0;
//"is_yellow_vip" = 0;
//"is_yellow_year_vip" = 0;
//level = 0;
//msg = "";
//nickname = "\U6c34\U516e";
//province = "\U6e56\U5317";
//ret = 0;
//vip = 0;
//"yellow_vip_level" = 0;


//city = "";
//country = CN;
//headimgurl = "";
//language = "zh_CN";
//nickname = "\U8f7b\U6c34";
//openid = "oX1DRt6yM-9UpPSUYx0v0M9MNDDU";
//privilege =     (
//);
//province = Beijing;
//sex = 2;
//unionid = "owwDHjiMJNOVU_V39-j3qD1DtNas";


/*
"allow_all_act_msg" = 0;
"allow_all_comment" = 1;
"avatar_hd" = "http://tp1.sinaimg.cn/5061016472/180/0/0";
"avatar_large" = "http://tp1.sinaimg.cn/5061016472/180/0/0";
"bi_followers_count" = 0;
"block_app" = 0;
"block_word" = 0;
city = 15;
class = 1;
"created_at" = "Thu Mar 06 15:49:56 +0800 2014";
"credit_score" = 80;
description = "";
domain = "";
"favourites_count" = 8;
"follow_me" = 0;
"followers_count" = 1;
following = 0;
"friends_count" = 56;
gender = f;
"geo_enabled" = 1;
id = 5061016472;
idstr = 5061016472;
lang = "zh-cn";
location = "\U4e0a\U6d77 \U6d66\U4e1c\U65b0\U533a";
mbrank = 0;
mbtype = 0;
name = "\U65cb\U98ce\U4f0a\U59cb-";
"online_status" = 0;
"pagefriends_count" = 0;
"profile_image_url" = "http://tp1.sinaimg.cn/5061016472/50/0/0";
"profile_url" = "u/5061016472";
province = 31;
ptype = 0;
remark = "";
"screen_name" = "\U65cb\U98ce\U4f0a\U59cb-";
star = 0;
status =     {
    "attitudes_count" = 0;
    "comments_count" = 0;
    "created_at" = "Thu Apr 02 23:21:58 +0800 2015";
    "darwin_tags" =         (
    );
    favorited = 0;
    geo = "<null>";
    id = 3827321926735502;
    idstr = 3827321926735502;
    "in_reply_to_screen_name" = "";
    "in_reply_to_status_id" = "";
    "in_reply_to_user_id" = "";
    mid = 3827321926735502;
    mlevel = 0;
    "pic_urls" =         (
    );
    "reposts_count" = 0;
    source = "<a href=\"http://weibo.com/\" rel=\"nofollow\">\U5fae\U535a weibo.com</a>";
    "source_allowclick" = 0;
    "source_type" = 1;
    text = "\U6700\U8fd1\U5fc3\U60c5\U538b\U6291\Uff0c\U8001\U662f\U7231\U80e1\U4e71\U731c\U60f3\Uff0c\U603b\U662f\U5e0c\U671b\U4ed6\U53ef\U4ee5\U54c4\U7740\U6211\Uff0c\U5f97\U5230\U4e4b\U540e\U5c31\U6709\U4e00\U79cd\U6ee1\U8db3\U611f\Uff0c\U6ca1\U6709\U5f97\U5230\U5c31\U5fc3\U60c5\U4e0d\U597d\Uff0c\U5c31\U8ba4\U4e3a\U662f\U4ed6\U4e0d\U591f\U5728\U4e4e\U6211\Uff0c\U4e0d\U7231\U6211\Uff0c\U4e5f\U8bb8\U771f\U7684\U662f\U6211\U9519\U4e86\U3002\U8fd9\U6bb5\U65f6\U95f4\U4ed6\U786e\U5b9e\U5f88\U5fd9\Uff0c\U5f88\U7d2f\Uff0c\U6211\U6ca1\U6709\U7ed9\U4ed6\U4e9b\U5b89\U6170\Uff0c\U6ca1\U6709\U7ed9\U4ed6\U591a\U4e9b\U6e29\U6696\Uff0c\U8fd8\U7ecf\U5e38\U7ed9\U4ed6\U800d\U5c0f\U813e\U6c14\Uff0c\U8bf4\U4ed6\U4e0d\U5728\U4e4e\U6211\Uff0c\U4e0d\U7231\U6211\Uff0c\U6bcf\U6b21\U4ed6\U90fd\U9053\U6b49\Uff0c\U4eb2\U7231\U7684\Uff0c\U5bf9\U4e0d\U8d77\U3002\U3002";
    truncated = 0;
    visible =         {
        "list_id" = 0;
        type = 0;
    };
};
"statuses_count" = 6;
urank = 5;
url = "";
verified = 0;
"verified_reason" = "";
"verified_reason_url" = "";
"verified_source" = "";
"verified_source_url" = "";
"verified_trade" = "";
"verified_type" = "-1";
weihao = "";

*/

@end
