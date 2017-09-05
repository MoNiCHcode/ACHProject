//
//  ZMDataResponse.h
//  Goldhead
//
//  Created by FZHONGLI on 16/2/16.
//  Copyright © 2016年 chinasilex. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    ZMDataResponseTypeDefault,
    ZMDataResponseTypeList,
    ZMDataResponseTypePage,
    ZMDataResponseTypeDiagnose,// 特别诊断
} ZMDataResponseType;

@interface ZMDataResponse : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) id        msg;
@property (nonatomic, strong) NSError   *error;
@property (nonatomic, strong) id        data;
@property (nonatomic, strong) NSDictionary *extraData;
@property (nonatomic, assign)BOOL isHiddenTips;// 是否隐藏成功提示 默认yes
/** 未经过解析的源数据 */
@property (nonatomic, strong) id        responseData;

- (NSString *)displayMsg;

- (instancetype)initWithResponse:(id)response;
- (instancetype)initWithResponse:(id)response
                  dataModleClass:(Class)dataModelClass
                    responseType:(ZMDataResponseType)responseType;

@end
