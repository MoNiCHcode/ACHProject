//
//  NSObject+Common.h
//  Lilai01
//
//  Created by FangZhongli on 15/12/15.
//  Copyright © 2015年 向导. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMDataResponse.h"

@interface NSObject (Common)
NSString *NSDocumentsFolder(void);
NSString *NSCacheFolder(void);

- (BOOL)checkDataResponse:(ZMDataResponse *)response;
-(id)handleResponse:(id)responseJSON;
-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError;
- (BOOL)showError:(NSError *)error;
- (void)showHudTipStr:(NSString *)tipStr;
- (NSString *)dateFormatWithTimeInterval:(NSTimeInterval)time;
- (NSString *)dateFormatyyyy_MM_dd:(NSTimeInterval)time;
- (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;
- (void)networkReachability;
- (UIViewController *)getKeyWindowRootViewController;
+ (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath;
+ (id) loadResponseWithPath:(NSString *)requestPath;

- (NSString *)JsonSting;
// 拨打电话，带弹窗
- (void)telphoneWithNumber:(NSString *)phone;
@end
