//
//  UIViewController+JFSemiView.m
//  HelloLive
//
//  Created by FangZhongli on 16/7/4.
//  Copyright © 2016年 wqd. All rights reserved.
//

#import "UIViewController+JFSemiView.h"
#import <objc/runtime.h>

@implementation UIViewController (JFSemiView)

#pragma mark - private property
- (void)setJf_backgroundView:(UIView *)jf_backgroundView{
    objc_setAssociatedObject(self, @selector(jf_backgroundView), jf_backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)jf_backgroundView{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setJf_enableBlankDismiss:(BOOL )jf_enableBlankDismiss{
    objc_setAssociatedObject(self, @selector(jf_enableBlankDismiss), @(jf_enableBlankDismiss), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)jf_enableBlankDismiss{
    if (objc_getAssociatedObject(self, _cmd)) {
        return [objc_getAssociatedObject(self, _cmd) boolValue];
    }
    // 默认激活
    return YES;
}

-(void)jf_presentSemiView:(UIView*)alert{
    
    CGSize preSize = alert.axd_size;
    
    UIButton *bgView = [UIButton buttonWithType:UIButtonTypeCustom];
    bgView.frame = self.view.bounds;
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [bgView addTarget:self action:@selector(jf_remobgViewClick) forControlEvents:UIControlEventTouchUpInside];
    bgView.tag = 1234567890;
    [self.view addSubview:bgView];
    
    alert.frame = CGRectMake(kBaseWidth/2, kBaseHeight/2, 0, 0);
    [bgView addSubview:alert];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        alert.frame = CGRectMake(kBaseWidth/2-preSize.width/2, kBaseHeight/2-preSize.height/2, preSize.width, preSize.height);
    }];
}

- (void)jf_presentFromeBottomView:(UIView *)alert{
    
    UIButton *bgView = [UIButton buttonWithType:UIButtonTypeCustom];
    bgView.frame = self.view.bounds;
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [bgView addTarget:self action:@selector(jf_remobgViewClick) forControlEvents:UIControlEventTouchUpInside];
    self.jf_backgroundView = bgView;
    [self.view addSubview:bgView];
    
    alert.top = kBaseHeight;
    [bgView addSubview:alert];
    
    self.jf_backgroundView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        alert.bottom = kBaseHeight;
        self.jf_backgroundView.alpha = 1;
    }];
    objc_setAssociatedObject(self, @"jf_presentFromeBottomView", alert, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
}

-(void)jf_remobgViewClick
{
    if (!self.jf_enableBlankDismiss) {
        return;
    }
    [self jf_removeBgView];
    self.jf_enableBlankDismiss = YES;// 默认yes 每次都要重置
}

- (void)jf_removeBgView{
    __weak typeof(self) weakSelf = self;
    UIButton *bgButton = (UIButton *)[self.view viewWithTag:1234567890];
    UIViewController *vc = objc_getAssociatedObject(self, @"jf_SemiViewController");
    UIView *view = objc_getAssociatedObject(self, @"jf_presentFromeBottomView");
    if (vc || view) {
        [UIView animateWithDuration:0.25 animations:^{
            vc.view.top = kBaseHeight;
            view.top = kBaseHeight;
            weakSelf.jf_backgroundView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgButton removeFromSuperview];
            [weakSelf.jf_backgroundView removeFromSuperview];
            [vc removeFromParentViewController];
            objc_setAssociatedObject(self, @"jf_SemiViewController", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            objc_setAssociatedObject(self, @"jf_presentFromeBottomView", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }];
    }else{
        
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.jf_backgroundView.alpha = 0;
        } completion:^(BOOL finished) {
            [weakSelf.jf_backgroundView removeFromSuperview];
        }];
        
        [bgButton removeFromSuperview];
    }
}

- (void)isClickBlankToDismiss:(BOOL)enable{
    
}

- (void)jf_presentSemiViewController:(UIViewController *)vc {
    
    UIView *alert = vc.view;
    
    UIButton *bgView = [UIButton buttonWithType:UIButtonTypeCustom];
    bgView.frame = self.view.bounds;
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    [bgView addTarget:self action:@selector(jf_remobgViewClick) forControlEvents:UIControlEventTouchUpInside];
    bgView.tag = 1234567890;
    [self.view addSubview:bgView];
    
    alert.top = kBaseHeight;
    [bgView addSubview:alert];
    
    [self addChildViewController:vc];
    objc_setAssociatedObject(self, @"jf_SemiViewController", vc, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    [UIView animateWithDuration:0.3 animations:^{
        alert.bottom = kBaseHeight;
    }];
}

- (void)jf_presentLikeAlertView:(UIView *)view{
    
    UIButton *bgView = [UIButton buttonWithType:UIButtonTypeCustom];
    bgView.frame = self.view.bounds;
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [bgView addTarget:self action:@selector(jf_remobgViewClick) forControlEvents:UIControlEventTouchUpInside];
    bgView.tag = 1234567890;
    [self.view addSubview:bgView];
    bgView.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        bgView.alpha = 1;
    }];
    self.jf_backgroundView = bgView;
    
    view.center = bgView.center;
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
    [bgView addSubview:view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jf_keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)jf_keyboardChange:(NSNotification *)aNotification
{
    NSDictionary* userInfo = [aNotification userInfo];
    CGRect keyboardEndFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY =  keyboardEndFrame.origin.y;
    
    __block UIView *targetView = self.jf_backgroundView.subviews[0];
    void (^endFrameBlock)() = ^{
        targetView.bottom = keyboardY==kBaseHeight? (targetView.superview.center.y+targetView.axd_height/2) :keyboardY;
    };
    int curve = [[aNotification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    float duration = [[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationDuration:duration];
    endFrameBlock();
    [UIView commitAnimations];
    
}



#pragma mark AlertController
static void* UIAlertViewKey = @"UIAlertViewKey";
- (void)setAlertViewCallBackBlock:(UIAlertViewCallBackBlock)alertViewCallBackBlock {
    
    [self willChangeValueForKey:@"callbackBlock"];
    objc_setAssociatedObject(self, &UIAlertViewKey, alertViewCallBackBlock, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"callbackBlock"];
}

- (UIAlertViewCallBackBlock)alertViewCallBackBlock {
    
    return objc_getAssociatedObject(self, &UIAlertViewKey);
}

- (void)jf_presentAlertControllerTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)subTitles handler:(void(^)(NSInteger index))handler {
    [self jf_presentAlertControllerStyle:YES hasCancel:NO title:title message:message actionTitles:subTitles handler:handler];
}


- (void)jf_presentAlertControllerStyle:(BOOL)alertStyle hasCancel:(BOOL)hasCancel title:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)subTitles handler:(void(^)(NSInteger index))handler {
    
    if ([UIDevice currentDevice].systemVersion.floatValue<8.0) {
        
        if (alertStyle) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:(id<UIAlertViewDelegate>)self cancelButtonTitle:hasCancel?@"取消":nil otherButtonTitles:nil];
            for (NSString *subT in subTitles) {
                [alert addButtonWithTitle:subT];
            }
            [alert show];
        }else{
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:(id<UIActionSheetDelegate>)self cancelButtonTitle:hasCancel?@"取消":nil destructiveButtonTitle:nil otherButtonTitles:nil];
            for (NSString *subT in subTitles) {
                [sheet addButtonWithTitle:subT];
            }
            [sheet showInView:self.view];
            
        }
        self.alertViewCallBackBlock = handler;
        
        return;
    }
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:alertStyle];
    
    if (hasCancel) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (handler) {
                handler(subTitles.count);
            }
            
        }];
        [alert addAction:action];
    }
    
    for (NSString *subT in subTitles) {
        NSInteger index = [subTitles indexOfObject:subT];
        UIAlertAction *action = [UIAlertAction actionWithTitle:subT style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (handler) {
                handler(index);
            }
            
        }];
        [alert addAction:action];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (self.alertViewCallBackBlock) {
        self.alertViewCallBackBlock(buttonIndex);
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (self.alertViewCallBackBlock) {
        self.alertViewCallBackBlock(buttonIndex);
    }
}

@end
