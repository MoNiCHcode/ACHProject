//
//  CommondTools.m
//  MXKit
//
//  Created by 余汪送 on 15/11/17.
//  Copyright © 2015年 maxin. All rights reserved.
//

#import "CommondTools.h"

#import "HomeViewController.h"
#import "FightGroupViewController.h"
#import "MineViewController.h"


#import "AppDelegate.h"

@implementation CommondTools

+(void)gotoMainVC
{
    
    //首页
    HomeViewController* indexVC=[[HomeViewController alloc]init];
    UINavigationController* nav1=[[UINavigationController alloc]initWithRootViewController:indexVC];
    nav1.navigationBar.hidden=YES;
    //社区
    FightGroupViewController* Community=[[FightGroupViewController alloc]init];
    UINavigationController* nav2=[[UINavigationController alloc]initWithRootViewController:Community];
    nav2.navigationBar.hidden=YES;
    //凑热闹
    MineViewController* lively=[[MineViewController alloc]init];
    UINavigationController* nav3=[[UINavigationController alloc]initWithRootViewController:lively];
    nav3.navigationBar.hidden=YES;
    
//    AppDelegate* delegate=[UIApplication sharedApplication].delegate;
//    
//    AXDTabbarController* navBarVC=delegate.axdTabBarController;
//    navBarVC.viewControllers=@[nav1,nav2,nav3];
//    navBarVC.titleArray=@[@"首 页",@"拼 团",@"我 的"];
//    navBarVC.selectTitleArray=@[@"",@"发帖",@"我的"];
//    navBarVC.imagesArray=@[@"首页未选中",@"团-未选中",@"我的-未选中"];
//    navBarVC.selectImagesArray=@[@"首页-选中",@"团",@"矢量智能对象7"];
//    navBarVC.itemWidth=25;
//    navBarVC.selectColor= kColor_main;
////    [navBarVC setRedNumLableWithNumber:15 andIndex:0];
////    [navBarVC showRedPoint:YES andIndex:2];
//    [navBarVC appointTabBarItemWithIndex:0];
//    
//    UIWindow* window=delegate.window;
//    window.rootViewController=navBarVC;
    
}

////邮箱
//+ (BOOL) validateEmail:(NSString *)email
//{
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:email];
//}
//
//
////手机号码验证
//+ (BOOL) validateMobile:(NSString *)mobile
//{
//    //手机号以13，14， 15，18开头，八个 \d 数字字符
//    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    return [phoneTest evaluateWithObject:mobile];
//}
//+ (BOOL) validateUserName:(NSString *)userName
//{
//    NSString *nicknameRegex = @"^[a-zA-Z0-9\u4e00-\u9fa5]+$";
//    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
//    return [passWordPredicate evaluateWithObject:userName];
//}

//存用户信息
/*
 info =         {
    email = "";
    lastloginip = 0;
    lastlogintime = 0;
    myid = "";
    myidkey = "";
    password = ea85a28ad6a38742c5197da9842b3893;
    regdate = 1447932327;
    regip = "";
    salt = 73976b;
    secques = "";
    uid = 1475948;
    username = 15755382566;
 };*/
//+(void)saveUserInfoByUserDefaultsWithDic:(NSDictionary*)dic andPassword:(NSString*)password
//{
//    [userDefaults setObject:[self formatterString:dic[K_EMAIL]] forKey:K_EMAIL];
//    [userDefaults setObject:[self formatterString:dic[K_LASTLOGINIP]] forKey:K_LASTLOGINIP];
//    [userDefaults setObject:[self formatterString:dic[K_LASTLGOINTIME]] forKey:K_LASTLGOINTIME];
//    [userDefaults setObject:[self formatterString:dic[K_MYID]] forKey:K_MYID];
//    [userDefaults setObject:[self formatterString:dic[K_MYIDKEY]] forKey:K_MYIDKEY];
//    [userDefaults setObject:[self formatterString:dic[K_REGDATE]] forKey:K_REGDATE];
//    [userDefaults setObject:[self formatterString:dic[K_REGIP]] forKey:K_REGIP];
//    [userDefaults setObject:[self formatterString:dic[K_SALT]] forKey:K_SALT];
//    [userDefaults setObject:[self formatterString:dic[K_SECAUES]] forKey:K_SECAUES];
//    [userDefaults setObject:[self formatterString:dic[K_UID]] forKey:K_UID];
//    [userDefaults setObject:[self formatterString:dic[K_USERNAME]] forKey:K_USERNAME];
//    [userDefaults setObject:[self formatterString:dic[K_PHOTO]] forKey:K_PHOTO];
//    [userDefaults setObject:password forKey:K_PASSWORD];
//    [userDefaults synchronize];
//    
//    
//}
//
////移除用户信息
//+(void)removeUserInfo
//{
//    [userDefaults removeObjectForKey:K_EMAIL];
//    [userDefaults removeObjectForKey:K_LASTLOGINIP];
//    [userDefaults removeObjectForKey:K_LASTLGOINTIME];
//    [userDefaults removeObjectForKey:K_MYID];
//    [userDefaults removeObjectForKey:K_MYIDKEY];
//    [userDefaults removeObjectForKey:K_REGDATE];
//    [userDefaults removeObjectForKey:K_REGIP];
//    [userDefaults removeObjectForKey:K_SALT];
//    [userDefaults removeObjectForKey:K_SECAUES];
//    [userDefaults removeObjectForKey:K_UID];
//    [userDefaults removeObjectForKey:K_USERNAME];
//    [userDefaults removeObjectForKey:K_PASSWORD];
//    [userDefaults removeObjectForKey:K_PHOTO];
//    [userDefaults synchronize];
//    
//}

////将当前登录用户写到本地
//+(void)saveUserInfoByDic:(NSDictionary*)dic password:(NSString*)password
//{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSString* fileName=[NSString stringWithUTF8String:"userInfo"];
//        NSString* filePath=[self getFilePathWithfileName:fileName];
//        if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
//            NSMutableDictionary* userInfo=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//            NSMutableDictionary* uDic=[NSMutableDictionary dictionaryWithDictionary:dic];
//            [uDic setObject:password forKey:@"password"];
//            [userInfo setObject:uDic forKey:[self formatterString:dic[K_USERNAME]]];
//            [NSKeyedArchiver archiveRootObject:userInfo toFile:filePath];
//        }else{
//            NSMutableDictionary* userInfo=[[NSMutableDictionary alloc]init];
//            NSMutableDictionary* uDic=[NSMutableDictionary dictionaryWithDictionary:dic];
//            [uDic setObject:password forKey:@"password"];
//            [userInfo setObject:uDic forKey:[self formatterString:dic[K_USERNAME]]];
//            [NSKeyedArchiver archiveRootObject:userInfo toFile:filePath];
//        }
//    });
//}
//
////根据用户名删除对应的用户信息
//+(void)deleteUserInfoWithUserName:(NSString*)userName
//{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSString* fileName=[NSString stringWithUTF8String:"userInfo"];
//        NSString* filePath=[self getFilePathWithfileName:fileName];
//        NSMutableDictionary* userInfos=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//        [userInfos removeObjectForKey:userName];
//        [NSKeyedArchiver archiveRootObject:userInfos toFile:filePath];
//    });
//}
//
////获取所有用户信息
//+(NSMutableDictionary*)getAllUserInfos
//{
//    NSString* fileName=[NSString stringWithUTF8String:"userInfo"];
//    NSString* filePath=[self getFilePathWithfileName:fileName];
//    NSMutableDictionary* userInfo=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//    return userInfo;
//}
//
//
//
//+(NSString*)formatterString:(NSString*)string
//{
//    NSString* str=[NSString stringWithFormat:@"%@",string];
//    return [str isEqualToString:@"<null>"]?@"":str;
//}
//
//
//+(CGSize)getStringSize:(float)fontSize withString:(NSString*)str andWidth:(CGFloat)width
//{
//    return [str boundingRectWithSize:CGSizeMake(width, LONG_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
//}
//
////计算时间
//+(NSString *)fomartDate:(NSString *)Date{
//    long long time=[Date doubleValue];
//    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:time];
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyy/MM/dd"];
//    NSString *dateString = [dateFormat stringFromDate:nd];
//    return dateString;
//}
//
//
//+ (NSString *)getFilePathWithfileName:(NSString*)fileName
//{
//    NSString * filePath;
//    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    filePath = [[NSString alloc] initWithFormat:@"%@/%@",DocumentsPath,fileName];
////    DLog(@"filePath============ %@",filePath);
//    return filePath;
//}
//
//+(BOOL)userIsLogin
//{
//    NSString* uid=[userDefaults objectForKey:K_UID];
//    if (!uid || [uid isEqualToString:@""] || [uid isEqualToString:@"<null>"]) {
//        return NO;
//    }else{
//        return YES;
//    }
//}
//
//+(float)getWebImageCacheSize
//{
//    return [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
//}
//
//
//+(NSString *)StringDismantling:(NSString *)Str{
//    NSRange range = [Str rangeOfString:@"="];
//    NSString *Dismantlin = [Str substringFromIndex:range.location+1];
//    return Dismantlin;
//}

@end
