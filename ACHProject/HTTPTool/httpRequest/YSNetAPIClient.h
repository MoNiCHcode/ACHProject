//
//  YSNetAPIClient.h
//  EternalSpirit
//
//  Created by wqdmini on 17/2/16.
//  Copyright © 2017年 wangqudao. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface YSNetAPIClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
- (void)requestPostJsonDataWithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)requestPostJsonDataToLocation:(BOOL)isCache WithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block;

- (void)uploadImage:(UIImage *)image name:(NSString *)name withParams:(NSDictionary*)params
       successBlock:(void (^)(id data, NSError *error))successBlock
      progerssBlock:(void (^)(CGFloat progressValue))progress;

- (void)uploadImages:(NSArray *)images imageKeys:(NSArray *)imageKeys params:(NSDictionary *)params
        successBlock:(void (^)(id data, NSError *error))successBlock
       progerssBlock:(void (^)(CGFloat progressValue))progress;
@end
