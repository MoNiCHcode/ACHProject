//
//  Helper.h
//  ACHProject
//
//  Created by chenxiaohong on 2017/8/24.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#ifndef Helper_h
#define Helper_h


// 调试
#ifdef DEBUG
# define DLog(fmt, ...) NSLog((fmt), ##__VA_ARGS__);
#else
# define DLog(...);
#endif

/****颜色*****/
#define AXDColorA(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0]
#define AXDColor(r,g,b)     AXDColorA((r) ,(g) ,(b) ,255)
#define AXDRandomColor      AXDColor(arc4random_uniform(255),arc4random_uniform(255),arc4random_uniform(255))


// color
///< format：0xFFFFFF
#define kHexRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGB(r,g,b)     [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]


#define kColor_main         kHexRGB(0xfcc400) // 黄色
#define kColor_background   kHexRGB(0xf2f2f4)  //背景颜色
#define kColor_line         kHexRGB(0xdedede)  // 线
#define kColor_title        kHexRGB(0x333333) // 标题
#define kColor_content      kHexRGB(0x666666) // 文章
#define kColor_subContent   kHexRGB(0x999999) // 提示
#define kColor_white        kHexRGB(0xffffff) // 白色
#define kColor_gray         kHexRGB(0xdbdbdb) // 灰色
#define kColor_lightgray    kHexRGB(0xf6f6f6) // 亮灰色
//#define kColor_red          kHexRGB(0xf4433e) // 红色
#define kColor_jadeGreen    kHexRGB(0x72cd5d) // 浅绿色
// 首页模块
#define kColor_darkYellow   kHexRGB(0xfea72f) // 深黄色
#define kColor_orangeRed    kHexRGB(0xff6030) // 橙红色
#define kColor_green        kHexRGB(0x72cd5d) // 绿色
#define kColor_blue         kHexRGB(0x1fb7fc) // 蓝色

#define kColor_red          kHexRGB(0xf43030) // 红色
#define kColor_button       kHexRGB(0x806400) // 按钮
#define kColor_textpl       kHexRGB(0xcccccc) // textfile提示

#define kFontSize_navTitle   [UIFont boldSystemFontOfSize:18] // 导航标题，大按钮
#define kFontSize_title      [UIFont systemFontOfSize:15] // 标题
#define kFontSize_boldtitle  [UIFont boldSystemFontOfSize:15] // 粗标题
#define kFontSize_content    [UIFont systemFontOfSize:12] // 内容
#define kFontSize_content2    [UIFont systemFontOfSize:13] // 内容
#define kFontSize_content3    [UIFont systemFontOfSize:14] // 内容
#define kFontSize_subContent [UIFont systemFontOfSize:10] // 提示






#pragma mark ----------------------------------SIZE---------------------------------------------

#define kBaseOriginX        0
#define kBaseOriginY        0
#define kBaseNavHeight      64
#define kbaseTabBarHeight   50
#define kBaseWidth     [UIScreen mainScreen].bounds.size.width
#define kBaseHeight    [UIScreen mainScreen].bounds.size.height

#define kBaseScale_width   kBaseWidth / 320.0
#define kWidth_paddingLeft 15
#define kHeight_Line       0.5


#define kSetPlaceholderColor   @"_placeholderLabel.textColor"  //修改默认字体颜色
#define FontSize(S)[UIFont fontWithName:@"FZXiHei--YS1-0" size:S]



#pragma mark ------------------------------Weakfiy--------------------------------------------------
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#pragma mark ------------------------------单例类---------------------------------------------

// .h文件
#define SKSingleH(name) + (instancetype)shared##name;

// .m文件
#define SKSingleM(name) \
static id _instance = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}


#pragma mark ------------------------------常用代码---------------------------------------------

#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define MainStoryBoard [UIStoryboard storyboardWithName:@"Main" bundle:nil]
//当前导航控制器
#define CurrentNavigationController [KEY_WINDOW visibleViewController].navigationController





//判空
#define checkNull(__X__)  (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]

////数据标记
#define USERDEFAULTS [NSUserDefaults standardUserDefaults]

#define kversion      [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]
#define kStringWithObject(_obj_)   [NSString stringWithFormat:@"%@",_obj_] // 将对象转化为字符串













#endif /* Helper_h */
