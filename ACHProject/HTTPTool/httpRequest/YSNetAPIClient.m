//
//  YSNetAPIClient.m
//  EternalSpirit
//
//  Created by wqdmini on 17/2/16.
//  Copyright © 2017年 wangqudao. All rights reserved.
//

#import "YSNetAPIClient.h"
#import "JFRSATest.h"

#define ZMAPIDomain kNetPath_Code_Base  //粘贴过来
#define Code_CookieData      @"sessionCookies"

@implementation YSNetAPIClient
+ (instancetype)sharedClient{
    static dispatch_once_t onceToken;
    static YSNetAPIClient *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [YSNetAPIClient manager];
        manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    });
    return manager;
}
- (void)requestPostJsonDataWithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block {
    
    [self requestPostJsonDataToLocation:NO WithParams:params andBlock:block];
}

- (void)requestPostJsonDataToLocation:(BOOL)isCache WithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block{
    //所有 Get 请求，增加缓存机制
    NSMutableString *localPath = kNetPath_Code_Base.mutableCopy;
    [localPath appendString:params.description];
    
    // 有缓存先显示咯
//    if (isCache) {
//        id responseObject = [NSObject loadResponseWithPath:localPath];
//        id error = [self handleResponse:responseObject autoShowError:YES];
//        if (responseObject) {
//            block(responseObject, error);
//        }
//    }
    
    NSString *path = kNetPath_Code_Base;
   
    
#warning 访问本机数据使用
//    path = [NSString stringWithFormat:@"%@?app=%@&class=%@",kNetPath_Code_Base,params[@"app"],params[@"class"]];
    
    // RSA加密
    params = [JFRSATest creatMd5SignParamDict:params];
    NSLog(@"%@",params);
    
    [self POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        responseObject  = [NSJSONSerialization JSONObjectWithData:[ViewController replaceNoUtf8:responseObject] options:NSJSONReadingAllowFragments error:nil];
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        DAFLog(@"\n===========response===========\n%@:\n%@", params, responseObject);
        id error = [self handleResponse:responseObject autoShowError:YES];
        NSLog(@"%@",responseObject);
        if (error) {
            block([NSObject loadResponseWithPath:localPath], error);
        }else{
            if (isCache) {
                [NSObject saveResponseData:responseObject toPath:localPath];
            }
            block(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DAFLog(@"\n===========failureresponse===========\n%@:\n%@", params, error.localizedDescription);
        [self showError:error];
        block(isCache?[NSObject loadResponseWithPath:localPath]:nil,error);
    }];
}


- (void)cancelRequest {
    [self.operationQueue cancelAllOperations];
}

+ (void)saveCookieData{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookies) {
        // Here I see the correct rails session cookie
        DAFLog(@"\nSave cookie: \n====================\n%@", cookie);
    }
    
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: cookies];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: Code_CookieData];
    [defaults synchronize];
}
+ (void)removeCookieData{
    NSURL *url = [NSURL URLWithString:ZMAPIDomain];
    if (url) {
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
        for (int i = 0; i < [cookies count]; i++) {
            NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            DAFLog(@"\nDelete cookie: \n====================\n%@", cookie);
        }
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:Code_CookieData];
    [defaults synchronize];
}

- (void)uploadImage:(UIImage *)image name:(NSString *)name withParams:(NSDictionary*)params
       successBlock:(void (^)(id data, NSError *error))successBlock
      progerssBlock:(void (^)(CGFloat progressValue))progress{
    
    if (!image) {
        return;
    }
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    if ((float)data.length/1024 > 1000) {
        data = UIImageJPEGRepresentation(image, 1024*1000.0/(float)data.length);
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", @"global_key", str];
    DAFLog(@"\nuploadImageSize\n%@ : %.0f", fileName, (float)data.length/1024);
    DAFLog(@"\n===========request===========image:%@\n%@?\n%@", name,kAdminURL, params);
    
    params = [JFRSATest creatMd5SignParamDict:params];
    
    [self POST:kNetPath_Code_Base parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
        DAFLog(@"image.data------%lu",(unsigned long)data.length);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress((float)uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        DAFLog(@"Success: ***** %@", responseObject);
        id error = [self handleResponse:responseObject];
        if (error) {
            successBlock(nil, error);
        }else{
            successBlock(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DAFLog(@"Error: ***** %@", error);
        successBlock(nil, error);
        [self showError:error];
    }];
}

- (void)uploadImages:(NSArray *)images imageKeys:(NSArray *)imageKeys params:(NSDictionary *)params
        successBlock:(void (^)(id data, NSError *error))successBlock
       progerssBlock:(void (^)(CGFloat progressValue))progress {
    
    params = [JFRSATest creatMd5SignParamDict:params];
    
    [self POST:kNetPath_Code_Base parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [images enumerateObjectsUsingBlock:^(UIImage *upImage, NSUInteger idx, BOOL *stop) {
            {
                NSData *data = UIImageJPEGRepresentation(upImage, 1.0);
                if ((float)data.length/1024 > 1000) {
                    data = UIImageJPEGRepresentation(upImage, 1024*1000.0/(float)data.length);
                }
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                [formData appendPartWithFileData:data name:imageKeys[idx] fileName:fileName mimeType:@"image/jpeg"];
            }
        }];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            progress((float)uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        DAFLog(@"Success: ***** %@", responseObject);
        id error = [self handleResponse:responseObject];
        if (error) {
            successBlock(nil, error);
        }else{
            successBlock(responseObject, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DAFLog(@"Error: ***** %@", error);
        successBlock(nil, error);
        [self showError:error];
    }];
}

+ (void)postUpImagesWithApiName:(NSString *)apiName parameters:(NSDictionary *)parameters images:(NSArray *)images imageParams:(NSArray *)imageParams andBlock:(void (^)(id data, NSError *error))block
{
    NSString *path = kNetPath_Code_Base;//[NSString stringWithFormat:@"%@%@",ZMAPIDomain,apiName];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    DAFLog(@"\n===========request===========image:%@\n%@?\n%@", imageParams,path, parameters);
    
    parameters = [JFRSATest creatMd5SignParamDict:parameters];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [images enumerateObjectsUsingBlock:^(UIImage *upImage, NSUInteger idx, BOOL *stop) {
            {
                NSData *data = UIImageJPEGRepresentation(upImage, 1.0);
                if ((float)data.length/1024 > 1000) {
                    data = UIImageJPEGRepresentation(upImage, 1024*1000.0/(float)data.length);
                }
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                [formData appendPartWithFileData:data name:imageParams[idx] fileName:fileName mimeType:@"image/jpeg"];
            }
        }];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress){} completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            DAFLog(@"\n===========response===========\n%@", responseObject);
            id error = [self handleResponse:responseObject autoShowError:YES];
            if (error) {
                block(nil, error);
            }else{
                block(responseObject, nil);
            }
        }
    }];
    [uploadTask resume];
}

- (void)getJSESSIONID_response:(NSHTTPURLResponse *)response
{
    if ([response respondsToSelector:@selector(allHeaderFields)])
    {
        // 取得所有的请求的头
        NSDictionary *dictionary = [response allHeaderFields];
        NSString *sessionString = dictionary[@"Set-Cookie"];
        //判断是否有新的id
        if ([sessionString hasPrefix:@"JSESSIONID="])
        {
            NSArray* sessionArray = [sessionString componentsSeparatedByString: @";"];
            NSString *sessionId = sessionArray[0];
            NSUserDefaults *userDF = [NSUserDefaults standardUserDefaults];
            [userDF setObject:sessionId forKey:@"UserSessionId"];
            [userDF synchronize];
            DAFLog(@"sessionId---%@\n%@",sessionId,dictionary);
        }
    }
}

- (NSString *)setJSESSIONID_request
{
    NSUserDefaults *userDF = [NSUserDefaults standardUserDefaults];
    NSString *sessionId = [userDF objectForKey:@"UserSessionId"];
    if (sessionId) {
        return sessionId;
    }
    return nil;
}


@end
