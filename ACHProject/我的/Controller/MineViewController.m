//
//  MineViewController.m
//  ACHProject
//
//  Created by chenxiaohong on 2017/8/24.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIButton *goLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    goLogin.axd_x = 100;
    goLogin.axd_y = 100;
    goLogin.axd_height = 100;
    goLogin.axd_width = 100;
    [goLogin addTarget:self action:@selector(goLoginClick) forControlEvents:UIControlEventTouchUpInside];
    goLogin.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:goLogin];
    
}

-(void)goLoginClick
{
//    [self.navigationController pushViewController:[LoginViewController new] animated:YES];
    [self presentViewController:[LoginViewController new] animated:YES completion:nil];
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
