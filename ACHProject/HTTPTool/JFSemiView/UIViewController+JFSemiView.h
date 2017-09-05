//
//  UIViewController+JFSemiView.h
//  HelloLive
//
//  Created by FangZhongli on 16/7/4.
//  Copyright © 2016年 wqd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^JFCompletionBlock)(void);
typedef void(^UIAlertViewCallBackBlock)(NSInteger buttonIndex);

@interface UIViewController (JFSemiView)

@property (nonatomic, strong)UIView *jf_backgroundView;
/**
 *  激活点击空白处隐藏
 */
@property (nonatomic, assign)BOOL jf_enableBlankDismiss;
@property (nonatomic, copy) UIAlertViewCallBackBlock alertViewCallBackBlock;
/**
 *  仿AlertView的展现动画
 */
- (void)jf_presentLikeAlertView:(UIView *)view;

/**
 *  从中间由小到大展现
 */
-(void)jf_presentSemiView:(UIView*)alert;
/**
 *  从底部推出View
 */
- (void)jf_presentFromeBottomView:(UIView *)alert;
/**
 *  从底部退出ViewController
 */
- (void)jf_presentSemiViewController:(UIViewController *)vc;
/**
 *  移除展现的视图
 */
-(void)jf_removeBgView;

/**
 *  UIAlertController for UIAlertControllerStyleAlert allow down 8.0
 */
- (void)jf_presentAlertControllerTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)subTitles handler:(void(^)(NSInteger index))handler;
/**
 *  UIAlertController for is alertStyle allow down 8.0
 */
- (void)jf_presentAlertControllerStyle:(BOOL)alertStyle hasCancel:(BOOL)hasCancel title:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)subTitles handler:(void(^)(NSInteger index))handler;

@end
