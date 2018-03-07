//
//  HttpRequest.m
//  WLBase
//
//  Created by 雷王 on 17/3/1.
//  Copyright © 2017年 WL. All rights reserved.
//

#import "HttpRequest.h"

#import "HttpRequest.h"
//#import "ASIHTTPRequest.h"
//#import "AFHTTPRequestOperation.h"
//#import "AFHTTPClient.h"
#import "SBJsonParser.h"
//#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "SBJson.h"
#import "Reachability.h"
#import "AFNetworking.h"
#import "KCH.h"
#import "KConfig.h"
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>

#define KHttpCacheRoot @"HttpCacheFile.plist"

@implementation HttpRequest

static Kache* _kache = nil;

static NSMutableDictionary* httpCache = nil;

static dispatch_queue_t _mySerialQueue;

+ (void)initialize
{
    [super initialize];
    
    httpCache = [[NSMutableDictionary alloc] initWithCapacity:16];
}

+(void)getWebData:(NSDictionary *)params path:(NSString *)path method:(NSString *)method ishowLoading:(BOOL)show success:(void(^)(id object))success fail:(void(^)(NSString* msg))fail
{
    
    [self getWebData:params path:path method:method ishowLoading:show success:success fail:fail isNeedCache:YES cacheExpireTime:0 httpTimeout:10];//默认需要缓存， 而且timeout时间为10秒
}

+(UIView*)getFLowerVC
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UINavigationController* nav = (UINavigationController*)appDelegate.window.rootViewController;
    if ( nav && [nav isKindOfClass:[UINavigationController class]])
    {
        return nav.topViewController.view;
    }
    else
    {
        return appDelegate.window;
    }
}

//+(void)inithttps
//{
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//    securityPolicy.allowInvalidCertificates = YES;
//    [AFHTTPSessionManager manager].securityPolicy = securityPolicy;
//
//}

+(void)setDefaultHeader:(AFHTTPSessionManager*)manager
{
    //    deviceId 设备id
    //    systemVersion 系统版本
    //    mobileType 手机型号
    //    appVersion app版本
    //    channel 渠道
    
    //设置通用头
    
    //deviceID
    //友盟的openID
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector])
    {
        deviceID = [cls performSelector:deviceIDSelector];
    }
    
    //    //idfv
    //    NSString *deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    if ( deviceID && deviceID.length )
    {
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//        NSDictionary* headerDic = @{
//                                    @"deviceId": deviceID,
//                                    @"systemVersion":[[UIDevice currentDevice] systemVersion],
//                                    @"mobileType":[[UIDevice currentDevice] model],
//                                    @"appVersion":version,
//                                    //TODO, add 通行证TOKEN
//                                    @"custId": [MobileData sharedInstance].custID == nil ? @"" : [MobileData sharedInstance].custID,
//                                    @"channel":PACKAGE_CHINNLE,
//                                    @"deviceType": @"2"   //@"1"android, @"2"iOS
//                                    };
        NSDictionary* headerDic = @{
                                    @"deviceId": deviceID,
                                    @"systemVersion":[[UIDevice currentDevice] systemVersion],
                                    @"mobileType":[[UIDevice currentDevice] model],
                                    @"appVersion":version,
                                    @"deviceType": @"2"   //@"1"android, @"2"iOS
                                    };

        
        NSString* headerStr = [NSString jsonStringWithDictionary:headerDic];
        [manager.requestSerializer setValue:headerStr forHTTPHeaderField: @"appInfo"];
    }
}

+(NSString*)getHttpCacheFilePath:(NSString*)fileName
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *plistPath = [rootPath stringByAppendingPathComponent:fileName];
    
    return plistPath;
}

//缓存cell高度到磁盘
+(void)writeHttpResponseDicToDisk:(NSString*)fileName responeseDic:(NSString*)str
{
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    NSString *error;
    NSString *plistPath = [self getHttpCacheFilePath:fileName];
    NSString *plistDict = str;//self.dynamicCellHeightsDic;
    
    if ([str isKindOfClass:[NSString class]])
    {
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:@{fileName:str}
                                                                       format:NSPropertyListBinaryFormat_v1_0
                                                             errorDescription:&error];
        if(plistData) {
            [plistData writeToFile:plistPath atomically:YES];
        }
        else
        {
            return NSLog(@"%@", error);
        }
    }
    else
        return NSLog(@"cache is not str");
}

//从磁盘读取cell高度
+(NSString*)readHttpCacheFromDisk:(NSString*)fileName
{
    //    //退到后台的时候保存image高度到磁盘
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(writeCellHeightDicToDisk) name:
    //     UIApplicationWillResignActiveNotification object:nil];
    
    //self.dynamicCellHeightsDic = [[NSMutableDictionary alloc] initWithCapacity:64];
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    
    NSError* error = nil;
    NSString *plistPath = [self getHttpCacheFilePath:fileName];
    
    NSString * cacheResponseStr = [[[NSDictionary alloc] initWithContentsOfFile:plistPath] objectForKey:fileName];
    
    if (cacheResponseStr) {
        //self.dynamicCellHeightsDic = [[NSMutableDictionary alloc] initWithDictionary:dictionary];
        
        return cacheResponseStr;
    }
    
    return nil;
    //    });
}

+(NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return filename;
}

+(void)writeCacheToDiskParams:(NSDictionary *)params path:(NSString *)path responseStr:(NSString*)str
{
    NSString* paramsKey = [NSString jsonStringWithDictionary:params];
    NSString* requestKey = [NSString stringWithFormat:@"%@_%@", path, paramsKey];
    
    NSString* cacheFileName = [self cachedFileNameForKey:requestKey];
    [self writeHttpResponseDicToDisk:cacheFileName responeseDic:str];
}

+(NSString*)readCache:(NSDictionary *)params path:(NSString *)path
{
    NSString* paramsKey = [NSString jsonStringWithDictionary:params];
    NSString* requestKey = [NSString stringWithFormat:@"%@_%@", path, paramsKey];
    
    NSString* cacheFileName = [self cachedFileNameForKey:requestKey];
    
    NSString* cacheResponseStr = [self readHttpCacheFromDisk:cacheFileName];
    return cacheResponseStr;
}

//需要缓存的接口
+(void)getWebData:(NSDictionary *)params path:(NSString *)path method:(NSString *)method ishowLoading:(BOOL)show success:(void(^)(id object))success fail:(void(^)(NSString* msg))fail isNeedCache:(BOOL)isNeedCache
  cacheExpireTime:(int)cacheExpireTime
{
    [self getWebData:params path:path method:method ishowLoading:show success:success fail:fail isNeedCache:isNeedCache cacheExpireTime:cacheExpireTime httpTimeout:10];
}

+(void)getWebData:(NSDictionary *)params path:(NSString *)path method:(NSString *)method ishowLoading:(BOOL)show success:(void(^)(id object))success fail:(void(^)(NSString* msg))fail isNeedCache:(BOOL)isNeedCache
  cacheExpireTime:(int)cacheExpireTime httpTimeout:(int)timeOut
{
    //    [self inithttps];
    if (isNeedCache)
    {
        //        //初始化cache
        //        if ( _kache == nil )
        //        {
        //            _kache = [[Kache alloc] initWithFiletoken:@"xcfamily"];
        //        }
        
        //cache线程
        if ( _mySerialQueue == nil )
        {
            _mySerialQueue = dispatch_queue_create("xcfamily.request.cache", 0);
        }
    }
    
    //    NSURL *url = nil;
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    url = [NSURL URLWithString:path];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    manager.requestSerializer.timeoutInterval = timeOut;//60 * 3;
    
#warning ipv6添加
    manager.responseSerializer.acceptableContentTypes = nil;//[NSSet setWithObject:@"text/plain"];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
    manager.securityPolicy.validatesDomainName = NO;//是否验证域名
    
    [self setDefaultHeader:manager];
    
    
    if (show)
    {
        //        BOOL isHUD = NO;
        //        UIWindow *mainwindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
        //        for (UIView *v in mainwindow.subviews)
        //        {
        //            if ([v isKindOfClass:[MBProgressHUD class]])
        //            {
        //                isHUD=YES;
        //            }
        //        }
        //        if (isHUD)
        //        {
        //
        //            NSLog(@"isHUD");//有菊花，就不加
        //        }
        //        else
        //        {
        //
        //            [MBProgressHUD showHUDAddedTo:[self getFLowerVC] animated:YES];//没有菊花就加
        //        }
    }
    
    //无网络返回cache内容
    //    NSMutableURLRequest *request = nil;
    if ( isNeedCache )
    {
        //        //初始化cache
        //        NSError *serializationError = nil;
        //        request = [manager.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:path] absoluteString] parameters:params error:&serializationError];
        
        AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        if ( appdelegate.networkStatus == NotReachable)
            
        {
            //            if (show)
            //            {
            //                //cache回来后，取消菊花
            //                //[MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].windows objectAtIndex:0] animated:YES];
            //            }
            //
            //            //id caceResponseObject = [Kache valueForKey:[request.URL absoluteString]];
            
            return [self returnCacheIfHttpTimeout:params path:path success:success fail:fail];
        }
    }
    
    
    
    
    if ([method isEqualToString:@"POST"])
    {
        [manager POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString* string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
            
            NSMutableDictionary *dict = [jsonParser objectWithString:string];
            
            if (success)
            {
                success(dict);
            }
            
            if (isNeedCache)
            {
                //写缓存
                dispatch_async(_mySerialQueue,
                               ^{
                                   //                                   //cache
                                   //                                   [Kache setValue:responseObject forKey:[request.URL absoluteString] expiredAfter:cacheExpireTime];
                                   //                                   sleep(1);
                                   
                                   [self writeCacheToDiskParams:params path:path responseStr:string];
                                   
                               });
                
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error.description);
            //            NSLog(@"%@",operation.response.allHeaderFields);
            
            //如果需要缓存
            if (isNeedCache)
            {
                if ( error && error.code ==-1001 && [error.domain compare:NSURLErrorDomain] == 0)
                {
                    [self returnCacheIfHttpTimeout:params path:path success:success fail:fail];
                } else if (fail) {
                    fail(error.description);
                }
            }
            else
            {
                if (fail) {
                    fail(error.description);
                }
            }
        }];
        
    }
    else
    {
        NSLog(@"GET request issued, url = %@", path);
        
        [manager GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"http data response = %@", dict);
            
            if (isNeedCache)
            {
                //写缓存
                dispatch_async(_mySerialQueue,
                               ^{
                                NSString* string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                   [self writeCacheToDiskParams:params path:path responseStr:string];
                               });
            }
            
            if (success)
            {
                success(dict);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error.description);
            //            NSLog(@"%@",task.response.allHeaderFields);
            
            
            if (isNeedCache)
            {
                if ( error && error.code ==-1001 && [error.domain compare:NSURLErrorDomain] == 0)
                {
                    [self returnCacheIfHttpTimeout:params path:path success:success fail:fail];
                }else if (fail) {
                    fail(error.description);
                }
            }
            else
            {
                if (fail) {
                    fail(error.description);
                }
            }
            
        }];
        
        
        
    }
}


+(void)returnCacheIfHttpTimeout:(NSDictionary *)params path:(NSString *)path success:(void(^)(id object))success fail:(void(^)(NSString* msg))fail
{
    NSString* cacheResponseStr = [self readCache:params path:path];
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSMutableDictionary *dict = [jsonParser objectWithString:cacheResponseStr];
    
    if (cacheResponseStr)
    {
        if (success) {
            
            if ([dict isKindOfClass:[NSDictionary class]]) {
                success(dict);
            }
            
        }
    }
    else
    {
        if (fail) {
            fail(@"cache is empty");
        }
    }
}

//上传图片
+(void)uploadImage:(NSDictionary *)params path:(NSString *)path andImageArr:( UIImage*)image  withView:(UIView*)view withIntIndex:(int)index  success:(void(^)(id object))success fail:(void(^)(NSString* msg))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    [self setDefaultHeader:manager];
    
    [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(image,0.2);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@_%ld.jpg", str, random()];
        [formData appendPartWithFileData:data name:@"imageFile" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress.localizedDescription);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传完成");
        
        if (success) {
            success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error.description);
        }
        NSLog(@"上传失败->%@", error);
        
    }];
    
}

+(void)uploadImages:(NSDictionary *)params path:(NSString *)path andImageArr:( NSArray*)images  withView:(UIView*)view withIntIndex:(int)index  success:(void(^)(id object))success fail:(void(^)(NSString* msg))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    [self setDefaultHeader:manager];
    
    [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (UIImage* image in images)
        {
            NSData *data = UIImageJPEGRepresentation(image,0.2);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@_%ld.jpg", str, random()];
            [formData appendPartWithFileData:data name:@"imageFile" fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传完成");
        //
        if (success) {
            success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error.description);
        }
        NSLog(@"上传失败->%@", error);
        
    }];
    
}

@end

