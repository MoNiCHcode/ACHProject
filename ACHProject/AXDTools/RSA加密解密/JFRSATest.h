//
//  JFRSATest.h
//  SuperQuick
//
//  Created by wqdmini on 17/1/20.
//  Copyright © 2017年 XiangDaoNet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "AFNetworking.h"

@interface JFRSATest : NSObject
+ (void)temp;
// 请求参数RSA加密
+ (NSMutableDictionary *)creatMd5SignParamDict:(NSDictionary *)dict;
+ (NSString *)encrytRSAWith:(NSString *)params;
@end
