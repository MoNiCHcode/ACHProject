//
//  AXDNavigationBarView.h
//  ACHProject
//
//  Created by chenxiaohong on 2017/8/24.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AXDNavigationBarViewDelegate;

@interface AXDNavigationBarView : UIView
{
    
    float _screenWidth;
    float _screenHight;
}
@property(nonatomic,strong)NSMutableDictionary* subViewsDic;

@property(nonatomic,copy)NSString* title;//给三个位置设置标题
@property(nonatomic,copy)NSString* leftTitle;
@property(nonatomic,copy)NSString* rightTitle;

@property(nonatomic,strong)UIImage* leftImage;//给三个位置设置图片
@property(nonatomic,strong)UIImage* rightImage;
@property(nonatomic,strong)UIImage* centerImage;

@property(nonatomic,strong)NSArray* rightItemsArray;//给左边或者右边设置两个图片或者标题（最多只支持两个，而且两个item必须是图片和文字的混合，文字图片的顺序依次）比如：navBar.leftItemsArray=@[@"首页",[UIImage imageNamed:@"home0.png"]];
@property(nonatomic,strong)NSArray* leftItemsArray;

@property(nonatomic)float titleFontValue;//中间title文字的大小

@property(nonatomic,strong)UIView* titleView;//中间的视图，比如给一个系统的搜索条，实现搜索功能

@property(nonatomic,strong)UIColor *textColor;
@property(nonatomic)CGFloat insertLeftX;
@property(nonatomic)CGFloat insertRightX;

@property(nonatomic)CGFloat itemLeftSpace;
@property(nonatomic)CGFloat itemRigtSpace;

@property(nonatomic)CGFloat centerOffset;

@property(nonatomic)BOOL isHidenLine;

@property(nonatomic,assign)id<AXDNavigationBarViewDelegate>delegate;//点击navigationBar，要响应事件，必须要设置代理，实现代理方法(当有多个时根据索引判断点击的是哪一个item，左：0，1 右：0，1)，如果只有一个不需要判断index

+(id)navigationBar;


@end



@protocol AXDNavigationBarViewDelegate <NSObject>

@optional
-(void)navigationBarView:(AXDNavigationBarView*)navBar leftItemsClickWithIndex:(NSInteger)index;
-(void)navigationBarView:(AXDNavigationBarView*)navBar rightItemsClickWithIndex:(NSInteger)index;
-(void)navigationBarViewCenterClick:(AXDNavigationBarView*)navBar;

@end





