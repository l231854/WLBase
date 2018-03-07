//
//  HttpRequest.h
//  WLBase
//
//  Created by 雷王 on 17/3/1.
//  Copyright © 2017年 WL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject
//不需要缓存的接口
+(void)getWebData:(NSDictionary *)params path:(NSString *)path method:(NSString *)method ishowLoading:(BOOL)show success:(void(^)(id object))success fail:(void(^)(NSString* msg))fail;

//需要缓存的接口, add timeout
+(void)getWebData:(NSDictionary *)params path:(NSString *)path method:(NSString *)method ishowLoading:(BOOL)show success:(void(^)(id object))success fail:(void(^)(NSString* msg))fail isNeedCache:(BOOL)isNeedCache
  cacheExpireTime:(int)cacheExpireTime;

//需要缓存的接口
+(void)getWebData:(NSDictionary *)params path:(NSString *)path method:(NSString *)method ishowLoading:(BOOL)show success:(void(^)(id object))success fail:(void(^)(NSString* msg))fail isNeedCache:(BOOL)isNeedCache
  cacheExpireTime:(int)cacheExpireTime httpTimeout:(int)timeOut;

//上传图片
+(void)uploadImage:(NSDictionary *)params path:(NSString *)path andImageArr:(UIImage*)image  withView:(UIView*)view withIntIndex:(int)index   success:(void(^)(id object))success fail:(void(^)(NSString* msg))fail;

//上传多张图片
+(void)uploadImages:(NSDictionary *)params path:(NSString *)path andImageArr:( NSArray*)images  withView:(UIView*)view withIntIndex:(int)index  success:(void(^)(id object))success fail:(void(^)(NSString* msg))fail;
@end
