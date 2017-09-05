//
//  ZMDataRequest.h
//  Goldhead
//
//  Created by FZHONGLI on 16/2/16.
//  Copyright © 2016年 chinasilex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ZMDataResponse.h"
#define ZMAPIDomain kNetPath_Code_Base

typedef enum : NSUInteger {
    ZMDataRequestTypeDefault=0,
    ZMDataRequestTypeDiagnose,// 特别诊断
} ZMDataRequestType;


@interface ZMDataRequest : NSObject



@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSDictionary *params;
/** 请求提示 为空不显示 */
@property (nonatomic, strong)NSString *tipStr;
/**  是否需要离线缓存 */
@property (nonatomic, assign)BOOL needCache;
@property (nonatomic, assign)ZMDataRequestType requestType;

+ (instancetype)request;

- (NSDictionary *)parametersMap;
- (NSDictionary *)buildParameters;
- (void)prepareForRequest;
- (void)readyForRequest;

- (void)getWithSuccess:(void (^)(ZMDataResponse *responseObject))success
               failure:(void (^)(NSError *error))failure;

- (void)postWithSuccess:(void (^)(ZMDataResponse * responseObject))success
                failure:(void (^)(NSError *error))failure;

- (ZMDataResponse *)getResponseParser:(id)response;
- (ZMDataResponse *)postResponseParser:(id)response;

- (void)postWithSuccess:(void (^)(ZMDataResponse *responseObject))success
                failure:(void (^)(NSError *error))failure
                   file:(NSDictionary *)file;

@end


@interface ZMPageRequest : ZMDataRequest

@property (nonatomic, assign)  NSInteger pageNo;
@property (nonatomic, assign)  NSInteger pageSize;

@end

@interface ZMQueryRequest : ZMDataRequest

@property (nonatomic, assign)  NSInteger actionCode;
@property (nonatomic, assign)  NSInteger operationType;
@property (nonatomic, assign)  NSInteger pageNo;
@end

