//
//  ZMDataResponse.m
//  Goldhead
//
//  Created by FZHONGLI on 16/2/16.
//  Copyright © 2016年 chinasilex. All rights reserved.
//

#import "ZMDataResponse.h"
#import "MJExtension.h"

@implementation ZMDataResponse
- (instancetype)initWithResponse:(id)response
{
    return [self initWithResponse:response dataModleClass:nil responseType:ZMDataResponseTypeDefault];
}

- (instancetype)initWithResponse:(id)response dataModleClass:(Class)dataModelClass responseType:(ZMDataResponseType)responseType
{
    self = [super init];
    if (self) {
        @try {
            self.code = response[@"status"];
            self.msg = response[@"msg"];
            self.isHiddenTips = YES;
            
//            if (response[@"token"]) {// 保存token
//                [UserInfoModel saveCurrentUserToken:response[@"token"]];
//            }
            self.responseData = response;
//            {
//                if (nil == dataModelClass) {
//                    self.data = response;
//                    [self tempArray:response];
//                }
//                else {
//                    NSError *error = nil;
//                    if (ZMDataResponseTypeDefault == responseType) {
//                        self.data = [dataModelClass mj_objectWithKeyValues:response[@"data"]];
//                    }
//                    else if (ZMDataResponseTypeList == responseType) {
//                        self.data = [dataModelClass mj_objectArrayWithKeyValuesArray:response[@"data"]];
//                        [self tempArray:response];
//                    }
//                    else if (ZMDataResponseTypePage == responseType) {
//                        NSDictionary *pageData = response;
//                        self.data = [dataModelClass mj_objectArrayWithKeyValuesArray:pageData[@"list"]];
//                        self.extraData = [self extraPageInfo:pageData];
//                    }
//                    self.error = error;
//                }
//            }
            {
                self.data = @[@"",@"",@"",@"",@""];
            }
        }
        @catch (NSException *exception) {
            self.error = [NSError errorWithDomain:@"com.Wangqudao" code:1001 userInfo:@{NSLocalizedDescriptionKey:@"Response data format error.", NSLocalizedFailureReasonErrorKey:@"Response data format error."}];
        }
        @finally {
            //
        }
    }
    return self;
}

- (void)tempArray:(id)response {
    if ([response isKindOfClass:[NSArray class]]) {
        /*data =     (
         "<null>"
         );*/
        NSArray *array = response;
        if (array.count) {
            if ([array[0] isEqual:[NSNull null]]) {
                self.data = nil;
            }
        }else{
            self.data = nil;
        }
    }
    if (self.code && [self.code intValue]!=0) {
        self.data = nil;
    }
    /*{
     message = "\U6682\U65e0\U6570\U636e\Uff01";
     resultCode = "-1";
     }*/
}

- (NSDictionary *)extraPageInfo:(NSDictionary *)pageData
{
    NSMutableDictionary *pageInfo = [NSMutableDictionary dictionaryWithDictionary:pageData];
    if (pageInfo[@"list"]) {
        [pageInfo removeObjectForKey:@"list"];
    }
    return [NSDictionary dictionaryWithDictionary:pageInfo];
}

- (NSString *)displayMsg
{
    // TODO: 确认返回形式
    if ([self.msg isKindOfClass:[NSDictionary class]]) {
        NSArray *msgs = [self.msg allValues];
        return [msgs componentsJoinedByString:@"\n"];
    }
    return @"未知错误";
}

@end
