//
//  AnimationView.m
//  MyMovie
//
//  Created by zsm on 14-8-26.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import "AnimationView.h"

@implementation AnimationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        //初始化子视图
        [self _initViews];
        
    }
    return self;
}

//初始化子视图
- (void)_initViews
{
    [self _firstAnimation];
//    ESWeakSelf
//    [RequestPerform getbunnerblock:^(id returnData) {
//
//        if ([returnData isKindOfClass:[NSArray class]]) {
//            __weakSelf.banners = returnData;
//            //第一次的动画效果
//            [__weakSelf _firstAnimation];
//        }
//    } onError:^(NSError *error) {
//        [__weakSelf performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.1];
//        [USERDEFAULTS setObject:@"isFirst" forKey:@"isfirstenter"];
//    }];
    
}


//第一次的动画效果
- (void)_firstAnimation
{
    
    //1.创建滑动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.backgroundColor = [UIColor clearColor];
    //设置翻页效果
    _scrollView.pagingEnabled = YES;
    //取消滑动指示器
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    //关闭弹性效果
    _scrollView.bounces = NO;
    //设置代理对象
    _scrollView.delegate = self;
    
    //滑动视图现实的所有的图片
//        self.banners = @[@"Intro1",@"Intro2",@"Intro3"];
    self.banners = @[@"GUIDE1",@"GUIDE2",@"GUIDE3", @"GUIDE4"];
    //设置内容视图的大小
    _scrollView.contentSize = CGSizeMake(kBaseWidth * self.banners.count, _scrollView.axd_height);
    //设置内容的视图
    for (int i = 0; i < self.banners.count; i++) {
        //创建图片视图
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * kBaseWidth, 0, kBaseWidth, self.axd_height)];
        imageView.userInteractionEnabled = YES;
        //设置图片
        imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.banners[i] ofType:@"jpg"]];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImgURL,self.banners[i]]] placeholderImage:[UIImage imageNamed:@"no"]];
        //添加到视图上
        [_scrollView addSubview:imageView];
        
        if (i == self.banners.count-1) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            float width = [[UIScreen mainScreen] bounds].size.width;
            if (width < 414) {
                btn.frame = CGRectMake(20, kBaseHeight - 110, kBaseWidth - 40, 65);
            }
            else
            {
            btn.frame = CGRectMake(20, kBaseHeight - 130, kBaseWidth - 40, 70);
            }
            [btn addTarget:self action:@selector(enterLoginView) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = [UIColor clearColor];
            [imageView addSubview:btn];
        }
        
//        if (i == 3) {
//            imageView.backgroundColor = [UIColor whiteColor];
//            imageView.alpha = .3;
//        }

    }
    
    //把滑动视图添加到视图上
    [self addSubview:_scrollView];
    
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //获取当前的页数索引
    NSInteger pageIndex = (scrollView.contentOffset.x+1) / kBaseWidth;
    
    //判断当前偏移量为最大值的时候
    if (pageIndex == self.banners.count-1) {
        [self performSelector:@selector(enterLoginView) withObject:nil afterDelay:1.5];
        
    }
}

- (void)enterLoginView
{
    if (_isClick) {
        return;
    }
    _isClick = YES;
    [self removeView];
}

- (void)removeView{
    [UIView animateWithDuration:1.0 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [USERDEFAULTS setObject:@"isFirst" forKey:@"isfirstenter"];   //证明第一次已经启动
    }];
}

+ (instancetype)sharedWelcomeView{
    //是否是第一次启动
    NSString *isfirst = [USERDEFAULTS objectForKey:@"isfirstenter"];
    if (isfirst.length <= 0 || isfirst==nil) {        //第一次启动，创建动画视图
        //添加动画视图
        AnimationView *animationView = [[AnimationView alloc] initWithFrame:CGRectMake(0, 0, kBaseWidth, kBaseHeight)];
        [kKeyWindow addSubview:animationView];
        [kKeyWindow bringSubviewToFront:animationView];
        return animationView;
    }
    return nil;
}


@end
