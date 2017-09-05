//
//  NSObject+Common.m
//  Lilai01
//
//  Created by FangZhongli on 15/12/15.
//  Copyright © 2015年 向导. All rights reserved.
//

#define kPath_ResponseCache @"XDResponseCache"

#import "NSObject+Common.h"
#import "MBProgressHUD.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "NSString+MD5.h"
#import "AFNetworking.h"
#import "LoginViewController.h"


@implementation NSObject (Common)

- (BOOL)checkDataResponse:(ZMDataResponse *)response
{
    return YES;// 先屏蔽
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
    // 0 是一个非常难处理的问题，因为默认就是0
    if ([response.code intValue]==0 && response.code && nil == response.error) {
        if (!response.isHiddenTips) {
            [self showHudTipStr:response.msg];
        }
        return YES;
    }
    else {
        //        if (response.code == 401) {
        //            // 用户未登录
        //            if ([UserInfoModel isLogin]) {
        //                [UserInfoModel doLogout];
        //                [LoginViewController gotoLoginViewController];
        //            }
        //        }
        //        if ([response.msg isKindOfClass:[NSDictionary class]]) {
        //            // 需要二次认证, 直接登出
        //            if (response.msg[@"two_factor_auth_required_login"]) {
        //                [UserInfoModel doLogout];
        //                // 避免弹框
        //                return YES;
        //            }
        //        }
        if (response.error) {
            [self showError:response.error];
        }
        else {
            if ([response.msg isKindOfClass:[NSDictionary class]]) {
                NSDictionary *msg = (NSDictionary *)response.msg;
                [self showHudTipStr:[msg allValues].firstObject];
            }
            else if ([response.msg isKindOfClass:[NSString class]]) {
                [self showHudTipStr:response.msg];
            }
            else {
                [self showHudTipStr:@"请求错误"];
            }
        }
        return NO;
    }
#pragma clang diagnostic pop
}


-(id)handleResponse:(id)responseJSON{
    return [self handleResponse:responseJSON autoShowError:YES];
}
-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError{
    NSError *error = nil;
    //status为非1值时，表示有错
    NSNumber *resultCode = [responseJSON valueForKeyPath:@"status"];
    // 防空
    if ([resultCode isKindOfClass:[NSNull class]] || resultCode==nil || [resultCode isEqual:@"<null>"]) {
        error = [NSError errorWithDomain:kNetPath_Code_Base code:40000 userInfo:responseJSON];
        if (autoShowError) {
            [self showError:error];
        }
        return error;
    }
    if (resultCode.intValue != 0) {
        
        error = [NSError errorWithDomain:kNetPath_Code_Base code:resultCode.intValue userInfo:responseJSON];
        if (autoShowError) {
            [self showError:error];
        }
        if ([[responseJSON valueForKeyPath:@"msg"] isEqualToString:@"用户不存在"] || [[responseJSON valueForKeyPath:@"msg"] isEqualToString:@"用户状态异常"]) {
//            if ([UserInfoModel isLogin]) {
//                [UserInfoModel setLoginSatus:NO];
//                [[UserInfoModel new] updateUserInfo];

//                [self.getKeyWindowRootViewController.navigationController pushViewController:[LoginViewController new] animated:YES];
//                [[RootTabBarController sharedTabBarController]loginOnlyUserBeDeleted];
//            }
        }
        
        
        /*code = "MEMBER_10020";
         msg = "用户不存在";
         status = "-1";*/
        if ([responseJSON[@"code"] isEqualToString:@"MEMBER_10020"]) {
            DLog(@"\n===用户未登录===");
//            [UserInfoModel doLogout];
        }
        if (resultCode.intValue == 1000) {//用户未登录
            DLog(@"\n===用户未登录===");
            //            [Login doLogout];
            //            [((AppDelegate *)[UIApplication sharedApplication].delegate) setupLoginViewController];
        }
    }
    return error;
}
- (BOOL)showError:(NSError *)error{
    NSString *tipStr = [self tipFromError:error];
    [self showHudTipStr:tipStr];
    return YES;
}
- (void)showHudTipStr:(NSString *)tipStr{
    
    // 存在就返回
//    MBProgressHUD *org = nil;
//    if ((org = [MBProgressHUD HUDForView:kKeyWindow])){
//        org.yOffset+=40;
//    }
    // 存在就删除
//    [MBProgressHUD hideHUDForView:kKeyWindow animated:YES];
//    if (tipStr && tipStr.length > 0) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0];
//        hud.detailsLabelText = tipStr;
//        hud.margin = 10.f;
//        hud.removeFromSuperViewOnHide = YES;
//        hud.yOffset = 0;
//        [hud hide:YES afterDelay:1.2];
//    }
    [HUDHelper showCustomAlertMessage:tipStr];
}
- (NSString *)tipFromError:(NSError *)error{
    if (error && error.userInfo) {
        NSMutableString *tipStr = [[NSMutableString alloc] init];
        if ([error.userInfo objectForKey:@"msg"]) {
            [tipStr appendString:[error.userInfo objectForKey:@"msg"]];
        }else if ([error.userInfo[@"info"] isKindOfClass:[NSString class]]){
            [tipStr appendString:error.userInfo[@"info"]];
        }else{
            // 网络状态提示
            if ([error.userInfo objectForKey:@"NSLocalizedDescription"]) {
                tipStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                // 请求失败
            }
//            else if ([error.userInfo objectForKey:@"NSDebugDescription"]) {
//                tipStr = [error.userInfo objectForKey:@"NSDebugDescription"];
//            }
            else{
                [tipStr appendFormat:@"Error Code:%ld description:%@",(long)error.code,error.description];
            }
        }
        return tipStr;
    }
    return nil;
}

- (NSString *)dateFormatWithTimeInterval:(NSTimeInterval)time {
    if(time > 140000000000) {
        time = time / 1000;
    }
    NSDate *updatedTime = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSString *theDay = [dateFormatter stringFromDate:updatedTime];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    if ([theDay isEqualToString:currentDay]) {//当天
        [dateFormatter setDateFormat:@"今天 hh:mm"];
        return [dateFormatter stringFromDate:updatedTime];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"昨天 hh:mm"];
        return [dateFormatter stringFromDate:updatedTime];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] < 86400 * 7) {//间隔一周内
        [dateFormatter setDateFormat:@"EEEE hh:mm"];
        return [dateFormatter stringFromDate:updatedTime];
    } else {//以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
        return [dateFormatter stringFromDate:updatedTime];
    }
}

- (NSString *)dateFormatyyyy_MM_dd:(NSTimeInterval)time {
    if(time > 140000000000) {
        time = time / 1000;
    }
    NSDate *updatedTime = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    return [dateFormatter stringFromDate:updatedTime];
}

- (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format?:@"yyyy-MM-dd hh:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

NSString *NSDocumentsFolder(){
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

NSString *NSCacheFolder(){
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}


- (void)networkReachability {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *trip = @"未知网络";
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                trip = @"未知网络";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                trip = @"WiFi网络";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                CTTelephonyNetworkInfo *telephonyInfo = [CTTelephonyNetworkInfo new];
                
                if ([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
                    trip = @"4G移动网络";
                }else if([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [telephonyInfo.currentRadioAccessTechnology  isEqualToString:CTRadioAccessTechnologyGPRS] || [telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyeHRPD]){
                    trip = @"2G移动网络";
                }else{
                    trip = @"3G移动网络";
                }
            }
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                trip = @"没网络";
                break;
            default:
                break;
        }
        [self showHudTipStr:[NSString stringWithFormat:@"当前网络状态：%@",trip]];
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (UIViewController *)getKeyWindowRootViewController {
    
    UINavigationController *viewController = [RootTabBarController sharedTabBarController].navigationController;
    return viewController.topViewController;
    
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    if (window.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow * tmpWin in windows)
//        {
//            if (tmpWin.windowLevel == UIWindowLevelNormal)
//            {
//                window = tmpWin;
//                break;
//            }
//        }
//    }
//    UIViewController *result = window.rootViewController;
//    while (result.presentedViewController) {
//        result = result.presentedViewController;
//    }
//    if ([result isKindOfClass:[UITabBarController class]]) {
//        result = [(UITabBarController *)result selectedViewController];
//    }
//    if ([result isKindOfClass:[UINavigationController class]]) {
//        result = [(UINavigationController *)result topViewController];
//    }
//    return result;
}

//网络请求
+ (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath{
    if ([self createDirInCache:kPath_ResponseCache]) {
        NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], [requestPath md5Str]];
        BOOL succeed = [NSKeyedArchiver archiveRootObject:data toFile:abslutePath];
        if (!succeed) {
            NSLog(@"requestPath write failuer");
        }
        return succeed;
    }else{
        return NO;
    }
}
+ (id) loadResponseWithPath:(NSString *)requestPath{//返回一个NSDictionary类型的json数据
    NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], [requestPath md5Str]];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:abslutePath];
}

+ (BOOL)deleteResponseCacheForPath:(NSString *)requestPath{
    NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], [requestPath md5Str]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:abslutePath]) {
        return [fileManager removeItemAtPath:abslutePath error:nil];
    }else{
        return NO;
    }
}

+ (BOOL) deleteResponseCache{
    return [self deleteCacheWithPath:kPath_ResponseCache];
}

+ (BOOL) deleteCacheWithPath:(NSString *)cachePath{
    NSString *dirPath = [self pathInCacheDirectory:cachePath];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    bool isDeleted = false;
    if ( isDir == YES && existed == YES )
    {
        isDeleted = [fileManager removeItemAtPath:dirPath error:nil];
    }
    return isDeleted;
}

#pragma mark File M
//获取fileName的完整地址
+ (NSString* )pathInCacheDirectory:(NSString *)fileName
{
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    return [cachePath stringByAppendingPathComponent:fileName];
}
//创建缓存文件夹
+ (BOOL) createDirInCache:(NSString *)dirName
{
    NSString *dirPath = [self pathInCacheDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    BOOL isCreated = NO;
    if ( !(isDir == YES && existed == YES) )
    {
        isCreated = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (existed) {
        isCreated = YES;
    }
    return isCreated;
}

- (NSString *)JsonSting{
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

- (void)telphoneWithNumber:(NSString *)phone{
    
    phone = phone?:@"0755-1234567";
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0) {
        [NSObject.getKeyWindowRootViewController jf_presentAlertControllerTitle:nil message:phone actionTitles:@[@"取消",@"拨打"] handler:^(NSInteger index) {
            if (index==1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]];
            }
        }];

    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phone]] options:@{} completionHandler:nil];
    }
    
}

@end
