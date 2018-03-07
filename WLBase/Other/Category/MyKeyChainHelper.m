//
//  MyKeyChainHelper.m
//  KeyChainDemo
//
//  Created by 倪敏杰 on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyKeyChainHelper.h"
#import "NSString+Encrypt.h"
#import "AppDelegate.h"

@implementation MyKeyChainHelper

+ (NSMutableDictionary *)getKeyChainQuery:(NSString *)service {  
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:  
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,  
            service, (id)kSecAttrAccount,  
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,  
            nil];  
}  

+ (void) saveUserName:(NSString*)userName 
      userNameService:(NSString*)userNameService 
             psaaword:(NSString*)pwd 
      psaawordService:(NSString*)pwdService
{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:userNameService];  
    SecItemDelete((CFDictionaryRef)keychainQuery);  
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:userName] forKey:(id)kSecValueData];  
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL); 
    
    keychainQuery = [self getKeyChainQuery:pwdService];  
    SecItemDelete((CFDictionaryRef)keychainQuery);
     NSLog(@"加密前----------%@",pwd);
   if ([[NSUserDefaults standardUserDefaults] objectForKey:@"xcspasswordkey"]) {
    NSString *str = [pwd aes256_encrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"xcspasswordkey"]];
      NSLog(@"加密后----------%@",str);
   
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:str] forKey:(id)kSecValueData];
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
   }
}

+ (void) deleteWithUserNameService:(NSString*)userNameService
                   psaawordService:(NSString*)pwdService
{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:userNameService];  
    SecItemDelete((CFDictionaryRef)keychainQuery); 
    
    keychainQuery = [self getKeyChainQuery:pwdService];  
    SecItemDelete((CFDictionaryRef)keychainQuery); 
}

+ (NSString*) getUserNameWithService:(NSString*)userNameService
{
    NSString* ret = nil;  
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:userNameService];  
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];  
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];  
    CFDataRef keyData = NULL;  
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) 
    {  
        @try 
        {  
//            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData *)keyData];
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];

        }
        @catch (NSException *e)
        {  
            NSLog(@"Unarchive of %@ failed: %@", userNameService, e);  
        }
        @finally 
        {  
        }  
    }  
    if (keyData)   
        CFRelease(keyData);  
    return ret; 
}

+ (NSString*) getPasswordWithService:(NSString*)pwdService
{
    NSString* ret = nil;

    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:pwdService];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];  
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];  
    CFDataRef keyData = NULL;  
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) 
    {  
        @try 
        {  
//            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData *)keyData];
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];

        }
        @catch (NSException *e)
        {  
            NSLog(@"Unarchive of %@ failed: %@", pwdService, e);  
        }
        @finally 
        {  
        }  
    }  
    if (keyData)   
        CFRelease(keyData);
//     NSLog(@"解密前----------%@",ret);
//    AppDelegate *De =   (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSLog(@"[[NSUserDefaults standardUserDefaults] objectForKey----------%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"xcspasswordkey"]);
    
    if (ret &&  [ret isKindOfClass:[NSString class]] &&[[NSUserDefaults standardUserDefaults] objectForKey:@"xcspasswordkey"]) {
//        NSLog(@"%@",[ret class]);
        ret = [ret aes256_decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"xcspasswordkey"]];
        
        NSLog(@"解密后----------%@",ret);
        
    }
   
    return ret;
}
@end
