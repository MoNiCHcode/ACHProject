//
//  AXDTabbarController.h
//  ACHProject
//
//  Created by 爱享到 on 2017/7/20.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AXDTabbarControllerDelegate;

@interface AXDTabbarController : UITabBarController


@property(nonatomic,strong)UIView* tabBarView;
@property(nonatomic,weak)id<AXDTabbarControllerDelegate>tabBarDelegate;

@property(nonatomic,strong)NSArray* imagesArray;
@property(nonatomic,strong)NSArray* selectImagesArray;

@property(nonatomic,strong)NSArray* titleArray;
@property(nonatomic,strong)NSArray* selectTitleArray;

@property(nonatomic)CGFloat tabBarHight;

@property(nonatomic)CGFloat itemWidth;//item的宽度，下面的字体会随item的宽度自动改变大小(最大不超过25,超过25，宽度等于25)

@property(nonatomic,strong)UIColor* normalColor;//正常item下的字体颜色(默认灰色)
@property(nonatomic,strong)UIColor* selectColor;//选中item下的字体颜色（默认蓝色）


@property(nonatomic,strong)UIColor* tabBarViewBackgroundColor;//tabBar的背景颜色（默认是白色）


-(void)appointTabBarItemWithIndex:(NSInteger)index;//指定选中哪一个tabBar上的item

-(void)hidenTabBarView;//如果给tabBarViewController的viewControllers数组中添加的是导航控制器器，当从首页push到下个子页面的时候，tabBar会自动隐藏，如果viewControllers数组里面是普通的视图控制器，则需要手动调用此方法来隐藏tabBar，而且，用手势pop的时候会有bug

-(void)showTabBarView;


//根据item的索引设置item上的红色的数字提示 number:数字 index:item的索引  因为这个数字是动态变化的 当数字是0的时候 会自动移除角标，不用刻意去手动移除
-(void)setRedNumLableWithNumber:(NSInteger)number andIndex:(NSInteger)index;

-(void)showRedPoint:(BOOL)isShow andIndex:(NSInteger)index;//是否显示小红点（默认isShow=No,不显示）当isShow为NO时，小红点自动移除


@end


@protocol AXDTabbarControllerDelegate <NSObject>

@optional

-(void)tabBarController:(AXDTabbarController*)tabBarController selectItemWithIndex:(NSInteger)index lastIndex:(NSInteger)lastIndex;

@end




