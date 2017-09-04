//
//  ZLRatingBar.h
//  EternalSpirit
//
//  Created by FangZhongli on 2016/12/26.
//  Copyright © 2016年 wangqudao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  星级评分条代理
 */
@protocol ZLRatingBarDelegate <NSObject>

/**
 *  评分改变
 *
 *  @param newRating 新的值
 */
- (void)ratingChanged:(float)newRating;

@end

@interface ZLRatingBar : UIView

/**
 *  初始化设置未选中图片、半选中图片、全选中图片，以及评分值改变的代理（可以用
 *  Block）实现
 *
 *  @param deselectedName   未选中图片名称
 *  @param fullSelectedName 全选中图片名称
 */
- (id)initWithFrame:(CGRect)frame deselectedImage:(NSString *)deselectedName fullSelected:(NSString *)fullSelectedName andSpacing:(float)spacing;

/**
 *  是否是指示器，如果是指示器，就不能滑动了，只显示结果，不是指示器的话就能滑动修改值
 *  默认为NO
 */
@property (nonatomic,assign) BOOL isIndicator;
/**
 *  设置评分值
 *
 */
@property (nonatomic, assign) float rating;
@property (nonatomic, copy) NSString *deselectedName;
@property (nonatomic, copy) NSString *fullSelectedName;
@property (nonatomic, assign) float spacing;
@property (nonatomic,weak)IBOutlet id <ZLRatingBarDelegate> delegate;
@property (nonatomic, copy)void(^ratingChangedBlock)(float rating);

/**
 * 默认的星星评论布局
 */
+ (instancetype)sharedRatingBar:(float)rating isIndicator:(BOOL)indicator superView:(UIView *)superView;
+ (instancetype)sharedRatingBar:(float)rating isIndicator:(BOOL)indicator signleWidth:(float)width superView:(UIView *)superView;

@end
