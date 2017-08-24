//
//  BaseViewController.m
//  ACHProject
//
//  Created by chenxiaohong on 2017/8/24.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import "BaseViewController.h"
#import "AXDTabbarController.h"
#import "AXDNavigationBarView.h"
@interface BaseViewController ()

@end

@implementation BaseViewController


-(id)init
{
    self=[super init];
    if (self) {
        _navBar=[AXDNavigationBarView navigationBar];
        _navBar.backgroundColor = [UIColor whiteColor];
        _navBar.textColor= kColor_title;
        [self.view addSubview:_navBar];
        
    }
    return self;
}

-(void)setTitleStr:(NSString *)titleStr
{
    _titleStr=titleStr;
    _navBar.title=titleStr;
}

-(void)setCenterImage:(UIImage *)centerImage
{
    _centerImage=centerImage;
    _navBar.centerImage=centerImage;
}

-(void)setLeftTitle:(NSString *)leftTitle
{
    _leftTitle=leftTitle;
    _navBar.leftTitle=leftTitle;
}

-(void)setLeftImage:(UIImage *)leftImage
{
    _leftImage=leftImage;
    _navBar.leftImage=leftImage;
}

-(void)setLeftItemsArray:(NSArray *)leftItemsArray
{
    _leftItemsArray=leftItemsArray;
    _navBar.leftItemsArray=leftItemsArray;
}

-(void)setRightItemsArray:(NSArray *)rightItemsArray
{
    _rightItemsArray=rightItemsArray;
    _navBar.rightItemsArray=rightItemsArray;
}

-(void)setRightImage:(UIImage *)rightImage
{
    _rightImage=rightImage;
    _navBar.rightImage=rightImage;
}

-(void)setRightTitle:(NSString *)rightTitle
{
    _rightTitle=rightTitle;
    _navBar.rightTitle=rightTitle;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [SVProgressHUD dismiss];//当前页面退出后，菊花消失
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
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
