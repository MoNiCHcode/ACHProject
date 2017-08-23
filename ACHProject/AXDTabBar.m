//
//  AXDTabBar.m
//  ACHProject
//
//  Created by 爱享到 on 2017/7/27.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import "AXDTabBar.h"

@interface AXDTabBar ()
/**中间的发布按钮*/
@property (nonatomic,strong)UIButton *publishBut;

@end


@implementation AXDTabBar

//懒加载
-(UIButton *)publishButton
{
    UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon_38x38_"] forState:UIControlStateNormal];
    [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon_38x38_"] forState:UIControlStateSelected];
    [publishButton addTarget:self action:@selector(publishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:publishButton];
    _publishBut = publishButton;
    return publishButton;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //局部变量
    CGFloat ButtonW = self.frame.size.width / 5;
    CGFloat ButtonH = self.frame.size.height;
    CGFloat ButtonY = 0;
    
    int buttonIndex = 0;
    
    //重写系统tababrItem的frame
    for (UIView *subview in self.subviews) {
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        
        CGFloat ButtonX = buttonIndex *ButtonW;
        
        if (buttonIndex >= 2) {
            ButtonX += ButtonW;
        }
        
        subview.frame = CGRectMake(ButtonX, ButtonY, ButtonW, ButtonH);

        //增加索引
        buttonIndex++;
    }
    
    
    /**设置发布按钮的frame*/
    self.publishButton.frame = CGRectMake(ButtonW * 2, 0, ButtonW, ButtonH);
    self.publishButton.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height/2);
    
    
}



-(void)publishButtonClick:(UIButton *)button
{
    AXDLog(@"发布");
}

@end
