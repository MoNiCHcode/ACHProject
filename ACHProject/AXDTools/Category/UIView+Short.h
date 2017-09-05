//
//  UIView+Short.h
//  MuckBoss
//
//  Created by FangZhongli on 16/7/21.
//  Copyright © 2016年 wangqudao. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  工程涉及的创建控件快捷方法
 */
@interface UIView (Short)

/**
 *  提交按钮
 */
+ (UIButton *)commitButtonWithY:(float)y title:(NSString *)title handler:(viewClickBlock)handler superView:(UIView *)superView;
+ (UIButton *)commitButtonWithY:(float)y width:(float)width title:(NSString *)title handler:(viewClickBlock)handler superView:(UIView *)superView;
+ (UIButton *)commitButtonWithFrame:(CGRect)frame title:(NSString *)title handler:(viewClickBlock)handler superView:(UIView *)superView;

+ (UITextField*)creatInputViewPlaceholder:(NSString *)placeholder leftImage:(UIImage *)leftImage isPwd:(BOOL)isPwd;
/**
 *  给view添加上或下线
 */
- (void)addLineWithBottom:(BOOL)bottom top:(BOOL)top;
- (UIView*)addLineWithY:(float)y;
- (UIView*)addLineWithY:(float)y spaceLeft:(float)spaceLeft;
/**
 *  移除view
 */
- (void)removeViewWithTag:(NSInteger)tag;
/**
 *  以中文：为界限，左灰右黑
 */

+ (NSMutableAttributedString*)attributedString:(NSString *)string;
+ (NSMutableAttributedString *)attributedString:(NSString *)string carCount:(NSString *)carCount;
+ (NSMutableAttributedString *)attributedString:(NSString *)string carSumCount:(NSString *)carCount;
+ (NSMutableAttributedString *)attributedString:(NSString *)string leftColor:(UIColor*)leftColor rightColor:(UIColor*)rightColor;
@end
