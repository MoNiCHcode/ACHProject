//
//  RequestURL.h
//  MuckBoss
//
//  Created by FangZhongli on 16/8/10.
//  Copyright © 2016年 wangqudao. All rights reserved.
//

#ifndef RequestURL_h
#define RequestURL_h

//#define kAdminURL             @"http://wgss.wxplayer.com" // wangushengshi
//#define kAdminURL             @"http://pc.wangushengshi.com" // 测试环境wangushengshi1
//#define kAdminURL             @"http://app.wangushengshi.com" // 正式环境wangushengshi1
//#define kAdminURL             @"http://app.aixiangdao.com" // 正式环境新、

#define kAdminURL             @"http://tadmin.aixiangdao.com" // 测试环境新


#define kNetPath_Code_Base    [NSString stringWithFormat:@"%@/api",kAdminURL]
//#define kWebImageURL(str)     [str rangeOfString:kAdminURL].location!=NSNotFound? str : [NSString stringWithFormat:@"%@%@",kAdminURL,str]
#define kWebImageURL(str)     [NSString stringWithFormat:@"%@%@",kAdminURL,str]

#define kImage_Bundle(_imageName_) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_imageName_ ofType:@"png"]]

// 调试
#ifdef DEBUG
# define DAFLog(fmt, ...) NSLog((fmt), ##__VA_ARGS__);
#else
# define DAFLog(...);
#endif

//static const NSString *kRequestSign = @"73A40Za2a49cBa5K1a1N6b156721bFE29937b35C";

// 通知
//static const NSNotificationName kCountdownEndNotification = @"ZLCountdownEndNotification";// 倒计时结束了
#define kLocationSuccessHome @"kLocationSuccessFromHome"        //附近定位成功后的操作
#define kLocationSuccessNear @"kLocationSuccessFromNear"        //首页定位成功后的操作
#define kLocationSuccess @"kLocationSuccess"        //定位成功后的操作


//typedef void(^requestComplection)(id data, NSError *error);

//#import "ZLUserRequestModel.h"
//#import "ZLRequestModel.h"
//#import "ZLUserRequest.h"
//#import "ZLGoodsRequest.h"
//#import "ZLUserGoodsRequest.h"
//#import "HSUserRelatedRequest.h"
//#import "ZLMerchantRequest.h"
//#import "HSOrderRequest.h"
//#import "HSSubmitOrderRequest.h"
//#import "HSMessageRequest.h"

//typedef enum : NSUInteger {
//    ZLDetailGoodsTypeFavorable = 0,
//    ZLDetailGoodsTypeStoreDay = ZLDetailGoodsTypeFavorable,// 普通商品详情,特惠
//    ZLDetailGoodsTypeFocusShopping,// 集中采购
//    ZLDetailGoodsTypeLimitTime,// 限时抢购
//    ZLDetailGoodsTypeVIP,// 会员日
//    ZLDetailGoodsTypeAnniversary,// 店庆日
//} ZLDetailGoodsType;

#endif /* RequestURL_h */
