//
//  UIView+FrameExt.m
//  ACHProject
//
//  Created by chenxiaohong on 2017/8/21.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import "UIView+FrameExt.h"

@implementation UIView (FrameExt)

-(CGFloat)axd_x
{
    return self.frame.origin.x;
}

-(void)setAxd_x:(CGFloat)axd_x
{
    CGRect frame = self.frame;
    frame.origin.x = axd_x;
    self.frame = frame;
}


-(CGFloat)axd_y
{
    return self.frame.origin.y;
}

-(void)setAxd_y:(CGFloat)axd_y
{
    CGRect frame = self.frame;
    frame.origin.y = axd_y;
    self.frame = frame;
}


-(CGFloat)axd_width
{
    return self.frame.size.width;
}

-(void)setAxd_width:(CGFloat)axd_width
{
    CGRect frame = self.frame;
    frame.size.width = axd_width;
    self.frame = frame;
}


-(CGFloat)axd_height
{
    return self.frame.size.height;
}

-(void)setAxd_height:(CGFloat)axd_height
{
    CGRect frame = self.frame;
    frame.size.height = axd_height;
    self.frame = frame;
}


-(CGFloat)axd_centerX
{
    return self.center.x;
}

-(void)setAxd_centerX:(CGFloat)axd_centerX
{
    CGPoint center = self.center;
    center.x = axd_centerX;
    self.center = center;
}


-(CGFloat)axd_centerY
{
    return self.center.y;
}

-(void)setAxd_centerY:(CGFloat)axd_centerY
{
    CGPoint center = self.center;
    center.y = axd_centerY;
    self.center = center;
}

@end
