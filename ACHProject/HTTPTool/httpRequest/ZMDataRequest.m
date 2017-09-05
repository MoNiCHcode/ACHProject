//
//  ZMDataRequest.m
//  Goldhead
//
//  Created by FZHONGLI on 16/2/16.
//  Copyright © 2016年 chinasilex. All rights reserved.
//

#import "ZMDataRequest.h"
#import "MBProgressHUD.h"
#import "NSObject+Common.h"


static AFHTTPSessionManager *_manager;

@interface ZMDataRequest ()
@end

@implementation ZMDataRequest
+ (instancetype)request
{
    return [[self alloc] init];
}

- (id)init {
    self = [super init];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
        manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        _manager = manager;
    });
    
    return self;
}
// 请求分为了四个阶段，请求准备，参数填充，完成准备，发起请求，数据解析。
- (NSDictionary *)parametersMap
{
//    return @{@"songName":@"gqMc"};///< key为属性，value为请求参数
    return nil;
}

- (NSDictionary *)buildParameters
{
//    return @{@"pageSize":@(100)};
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSDictionary *maps = [self parametersMap];
    for (NSString *key in maps.allKeys) {
        id val = [self valueForKey:key];
        if (val) {
            [params setObject:val forKey:maps[key]];
        }
    }
    return [NSDictionary dictionaryWithDictionary:params];
}

- (void)prepareForRequest
{
    self.path = @"";// 当前工程不需要了！！！
}

- (void)readyForRequest
{
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.params];
//    [params setObject:@(self.page) forKey:@"page"];
//    [params setObject:@(self.pageSize) forKey:@"pageSize"];
//    self.params = [NSDictionary dictionaryWithDictionary:params];
}

- (void)getWithSuccess:(void (^)(ZMDataResponse *responseObject))success
               failure:(void (^)(NSError *error))failure
{
    [self prepareForRequest];
    self.params = [self buildParameters];
    
    NSAssert(self.path != nil, @"Path can't be nil.");
    
//    NSString *encodedUrl = [self.path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self readyForRequest];
    
    [_manager GET:ZMAPIDomain parameters:self.params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success([self getResponseParser:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
    
}

- (void)postWithSuccess:(void (^)(ZMDataResponse *responseObject))success
                failure:(void (^)(NSError *error))failure
{
    [self prepareForRequest];
    self.params = [self buildParameters];
    
    NSAssert(self.path != nil, @"Path can't be nil.");
    
    [self readyForRequest];
    
    MBProgressHUD *hud = nil;
    UIView *hudBgView = nil;
    if (_tipStr) {
        if (hud==nil || hudBgView==nil) {
            hudBgView = [UIView viewWithFrame:CGRectMake(0, kBaseNavHeight, kBaseWidth, kBaseHeight-kBaseNavHeight) backgroundColor:[UIColor clearColor] superView:self.getKeyWindowRootViewController.view];
            hud = [MBProgressHUD HUDForView:hudBgView];
            hud = [MBProgressHUD showHUDAddedTo:hudBgView animated:YES];
            hud.removeFromSuperViewOnHide = YES;
        }
        hud.labelText = _tipStr;
        
    }
    
    DLog(@"\n===========request===========\n%@%@?\n%@", _manager.baseURL,self.path, self.params);
    
    //所有 Get 请求，增加缓存机制
    NSMutableString *localPath = [self.path mutableCopy];
    if (self.params) {
        [localPath appendString:self.params.description];
    }
    
    [_manager POST:ZMAPIDomain parameters:self.params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        // 离线数据
        if (_needCache) {
            if ([responseObject[@"status"] integerValue]==0) {
                [NSObject saveResponseData:responseObject toPath:localPath];
            }else{
                responseObject = [NSObject loadResponseWithPath:localPath];
            }
        }        
        DLog(@"responseString-----%@",responseObject);
        if (_requestType == ZMDataRequestTypeDiagnose) {
            if (success) success([[ZMDataResponse alloc] initWithResponse:responseObject dataModleClass:nil responseType:ZMDataResponseTypeDiagnose]);
        }else{
            if (success) success([self postResponseParser:responseObject]);
        }
        
        // 移除请求提示
        if (hud) {
            [hud hideAnimated:YES];
            [hudBgView removeFromSuperview];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showError:error];
        if (failure) failure(error);
//        ZMDataResponse *dataResponse = [[ZMDataResponse alloc] init];
//        dataResponse.error = error;
//        if (success) success(dataResponse);
        
        // 移除请求提示
        if (hud) {
            [hud hideAnimated:YES];
            [hudBgView removeFromSuperview];
        }
        
        // 离线数据
        if (_needCache) {
            id responseObject = [NSObject loadResponseWithPath:localPath];
            if (responseObject) {
                if (_requestType == ZMDataRequestTypeDiagnose) {
                    if (success) success([[ZMDataResponse alloc] initWithResponse:responseObject dataModleClass:nil responseType:ZMDataResponseTypeDiagnose]);
                }else{
                    if (success) success([self postResponseParser:responseObject]);
                }
            }
        }
    }];
    
}

- (void)postWithSuccess:(void (^)(ZMDataResponse *responseObject))success
                failure:(void (^)(NSError *error))failure
                   file:(NSDictionary *)file
{
    [self prepareForRequest];
    self.params = [self buildParameters];
//    self.path = @"upload";
    NSAssert(self.path != nil, @"Path can't be nil.");
    [self readyForRequest];
    NSString *url = [NSString stringWithFormat:@"%@%@", ZMAPIDomain, self.path];
    
    // Data
    NSData *data;
    NSString *name, *fileName;
    
    if (file) {
        UIImage *image = file[@"image"];
        
        // 缩小到最大 800x800
        // image = [image scaledToMaxSize:CGSizeMake(500, 500)];
        
        // 压缩
        data = UIImageJPEGRepresentation(image, 1.0);
        if ((float)data.length/1024 > 1000) {
            data = UIImageJPEGRepresentation(image, 1024*1000.0/(float)data.length);
        }
        
        name = file[@"name"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        fileName = [NSString stringWithFormat:@"%@_%@.jpg", @"HuijiUpload_", str];
//        fileName = file[@"fileName"];
    }
    
    MBProgressHUD *hud = nil;
    hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.labelText = @"正在上传图片...";
//    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.removeFromSuperViewOnHide = YES;
    
    DLog(@"\n===========request===========\n%@%@?\n%@", _manager.baseURL,self.path, self.params);
    
    
    [_manager POST:url parameters:self.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (file) {
            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"总大小：%lld,当前大小:%lld",uploadProgress.totalUnitCount,uploadProgress.completedUnitCount);
//        hud.progress = uploadProgress
//        CGFloat progressValue = (float)totalBytesWritten/(float)totalBytesExpectedToWrite;
        hud.progress = (float)uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        DLog(@"responseString-----%@",responseObject);
        if (success) success([self postResponseParser:responseObject]);
        [hud hide:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showError:error];
        if (failure) failure(error);
        [hud hide:YES];
    }];
    
}

- (ZMDataResponse *)getResponseParser:(id)response
{
    return [[ZMDataResponse alloc] initWithResponse:response];
}

- (ZMDataResponse *)postResponseParser:(id)response
{
    return [[ZMDataResponse alloc] initWithResponse:response];
}


@end

@implementation ZMPageRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageNo = 1;
        self.pageSize = 30;
    }
    return self;
}

- (void)readyForRequest
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.params];
    [params setObject:@(self.pageNo) forKey:@"page"];
    [params setObject:@(self.pageSize) forKey:@"number"];
    self.params = [NSDictionary dictionaryWithDictionary:params];
}

@end

@implementation ZMQueryRequest

- (void)readyForRequest {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.params];
    [params setObject:@(self.actionCode) forKey:@"actionCode"];
    [params setObject:@(self.operationType) forKey:@"operationType"];
    [params setObject:@"tokenTOKEN" forKey:@"token"];
    if (self.pageNo>=1) {
        [params setObject:@(self.pageNo) forKey:@"pageNo"];
    }
    self.params = [NSDictionary dictionaryWithDictionary:params];
}
@end

