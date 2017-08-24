//
//  CFGuideViewController.m
//  CFArchitecture
//
//  Created by Mr.Guo on 2017/5/10.
//  Copyright © 2017年 Mr.Guo. All rights reserved.
//

#import "CFGuideViewController.h"

#define GuideCount 3
@interface CFGuideViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)UIPageControl *pageControll;
@end

@implementation CFGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化scrollView
    [self setupScrollView];
    
    // 初始化UIPageControl
    [self setupPageControl];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"点击跳过" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(changeControll) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(20);
    }];
}

// 初始化ScrollView
- (void)setupScrollView
{
    UIScrollView *scroView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.axd_width, self.view.axd_height)];
    scroView.contentSize = CGSizeMake(GuideCount*self.view.axd_width, 0);
    scroView.pagingEnabled = YES;
    scroView.showsHorizontalScrollIndicator = NO;
    scroView.delegate = self;
    scroView.bounces = NO;
    [self.view addSubview:scroView];
    self.scrollView = scroView;
    
    for (int i = 0 ; i< GuideCount; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"GUIDE%d.jpg",i+1]];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imageview.image = image;
        [scroView addSubview:imageview];
        imageview.userInteractionEnabled = YES;
        if (i == GuideCount-1) {
            [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeControll)]];
            UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn2.backgroundColor = AXDRandomColor;
            btn2.layer.cornerRadius = 5;
            CGFloat btn2W = 150;
            CGFloat btn2H = 35;
            CGFloat btn2Y = self.view.axd_height-100;
            CGFloat btn2X = self.view.axd_width*(GuideCount-1)+(self.view.axd_width-btn2W)*0.5;
            [btn2 setTitle:@"进 入" forState:UIControlStateNormal];
            btn2.frame = CGRectMake(btn2X, btn2Y, btn2W, btn2H);
            [btn2 addTarget:self action:@selector(changeControll) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:btn2];
        }
    }
}

// 初始化pageController
- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(0, self.view.axd_height-20, self.view.axd_width, 20);
    pageControl.numberOfPages = GuideCount;
    pageControl.currentPageIndicatorTintColor = AXDRandomColor;
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:pageControl];
    self.pageControll = pageControl;
}


#pragma mark - UIScrollViewDelegate代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControll.currentPage = (scrollView.contentOffset.x+self.view.axd_width/2)/self.view.axd_width;
}

- (void)changeControll
{
    KEY_WINDOW.rootViewController = [MainStoryBoard instantiateViewControllerWithIdentifier:@"ViewController"];
}
@end
