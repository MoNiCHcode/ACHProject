
//
//  AXDTabbarController.m
//  ACHProject
//
//  Created by 爱享到 on 2017/7/20.
//  Copyright © 2017年 爱享到. All rights reserved.
//




#import "AXDTabbarController.h"
#import "AXDTabBar.h"
@interface AXDTabbarController ()

@end

@implementation AXDTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /****统一属性****/
    UITabBarItem *item = [UITabBarItem appearance];
    /****设置没选中的item文字属性****/
    NSMutableDictionary *attributDic = [NSMutableDictionary new];
    NSMutableDictionary *selectAttributDic = [NSMutableDictionary new];
    
    attributDic[NSFontAttributeName] = [UIFont systemFontOfSize:14]; //设置属性字体
//    attributDic[NSForegroundColorAttributeName] = [UIColor blackColor]; //设置属性背景色
    [item setTitleTextAttributes:attributDic forState:UIControlStateNormal];
    
    /****设置选中状态下的文字属性****/
    selectAttributDic[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    selectAttributDic[NSForegroundColorAttributeName] = [UIColor redColor];
    [item setTitleTextAttributes:selectAttributDic forState:UIControlStateSelected];
    
   
    
    

    /**** 添加一个子控制器****/
     [self addChildViewControll:[[UIViewController alloc]init] title:@"首页" image:@"tabBar_essence_icon_27x27_" selectImage:@"tabBar_essence_click_icon_27x27_"];
     [self addChildViewControll:[[UIViewController alloc]init] title:@"拼团" image:@"tabBar_new_icon_27x27_" selectImage:@"tabBar_new_click_icon_27x27_"];
     [self addChildViewControll:[[UIViewController alloc]init] title:@"我的" image:@"tabBar_me_icon_27x27_" selectImage:@"tabBar_me_click_icon_27x27_"];
    
    /****更换自定义tabbar****/
//    [self setValue:[[AXDTabBar alloc] init] forKey:@"tabBar"];//KVC
    
}


/**
 * 添加一个子控制器
 *
 *@param vc     子控制器
 *@param title  标题
 *@param iamge 图标
 *@param selectImage 选中图标
 */

-(void)addChildViewControll:(UIViewController *)vc title:(NSString *)title image:(NSString *)iamge selectImage:(NSString *)selectImage
{
//    UIImage *image = [UIImage ]
    vc.view.backgroundColor = AXDRandomColor;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:iamge];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    [self addChildViewController:vc];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
