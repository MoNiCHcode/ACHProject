//
//  UIImage+Ext.h
//  MuckBoss
//
//  Created by FangZhongli on 16/7/28.
//  Copyright © 2016年 wangqudao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ext)
+(UIImage *)imageWithColor:(UIColor *)aColor;
+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;
+(UIImage *)imageWithColor:(UIColor *)aColor size:(CGSize)size;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;

/**
 压图片质量
 
 @param image image
 @return Data
 */
+ (NSData *)zipImageWithImage:(UIImage *)image;
/**
 *  等比缩放本图片大小
 *
 *  @param newImageWidth 缩放后图片宽度，像素为单位
 *
 *  @return self-->(image)
 */
+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth;

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
@end
