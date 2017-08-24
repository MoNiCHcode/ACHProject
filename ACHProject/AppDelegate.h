//
//  AppDelegate.h
//  ACHProject
//
//  Created by 爱享到 on 2017/7/5.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class AXDTabbarController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) AXDTabbarController *axdTabBarController;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

