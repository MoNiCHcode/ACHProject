//
//  RootTabBarController.h
//  EternalSpirit
//
//  Created by FangZhongli on 2016/12/8.
//  Copyright © 2016年 wangqudao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootTabBarController : UITabBarController
+ (instancetype)sharedTabBarController;
-(void)loginIn;
-(void)loginOnlyUserBeDeleted;
@end
