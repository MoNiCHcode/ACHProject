//
//  UIView+FrameExt.h
//  ACHProject
//
//  Created by chenxiaohong on 2017/8/21.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameExt)
/**assign*/
@property (nonatomic ,assign)CGSize  axd_size;
@property (nonatomic ,assign)CGFloat axd_x;
@property (nonatomic ,assign)CGFloat axd_y;
@property (nonatomic ,assign)CGFloat axd_width;
@property (nonatomic ,assign)CGFloat axd_height;
@property (nonatomic ,assign)CGFloat axd_centerX;
@property (nonatomic ,assign)CGFloat axd_centerY;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@end
