//
//  CommondTools.h
//  MXKit
//
//  Created by 余汪送 on 15/11/17.
//  Copyright © 2015年 maxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommondTools : NSObject
//进入主页面
+(void)gotoMainVC;
////获取字符串的size
//+(CGSize)getStringSize:(float)fontSize withString:(NSString*)str andWidth:(CGFloat)width;
//
////邮箱
//+ (BOOL) validateEmail:(NSString *)email;
////手机号码验证
//+ (BOOL) validateMobile:(NSString *)mobile;
//
//+ (BOOL) validateUserName:(NSString *)userName;
////存储用户信息
//+(void)saveUserInfoByUserDefaultsWithDic:(NSDictionary*)dic andPassword:(NSString*)password;
////移除用户信息(是用userDefaults本地化)
//+(void)removeUserInfo;
//+(NSString*)formatterString:(NSString*)string;
//
////计算时间
//+(NSString *)fomartDate:(NSString *)Date;
//
////根据用户名给每个登录过的用户生成一个文件路径，本地化保存
//+ (NSString *)getFilePathWithUserName:(NSString*)userName;
//
////将手机登陆过得用户通过NSKeyedArchiver来本地化
//+(void)saveUserInfoByDic:(NSDictionary*)dic password:(NSString*)password;
//
////根据用户名删除对应的用户信息（删除NSKeyedArchiver保存的对应username的用户信息）
//+(void)deleteUserInfoWithUserName:(NSString*)userName;
//
//+(NSMutableDictionary*)getAllUserInfos;
//
//+(BOOL)userIsLogin;
//
//+(float)getWebImageCacheSize;
//
//+(NSString *)StringDismantling:(NSString *)Str;

@end
