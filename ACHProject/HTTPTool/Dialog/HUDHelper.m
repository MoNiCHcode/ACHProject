//
//  HUDHelper.m
//  EternalSpirit
//
//  Created by FangZhongli on 2016/12/8.
//  Copyright © 2016年 wangqudao. All rights reserved.
//

#import "HUDHelper.h"

@implementation HUDHelper

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)showCustomAlertMessage:(NSString *)message
{
    UILabel *content = [[UILabel alloc]init];
    content.text = message;
    content.textColor = [UIColor whiteColor];
    content.font = [UIFont systemFontOfSize:15];
    content.textAlignment = NSTextAlignmentCenter;
    content.numberOfLines = 0;
    content.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    content.layer.cornerRadius = 5;
    content.layer.masksToBounds = YES;
    
    UIView *supView = [UIApplication sharedApplication].keyWindow;
    
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGSize size = [content.text boundingRectWithSize:CGSizeMake(screenWidth-80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:content.font} context:nil].size;
    content.frame = CGRectMake(0, 0, size.width+20, size.height+20);
    content.center = supView.center;
    [supView addSubview:content];
    
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    k.values = @[@(0.1),@(1.0),@(1.1)];
    k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    k.calculationMode = kCAAnimationLinear;
    [content.layer addAnimation:k forKey:@"SHOW"];
    
    [self performSelector:@selector(removeView:) withObject:content afterDelay:1.5];
}


+ (void)removeView:(UIView *)view
{
    
    [UIView animateWithDuration:1 animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

+ (void)showLoading{
    
    UIViewController *VC = self.getKeyWindowRootViewController;
    
    UIView *loadingView = [VC.view viewWithTag:777];
    if (loadingView) {
        [self hiddenLoading];
    }
    
    CGRect frame = CGRectMake(0, kBaseNavHeight, kBaseWidth, kBaseHeight-kBaseNavHeight);
    
    loadingView = [[UIView alloc] initWithFrame:frame];
    loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    if ([VC isKindOfClass:[RootTabBarController class]]) {
        RootTabBarController *tabbar = (RootTabBarController *)VC;
        [tabbar.selectedViewController.view addSubview:loadingView];
        loadingView.axd_height = kBaseHeight-kBaseNavHeight-kbaseTabBarHeight;
    }else{
        [VC.view addSubview:loadingView];
    }
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator startAnimating];
    indicator.center = CGPointMake(loadingView.axd_width/2, loadingView.axd_height/2);
    [loadingView addSubview:indicator];
    
    loadingView.tag=777;
}

+ (void)hiddenLoading{
    UIViewController *VC = self.getKeyWindowRootViewController;
    
    if ([VC isKindOfClass:[RootTabBarController class]]) {
        RootTabBarController *tabbar = (RootTabBarController *)VC;
        [tabbar.selectedViewController.view removeViewWithTag:777];
    }else{
        [VC.view removeViewWithTag:777];
    }
}


@end
