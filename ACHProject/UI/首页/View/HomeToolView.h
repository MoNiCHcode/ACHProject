//
//  HomeToolView.h
//  EternalSpirit
//
//  Created by FangZhongli on 2016/12/8.
//  Copyright © 2016年 wangqudao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLMainCategory_nav;

@interface HomeToolView : UIView
@property (nonatomic, copy)void(^selectIndexBlock)(NSInteger index);
+ (instancetype)sharedToolViewCompletion:(void(^)(NSInteger index))block;
+ (instancetype)sharedToolViewModels:(NSArray<ZLMainCategory_nav*>*)modes complection:(void(^)(NSInteger index))block;
@end
