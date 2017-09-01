//
//  BaseViewController.m
//  baseViewDemo
//
//  Created by wqd on 15/12/25.
//  Copyright © 2015年 wqd. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIAlertViewDelegate>

@end

@implementation BaseViewController

- (void)dealloc{
    DLog(@"---%@--dealloc",[self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    DLog(@"======-------%@",self.getKeyWindowRootViewController);
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColor_background;
    
    self.navigationController.navigationBarHidden = YES;
    
    self.navBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kBaseWidth, 64)];
    self.navBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navBarView];
    
    self.navLine = [[UIView alloc]initWithFrame:CGRectMake(0, _navBarView.axd_height-0.5, kBaseWidth, 0.5)];
    self.navLine.backgroundColor = kColor_line;
    [self.navBarView addSubview:self.navLine];
    
    self.navtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kBaseWidth/2-kBaseWidth/2/2,27, kBaseWidth/2, 30)];
    self.navtitleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.navtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.navtitleLabel.textColor = kColor_title;
    [self.navBarView addSubview:self.navtitleLabel];
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(10, 22, 40, 40);
//    [self.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton setTitleColor:kColor_title forState:UIControlStateHighlighted];
    [self.leftButton setTitleColor:kColor_title forState:UIControlStateSelected];
    [self.navBarView addSubview:self.leftButton];
    
    self.returnTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.leftButton.right-10, 32, 50, 20)];
    self.returnTitle.text = @"";
    self.returnTitle.font = [UIFont boldSystemFontOfSize:13];
    self.returnTitle.textColor = [UIColor whiteColor];
    [self.navBarView addSubview:self.returnTitle];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(kBaseWidth-90, 22, 80, 40);
    self.rightButton.hidden = YES;
    self.rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [self.rightButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    self.rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.rightButton setTitleColor:kColor_title forState:UIControlStateNormal];
    [self.navBarView addSubview:self.rightButton];
    
    self.view.backgroundColor = kColor_background;

    
}

-(void)backButtonClick
{
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view bringSubviewToFront:self.navLine];
}

-(void)hideNavBarView
{
    self.navBarView.hidden = YES;
    self.navLine.hidden = YES;
}
-(void)showNavBarView
{
    self.navBarView.hidden = NO;
    self.navLine.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)hideNavPopBtn {
    self.leftButton.hidden = YES;
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
