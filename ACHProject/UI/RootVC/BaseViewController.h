//
//  BaseViewController.h
//  CFArchitecture
//
//  Created by Mr.Guo on 2017/5/8.
//  Copyright © 2017年 Mr.Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFNavigationBar.h"

@interface BaseViewController : UIViewController
@property (nonatomic, strong) CFNavigationBar        *navBar;
@property (strong, nonatomic) UIImageView            *backItem;
@property (strong, nonatomic) UIImageView            *leftItem;
@property (strong, nonatomic) UIImageView            *rightItem;
@property (strong, nonatomic) UIButton               *leftButton;
@property (strong, nonatomic) UIButton               *rightButton;

/**
   导航栏按钮点击响应的方法
 */
- (void)backItemTouched:(id)sender;
- (void)leftItemTouched:(id)sender;
- (void)rightItemTouched:(id)sender;
- (void)leftButtonClick:(id)sender;
- (void)rightButtonClick:(id)sender;

/**
 *  添加左侧按钮，传入图片名
 *
 *  @param leftItemImageName  传入图片名
 */
- (void)addleftItem:(NSString *)leftItemImageName;
/**
 *  添加右侧按钮，传入图片名
 *
 *  @param rightItemImageName  传入图片名
 */
- (void)addrightItem:(NSString *)rightItemImageName;

/**
 *  添加左侧按钮。传入一个Title
 *
 *  @param Title  按钮标题
 */
- (void)addleftButton:(NSString *)Title;
/**
 *  添加右侧按钮。传入一个Title
 *
 *  @param Title  按钮标题
 */
- (void)addrightButton:(NSString *)Title;


@end
