//
//  HomeViewController.m
//  ACHProject
//
//  Created by chenxiaohong on 2017/8/24.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import "HomeViewController.h"
#import "YJSliderView.h"
#import "HomeClassViewController.h"
#import "HYPageView.h"
#import "global.h"
#import "BGTopSilderBar.h"


#import "LirenViewController.h"
#import "EntertainmentViewController.h"
#import "ServiceViewController.h"
@interface HomeViewController ()
{
    UIButton *_locationBtn;
}

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UITableView *mainTabView;
@property (nonatomic, strong) YJSliderView *sliderView;
@property (nonatomic,strong)HYPageView *HYtitleView;
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatNavView];
    [self.view addSubview:self.HYtitleView];
    self.view.backgroundColor = [UIColor purpleColor];
     

}



#pragma mark - UI
- (void)creatNavView {
    
    self.leftButton.hidden = YES;
    self.navBarView.backgroundColor = kColor_white;
    UIButton *locationBtn = [UIButton buttonWithFrame:CGRectMake(10, 20, 70, 44) title:@"未知" image:[UIImage imageNamed:@"icon_morecity"] superView:self.navBarView];
    locationBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    locationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 56, 0, 0);
    locationBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    locationBtn.titleLabel.font = kFontSize_title;
    locationBtn.titleLabel.textColor = kColor_title;
//    [locationBtn addTarget:self action:@selector(selectLocationClick:) forControlEvents:UIControlEventTouchUpInside];
    _locationBtn = locationBtn;    // 定位
//    _locationManager = [[ZLLocation alloc] init];
//    _locationManager.delegate = self;
//    [_locationManager locationStart];
    
    UITextField *searchTF = [UITextField textFieldWithFrame:CGRectMake(locationBtn.right+10, locationBtn.top+7, kBaseWidth-locationBtn.right-70, 33) placeholder:@"请输入店铺搜索" text:nil color:kColor_title font:kFontSize_title superView:self.navBarView];
//    [searchTF addLayerCornerRadius:searchTF.axd_height/2];
    searchTF.backgroundColor = RGB(254, 243, 208);
//    searchTF.delegate = self;
    
    UIView *leftView = [UIView viewWithFrame:CGRectMake(0, 0, 40, searchTF.axd_height) backgroundColor:nil superView:nil];
    
    UIImageView *searchImg = [UIImageView imageViewWithFrame:CGRectMake(10, 8, 15, 15) image:[UIImage imageNamed:@"icon_search"] superView:leftView];
    searchImg.contentMode = UIViewContentModeScaleAspectFit;
    searchTF.leftView = leftView;
    searchTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIButton *messageBtn = [UIButton buttonWithFrame:CGRectMake(kBaseWidth-50, locationBtn.top, 40, 44) image:[UIImage imageNamed:@"icon_news"] superView:self.navBarView];
    messageBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [messageBtn addTarget:self action:@selector(gotoMessage) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *badge = [UILabel initWithFrame:CGRectMake(messageBtn.right-20, messageBtn.top+3, 20, 20) title:@"99" titleColor:kColor_white font:[UIFont systemFontOfSize:10] superView:self.navBarView];
    badge.backgroundColor = kColor_orangeRed;
    badge.textAlignment  = NSTextAlignmentCenter;
    [badge addLayerCornerRadius:badge.axd_height/2];
    badge.hidden = YES;
    
//    _badge = badge;
}


///**
// 初始化BGTopSilderBar
// */
//-(void)initSilderBar{
//    BGTopSilderBar* silder = [[BGTopSilderBar alloc] initWithFrame:CGRectMake(0,20,screenW, 50)];
//    //silder.contentCollectionView = _collectView;//_collectView必须要在前面初始化,不然这里值为nil
//    silder.contentCollectionView = _scrollView;//_scrollView必须要在前面初始化,不然这里值为nil
//    _silderBar = silder;
//    [self.view addSubview:silder];
//}
//
///**
// 初始化UIScrollView
// */
//-(void)initScrollView{
//    UIScrollView* scroll = [[UIScrollView alloc] init];
//    scroll.frame = CGRectMake(0,75,screenW,screenH-75);
//    scroll.contentSize = CGSizeMake(11*screenW,screenH-75 - 50);//contentSize的宽度等于顶部滑动栏的item个数乘与屏幕宽度screenW
//    scroll.pagingEnabled = YES;
//    _scrollView = scroll;
//    [self.view addSubview:scroll];
//    [self addChildViewController];
//}
//
///**
// 添加子控制器
// */
//-(void)addChildViewController{
//    for(int i=0;i<11;i++){
//        if (i%2) {
//            HomeClassViewController* twoCon = [[HomeClassViewController alloc] init];
//            twoCon.index = i;
//            [self addChildViewController:twoCon];
//            twoCon.view.frame = CGRectMake(i*screenW,0,screenW,screenH-75 -50);
//            [_scrollView addSubview:twoCon.view];
//        }else{
//            oneController* oneCon = [[oneController alloc] init];
//            oneCon.index = i;
//            [self addChildViewController:oneCon];
//            oneCon.view.frame = CGRectMake(i*screenW,0,screenW,screenH-75 - 50);
//            [_scrollView addSubview:oneCon.view];
//        }
//    }
//}
//





#pragma mark - 轮播图
- (HYPageView *)HYtitleView {
    HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(0, kBaseNavHeight, kBaseWidth , kBaseHeight - 50) withTitles:@[@"美食",@"丽人",@"娱乐",@"汽车服务"] withViewControllers:@[@"HomeClassViewController",@"LirenViewController",@"EntertainmentViewController",@"ServiceViewController",] withParameters:nil];
    
    pageView.selectedColor = kColor_main;
    pageView.unselectedColor = [UIColor blackColor];
    pageView.defaultSubscript = 0;
    
    return pageView;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
