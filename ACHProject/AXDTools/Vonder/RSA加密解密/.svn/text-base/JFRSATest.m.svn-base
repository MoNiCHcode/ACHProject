//
//  JFRSATest.m
//  SuperQuick
//
//  Created by wqdmini on 17/1/20.
//  Copyright © 2017年 XiangDaoNet. All rights reserved.
//

#import "JFRSATest.h"
#import "CRSA.h"
#import "Base64.h"

#define PriKey @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAJ2msiGRbzJDoOVJIbDEauZKuiAfpkqzkzOzCCi/6D0k6jR0qm/xFEXQH14LpWwCOkDhhPO8RC2CBx049kWSQd2t76Nk9tsKY4+nA/JZUIj7x/XauNd+D3oWdJILBEXB3SxP4oZ8eQJxYpaUN6nDiCi5W+Q4GrjpYDbNKgEHzSZZAgMBAAECgYBctOktekOkkEZubuoD9A1U7X60Y0g7x4v5q/9RT0D3q9yaCj0r5N3iC/hWKo0Vjd3Jx5SSbBS/miYq1hNkaBSYn9aegxmIunIbK6o6IsyvRCwI45VJsfGINyJsTqjYYUo4qgAVuhcM63pPc9uXsVDV9vGQLY7gkqc2OsfjQd5dzQJBAP4v2HENJ0BFDxFFjoF9y5ryCughpXUY5Kz7iiF5Yhb00vnEaOttyCW8O21tM+CCrfxAX/2RCaZno/p1dVHJRwMCQQCexpKUJw4Ay7D29LHcSBZ/IyNJRpDB2+z9lD4nxrgaubs6LH3vwzHvgiyV6++G8BhRAjNftaa46YP2rJ08YMBzAkEAx4Xg/OSZQd6zdBhIQybuUmLZ4tq+WMtAfPQ5ugrgzypADSR6Qwr6h3xYnY2RohKR5abWcmCN1ZwW4Dug6qD25wJBAIYN+FI4Cz2mvRo1DTqEbuIXI8LJXo0fB6AuGrBwup5t9GMwj3/w2Wd0C/rkwk62xoEXD5Mehs6W8oFBylvhAHsCQQD8CRmctR/XOq7I+kwysmLAx9RC6HYp8xwECp6C7v9wQe7sFZmkNUjG43R1PMUH2EPl/vT+p/W0Xksou/AFFh9L"

#define PubKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCdprIhkW8yQ6DlSSGwxGrmSrogH6ZKs5Mzswgov+g9JOo0dKpv8RRF0B9eC6VsAjpA4YTzvEQtggcdOPZFkkHdre+jZPbbCmOPpwPyWVCI+8f12rjXfg96FnSSCwRFwd0sT+KGfHkCcWKWlDepw4gouVvkOBq46WA2zSoBB80mWQIDAQAB"

@implementation JFRSATest

- (void)setUP{
    CRSA *cc = [CRSA shareInstance];
    // 写入公钥
    [cc writePukWithKey:PubKey];
    [cc writePrkWithKey:PriKey];
    NSDate *tmpStartData = [NSDate date];
    for (int i = 0; i < 100; i ++) {
        [self test];
    }
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    NSLog(@"cost time  = %f", deltaTime / 100.0);
}

- (void)test {
    static NSInteger num = 0;
    
    //      CRSA采用PCKS8证书类型
    //      生成网址： http://web.chacuo.net/netrsakeypair
    //      简书：    http://www.jianshu.com/p/4580bee4f62f
    //      如果对你有所帮助，希望你能给个star。
    //      如果你需要帮助，欢迎拿红包砸我。
    //      欢迎大家分享出自己的服务端代码，让这个库更加完善。
    
    CRSA *cc = [CRSA shareInstance];
    // 写入公钥
    [cc writePukWithKey:PubKey];
    [cc writePrkWithKey:PriKey];
    NSString *oo = @"这本应该是iOS中一个标准、内置的解决空table和collection view的方式。默认的如果你的table view是空的，屏幕就是空的。但这不是你能提供的最好的用户体验。这本应该是iOS中一个标准、内置的解决空table和collection view的方式。默认的如果你的table view是空的，屏幕就是空的。但这不是你能提供的最好的用户体验。";
    
    // 🌰1. 加密支持中文 不需要转码
    // 加密过程： str -> utf8编码 -> 字符串分割 -> 循环加密 -> 拼接 -> 结果
    // 解密过程： str -> 字符串分割 -> 循环解密 -> 拼接 -> utf8解码 -> 原字符串
    
    //    NSString *en = [cc encryptByRsaWith:oo keyType:(KeyTypePrivate)];
    //    NSString *de = [cc decryptByRsaWith:en keyType:(KeyTypePublic)];
    //    if ([oo isEqualToString:de]) {
    //        NSLog(@"**********************************");
    //        NSLog(@"*          解密成功！             *");
    //        NSLog(@"*          解密成功！             *");
    //        NSLog(@"*          解密成功！             *");
    //        NSLog(@"*         成功  %ld 次            *" , ++ num);
    //        NSLog(@"**********************************");
    //    }
    
    
    // 🌰2. 加解密不支持中文 需要预先转码 配套Java代码在项目内
    
    NSString *en1 = [cc encryptByRsaWithCutData:[oo base64EncodedString] keyType:(KeyTypePrivate)];
    NSString *de1 = [cc decryptByRsaWithCutData:en1 keyType:(KeyTypePublic)];
    if ([oo isEqualToString:[de1 base64DecodedString]]) {
        NSLog(@"**********************************");
        NSLog(@"*          解密成功！             *");
        NSLog(@"*          解密成功！             *");
        NSLog(@"*          解密成功！             *");
        NSLog(@"*         成功  %ld 次            *" , ++ num);
        NSLog(@"**********************************");
    }
    
    
    
}

+ (void)temp{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    NSDictionary *paramDict = [[self class] creatMd5SignParamDict:@{@"app":@"Bts",@"class":@"PayPrepareOrder"}];
    
    [manager POST:@"http://wangu.kjmobi.com/api" parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"----%@",responseObject);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"----error--%@",error.description);
    }];
}

// 请求参数RSA加密
+ (NSMutableDictionary *)creatMd5SignParamDict:(NSDictionary *)dict{
    time_t now;
    time(&now);
    NSString *time_stamp  = [NSString stringWithFormat:@"%ld", now];
    NSString *nonce_str	= [[self class] md5:time_stamp];
    NSString *secret_key = @"O8tImgCcf*XgObVqLSbg2DoH4XM6$0to";
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [paramDict setObject:nonce_str forKey:@"nonce_str"];
    [paramDict setObject:time_stamp forKey:@"timestamp"];
    [paramDict setObject:secret_key forKey:@"secret_key"];
    [paramDict setObject:@"ios" forKey:@"client"];
    NSString *params = [[self class] createMd5Sign:paramDict];

    
    
    NSString *sign = [[self class] encrytRSAWith:params];
    
    [paramDict removeObjectForKey:@"secret_key"];
    [paramDict setObject:sign forKey:@"sign"];
    
    
    return paramDict;
}

+ (NSString *)encrytRSAWith:(NSString *)params{
    NSString *public_key = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDMNkDkxeB0ZXNZqyI5bAa+FggkI1rqqh+JePgTcJ4nSr5dmYNPznI5UW5gjEvnSx782xUJTFBO6wFmK9XtXolZKVwHVJFEUi0eyezVM+e5JqljqcSXM8OU5Hkm60oVyjtG/xDc/hCvBTv5t9QIEcMxdTFIMlPQPem8V3RJD8m/CwIDAQAB";
    NSString *private_key = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMw2QOTF4HRlc1mrIjlsBr4WCCQjWuqqH4l4+BNwnidKvl2Zg0/OcjlRbmCMS+dLHvzbFQlMUE7rAWYr1e1eiVkpXAdUkURSLR7J7NUz57kmqWOpxJczw5TkeSbrShXKO0b/ENz+EK8FO/m31AgRwzF1MUgyU9A96bxXdEkPyb8LAgMBAAECgYAWcCunN3rXL0KCasRi7NS81Czm05+swy6d61XOxQQLqzHJlRGRlkyEscbgAupgKqfn/qaME/+K/FV2BYEHCOksWYetbDatgs8mdbzlwBzVuD1Vji9z087MT5c4SmgyDLvUJMNhtS7zvD0h2RIPcvejWwuZKpkSsdjLQ0AjyKKoWQJBAPDT5TSe0IZzMiixAtxRw9+yMZfpNYFzDBCh22golrHJFrRVdtaBRr6mpz1fPyKM6KpNJD5j4VVDJwy6Bg6+bJUCQQDZE9A4VMuNj26JJzhxciEJkVmwsmQtA1mRIREUjReJ/8FsjrsQm0i8S8zoT5SaWYDnFZ6PWyS8OwnldxHhkPUfAkEA1X3jKTzI+wfQJYaWVJ4fmIUttc/F4RYOUghKqxGgVcdAW2mQSiSchJLUm3F+VLC56Y8tXCnLLnyzd3LJv/RL6QJBAIdnK3cntTxcnlcgxr1EskTUjDyCWagWMdUr6gqGo4spo84CDb8jDTCem3bAxPGuKJB71MaY1IYw0VB3gAjSMYMCQA5Q1E/2vIJFvR+33RtlKNqAbZiURsEBJInMcJkeaQn+K4tHdPB0ci9g+oSRvrmr7EYeIcDTi4SWA2OA0u7dolw=";
    CRSA *cc = [CRSA shareInstance];
    // 写入公钥
    [cc writePukWithKey:public_key];
    [cc writePrkWithKey:private_key];
    
    
    NSString *sign = [cc encryptByRsaWith:params keyType:(KeyTypePublic)];
    
    NSString *deSign = [cc decryptByRsaWith:sign keyType:(KeyTypePrivate)];
    NSLog(@"------Sign-->%@==deSign=>%@",sign,deSign);
    return sign;
}

//创建package签名
+ (NSString*) createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
//        if (![[dict objectForKey:categoryId] isKindOfClass:[NSString class]] && ![dict objectForKey:categoryId]) {
//            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
//            
//        }
//        else if (![[dict objectForKey:categoryId] isEqualToString:@""]
//            && ![categoryId isEqualToString:@"sign"]
//            && ![categoryId isEqualToString:@"secret_key"]
//            )
//        {
//            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
//        }
        if (![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"secret_key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
        
    }
    //添加key字段
    [contentString appendFormat:@"secret_key=%@", [dict objectForKey:@"secret_key"]];
    //得到MD5 sign签名
    NSString *md5Sign = [[self class] md5:contentString];
    
    //输出Debug Info
    
    return md5Sign.lowercaseString;
}


//md5 encode 这是全大写的
+(NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}

/*
 签名算法
 签名生成的通用步骤如下：
 第一步，设所有发送或者接收到的数据为集合M，将集合M内非空参数值的参数按照参数名ASCII码从小到大排序（字典序），使用URL键值对的格式（即key1=value1&key2=value2…）拼接成字符串stringA。
 特别注意以下重要规则：
 ◆ 参数名ASCII码从小到大排序（字典序）；
 ◆ 如果参数的值为空不参与签名；
 ◆ 参数名区分大小写；
 ◆ 验证调用返回或微信主动通知签名时，传送的sign参数不参与签名，将生成的签名与该sign值作校验。
 ◆ 微信接口可能增加字段，验证签名时必须支持增加的扩展字段
 第二步，在stringA最后拼接上key得到stringSignTemp字符串，并对stringSignTemp进行MD5运算，再将得到的字符串所有字符转换为大写，得到sign值signValue。
 key设置路径：微信商户平台(pay.weixin.qq.com)-->账户设置-->API安全-->密钥设置
 举例：
 假设传送的参数如下：
 appid：	wxd930ea5d5a258f4f
 mch_id：	10000100
 device_info：	1000
 body：	test
 nonce_str：	ibuaiVcKdpRxkhJA
 第一步：对参数按照key=value的格式，并按照参数名ASCII字典序排序如下：
 stringA="appid=wxd930ea5d5a258f4f&body=test&device_info=1000&mch_id=10000100&nonce_str=ibuaiVcKdpRxkhJA";
 第二步：拼接API密钥：
 
 stringSignTemp="stringA&key=192006250b4c09247ec02edce69f6a2d"
 sign=MD5(stringSignTemp).toUpperCase()="9A0A8659F005D6984697E2CA0A9CF3B7"
 最终得到最终发送的数据：
 
 <xml>
 <appid>wxd930ea5d5a258f4f</appid>
 <mch_id>10000100</mch_id>
 <device_info>1000<device_info>
 <body>test</body>
 <nonce_str>ibuaiVcKdpRxkhJA</nonce_str>
 <sign>9A0A8659F005D6984697E2CA0A9CF3B7</sign>
 <xml>
 
 */


@end
