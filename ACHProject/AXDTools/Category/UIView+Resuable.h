//
//  UIView+Resuable.h
//  MuckBoss
//
//  Created by FangZhongli on 16/7/21.
//  Copyright © 2016年 wangqudao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIControl+BlocksKit.h"

typedef void(^viewClickBlock)(id view);
typedef void(^tapAction)(id view);

@interface UIView (Resuable)

#pragma mark - layer
- (void)addLayerCornerRadius:(CGFloat)radius;
- (void)addLayerBorderColor:(UIColor*)color borderWidth:(CGFloat)width;
- (void)addLayerBorderColor:(UIColor*)color borderWidth:(CGFloat)width cornerRadius:(CGFloat)radius;

#pragma mark - UIView

- (void)removeAllSubView;
+ (UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor*)bgColor superView:(UIView *)superView;

#pragma mark - UILable Short Creat
+ (UILabel *)initWithFrame:(CGRect)frame title:(NSString *)title superView:(UIView*)superView;
+ (UILabel *)initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor*)color superView:(UIView*)superView;
+ (UILabel *)initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color font:(UIFont*)font superView:(UIView *)superView;
+ (UILabel *)initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor*)color textAlignment:(NSTextAlignment)aligment superView:(UIView*)superView;

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

#pragma mark - UIButton
+ (UIButton *)buttonWithFrame:(CGRect)frame image:(UIImage *)image superView:(UIView *)superView;
+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title superView:(UIView *)superView;
+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image superView:(UIView *)superView;
+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title bgImage:(UIImage *)bgImage superView:(UIView *)superView;
+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color backgroundColor:(UIColor *)bgColor superView:(UIView *)superView;
+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color backgroundColor:(UIColor *)bgColor font:(UIFont*)font superView:(UIView *)superView;

#pragma mark - UITextFild
+ (UITextField*)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text superView:(UIView*)superView;
+ (UITextField*)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text color:(UIColor*)color font:(UIFont *)font superView:(UIView*)superView;

#pragma mark - UIImageView
+ (UIImageView*)imageViewWithFrame:(CGRect)frame image:(UIImage*)image superView:(UIView*)superView;

#pragma mark - 抖动


#pragma mark - Event

- (void)tapHandler:(tapAction)block;
@end

@interface UIButton (Ext)
/** 注意循环引用问题 */
- (void)buttonHandler:(tapAction)block;
@end

@interface UITextField (Event)
//@property(nonatomic,copy)viewClickBlock textFieldEditingChangeBlock;
//@property(nonatomic,copy)viewClickBlock textFieldEditingDidBeginBlock;
//@property(nonatomic,copy)viewClickBlock textFieldEditingDidEndBlock;
- (void)textfieldChangeHandler:(tapAction)block;
- (void)textfieldEditingDidBeginHandler:(tapAction)block;
- (void)textfieldEditingDidEndHandler:(tapAction)block;

@end

@interface UIView (ShakeAnimation)

// 左右shake
- (void)shakeView;

@end
